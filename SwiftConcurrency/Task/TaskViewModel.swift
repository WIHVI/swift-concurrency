//
//  TaskViewModel.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 10/05/2025.
//

import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var image2: UIImage? = nil
    
    func fetchImage() async {
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        
        do {
            guard let url = URL(string: "https://picsum.photos/200") else {
                return
            }
            let (data, _) = try await URLSession.shared.data(from: url)
            
            self.image = UIImage(data: data)
        } catch {
            print(error.localizedDescription)
        }
        
//        try Task.checkCancellation()
    }
    
    func fetchImage2() async {
        do {
            guard let url = URL(string: "https://picsum.photos/200") else {
                return
            }
            let (data, _) = try await URLSession.shared.data(from: url)
            
            self.image2 = UIImage(data: data)
        } catch {
            print(error.localizedDescription)
        }
    }
}
