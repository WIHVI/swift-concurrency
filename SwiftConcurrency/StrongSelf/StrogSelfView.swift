//
//  StrogSelfView.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 19/05/2025.
//

import SwiftUI

struct StrogSelfView: View {
    @StateObject private var viewModel = StrongSelfViewModel()
    
    var body: some View {
        Text(viewModel.data)
            .onAppear {
                viewModel.updateData()
            }
            .onDisappear {
                viewModel.cancelSomeTask()
            }
            .task {
                viewModel.updateData8()
            }
    }
}

#Preview {
    StrogSelfView()
}
