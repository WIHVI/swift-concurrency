//
//  GlobalActorView.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 14/05/2025.
//

import SwiftUI

struct GlobalActorView: View {
    @StateObject private var viewModel = GlobalActorViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                }
            }
        }
        .task {
            await viewModel.getData()
        }
    }
}

#Preview {
    GlobalActorView()
}
