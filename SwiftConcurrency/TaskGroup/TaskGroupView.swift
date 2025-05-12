//
//  TaskGroupView.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 12/05/2025.
//

import SwiftUI

struct TaskGroupView: View {
    @StateObject private var viewModel = TaskGroupViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    }
                }
            }
            .navigationTitle("Task Group")
            .task {
                await viewModel.getImages()
            }
        }
    }
}

#Preview {
    TaskGroupView()
}
