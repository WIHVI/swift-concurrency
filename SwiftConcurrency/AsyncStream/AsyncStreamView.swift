//
//  AsyncStreamView.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 27/05/2025.
//

import SwiftUI

struct AsyncStreamView: View {
    @StateObject private var viewModel = AsyncStreamViewModel()
    
    var body: some View {
        Text("\(viewModel.currentNumber)")
            .onAppear {
                viewModel.onViewAppear()
            }
    }
}

#Preview {
    AsyncStreamView()
}
