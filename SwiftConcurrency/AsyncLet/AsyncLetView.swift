//
//  AsyncLetView.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 12/05/2025.
//

import SwiftUI

struct AsyncLetView: View {
    @StateObject private var viewModel = AsyncLetViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: viewModel.columns) {
                    ForEach(viewModel.images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    }
                }
            }
            .navigationTitle("Async Let")
            .onAppear {
                Task {
                    do {
                        async let fetch1 = viewModel.fetchImage()
                        async let fetch2 = viewModel.fetchImage()
                        
                        let (image1, image2) = await (try fetch1, try fetch2)
                        viewModel.images.append(contentsOf: [image1, image2])
                        
                        let image = try await viewModel.fetchImage()
                        viewModel.images.append(image)
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}

#Preview {
    AsyncLetView()
}
