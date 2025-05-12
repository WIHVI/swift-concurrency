//
//  AsyncLetViewModel.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 12/05/2025.
//

import SwiftUI

class AsyncLetViewModel: ObservableObject {
    @Published var images: [UIImage] = []
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    func fetchImage() async throws -> UIImage {
        do {
            guard let url = URL(string: "https://picsum.photos/200") else {
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
