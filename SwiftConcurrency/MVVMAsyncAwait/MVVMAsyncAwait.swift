//
//  MVVMAsyncAwait.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 20/05/2025.
//

import SwiftUI

struct MVVMAsyncAwait: View {
    @StateObject private var viewModel = MVVMAsyncAwaitViewModel()
    
    var body: some View {
        Button("Click me") {
            viewModel.onCallAction()
        }
    }
}

#Preview {
    MVVMAsyncAwait()
}
