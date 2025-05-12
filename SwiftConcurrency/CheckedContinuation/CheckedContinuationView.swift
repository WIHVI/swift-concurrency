//
//  CheckedContinuationView.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 12/05/2025.
//

import SwiftUI

struct CheckedContinuationView: View {
    @StateObject private var viewModel = CheckedContinuationViewModel()
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
        }
        .task {
            await viewModel.getImage()
        }
    }
}

#Preview {
    CheckedContinuationView()
}
