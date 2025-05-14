//
//  ActorsView.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 14/05/2025.
//

import SwiftUI

class MyDataManager {
    static let instance = MyDataManager()
    
    private init() {}
    
    var data: [String] = []
    
    private let lock = DispatchQueue(label: "com.example.MyDataManager")
    
    func getRandomString(completionHandler: @escaping (String?) -> Void) {
        lock.async {
            let letters = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
            var s = ""
            for _ in 0..<Int.random(in: 5..<10) {
                let randomIndex = Int.random(in: 0..<letters.count)
                s.append(letters[randomIndex])
            }
            self.data.append(s)
            print(Thread.current)
            completionHandler(s)
        }
    }
}

actor MyActorDataManager {
    static let instance = MyActorDataManager()
    
    private init() {}
    
    var data: [String] = []
    
    func getRandomString() -> String? {
        let letters = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        var s = ""
        for _ in 0..<Int.random(in: 5..<10) {
            let randomIndex = Int.random(in: 0..<letters.count)
            s.append(letters[randomIndex])
        }
        self.data.append(s)
        print(Thread.current)
        return s
    }
    
    nonisolated func getData() -> String {
        return "Data"
    }
}

struct HomeView : View {
    let manager = MyActorDataManager.instance
    
    @State private var text: String = ""
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            
            Text(text)
                .font(.headline)
        }
        .onReceive(timer) { _ in
            Task {
                if let data = await manager.getRandomString() {
                    await MainActor.run {
                        self.text = data
                    }
                }
            }
        }
    }
}

struct BrowseView : View {
    let manager = MyDataManager.instance
    
    @State private var text: String = ""
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.yellow.ignoresSafeArea()
            
            Text(text)
                .font(.headline)
        }
        .onReceive(timer) { _ in
            DispatchQueue.global(qos: .background).async {
                manager.getRandomString { title in
                    if let data = title {
                        DispatchQueue.main.async {
                            self.text = data
                        }
                    }
                }
            }
        }
    }
}

struct ActorsView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            BrowseView()
                .tabItem {
                    Label("Browse", systemImage: "magnifyingglass")
                }
        }
    }
}

#Preview {
    ActorsView()
}
