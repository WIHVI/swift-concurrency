//
//  ObservableMacroView.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 30/05/2025.
//

import SwiftUI

struct ObservableMacroView: View {
    @State private var viewModel = ObservableMacroViewModel()
    
    var body: some View {
        Text(viewModel.title)
//            .task {
//                await viewModel.updateTitle()
//            }
            .onAppear {
                viewModel.updateTitle()
            }
    }
}

#Preview {
    ObservableMacroView()
}
