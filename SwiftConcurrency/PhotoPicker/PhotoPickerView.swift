//
//  PhotoPickerView.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 26/05/2025.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: View {
    @StateObject private var viewModel = PhotoPickerViewModel()
    
    var body: some View {
        VStack(spacing: 4) {
            if let image = viewModel.selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
            
            PhotosPicker(selection: $viewModel.imageSelection, matching: .images) {
                Text("Open the photo picker")
            }
            
            if !viewModel.selectedImages.isEmpty {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(viewModel.selectedImages, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                }
            }
            
            PhotosPicker(selection: $viewModel.imageSelections, matching: .images) {
                Text("Open the photo picker")
            }
        }
    }
}

#Preview {
    PhotoPickerView()
}
