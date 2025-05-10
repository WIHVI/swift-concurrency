//
//  AsyncAwaitViewModel.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 09/05/2025.
//

import Foundation

class AsyncAwaitViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    
    func addTitle1() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dataArray.append("Title 1: \(Thread.current)")
        }
    }
    
    func addTitle2() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let title = "Title 2: \(Thread.current)"
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.dataArray.append(title)
                
                self.dataArray.append("Title 3: \(Thread.current)")
            }
        }
    }
    
    func addAuthor1() async {
        let author1 = "Author 1: \(Thread.current)"
        dataArray.append(author1)
        
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        let author2 = "Author 2: \(Thread.current)"
        await MainActor.run {
            dataArray.append(author2)
            
            let author3 = "Author 3: \(Thread.current)"
            dataArray.append(author3)
        }
        
        await addSomething()
    }
    
    func addSomething() async {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        let something1 = "Something 1: \(Thread.current)"
        await MainActor.run {
            dataArray.append(something1)
            
            let something2 = "Something 2: \(Thread.current)"
            dataArray.append(something2)
        }
    }
}
