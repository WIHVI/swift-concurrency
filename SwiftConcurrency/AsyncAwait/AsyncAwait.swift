//
//  AsyncAwait.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 09/05/2025.
//

import SwiftUI

struct AsyncAwait: View {
    @StateObject private var viewModel = AsyncAwaitViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.dataArray, id: \.self) { item in
                Text(item)  
            }
        }
        .onAppear() {
//            viewModel.addTitle1()
//            viewModel.addTitle2()
            
            Task {
                await viewModel.addAuthor1()
                
                let finalText = "FINAL TEXT \(Thread.current)"
                viewModel.dataArray.append(finalText)
            }
        }
    }
}

#Preview {
    AsyncAwait()
}
