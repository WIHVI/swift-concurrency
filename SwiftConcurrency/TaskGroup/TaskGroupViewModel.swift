//
//  TaskGroupViewModel.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 12/05/2025.
//

import SwiftUI

class TaskGroupViewModel: ObservableObject {
    let manager = TaskGroupManager()
    
    @Published var images: [UIImage] = []
    
    func getImages() async {
        if let images = try? await manager.fetchImagesWithTaskGroup() {
            self.images.append(contentsOf: images)
        }
    }
}
