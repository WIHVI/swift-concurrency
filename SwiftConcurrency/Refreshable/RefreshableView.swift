//
//  RefreshableView.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 20/05/2025.
//

import SwiftUI

struct RefreshableView: View {
    @StateObject private var viewModel = RefreshableViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(viewModel.items, id: \.self) { item in
                        Text(item)
                            .font(.headline)
                    }
                }
            }
            .refreshable {
                await viewModel.loadData()
            }
            .navigationTitle("Refreshalbe")
            .task {
                await viewModel.loadData()
            }
        }
    }
}

#Preview {
    RefreshableView()
}
