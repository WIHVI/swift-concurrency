//
//  TaskGroupManager.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 12/05/2025.
//

import SwiftUI

class TaskGroupManager {
    func fetchImagesWithAsuncLet() async throws -> [UIImage] {
        async let fetchImage1 = fetchImage(url: "https://picsum.photos/200")
        async let fetchImage2 = fetchImage(url: "https://picsum.photos/200")
        
        let (image1, image2) = try await (fetchImage1, fetchImage2)
        
        return [image1, image2]
    }
    
    func fetchImagesWithTaskGroup() async throws -> [UIImage] {
        let urls = ["https://picsum.photos/200", "https://picsum.photos/200"]
        
        return try await withThrowingTaskGroup(of: UIImage?.self) { group in
            var images = [UIImage]()
            images.reserveCapacity(urls.count)
            
            for url in urls {
                group.addTask {
                    try? await self.fetchImage(url: url)
                }
            }
            
            for try await image in group {
                if let image {
                    images.append(image)
                }
            }
            
            return images
        }
    }
    
    private func fetchImage(url: String) async throws -> UIImage {
        do {
            guard let url = URL(string: url) else {
                throw URLError(.badURL)
            }
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                return image
            } else {
                throw URLError(.badServerResponse)
            }
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
}
