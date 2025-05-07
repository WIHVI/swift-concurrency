//
//  DoTryCatchThrows.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 07/05/2025.
//

import SwiftUI

struct DoTryCatchThrows: View {
    @StateObject private var viewModel = DoTryCatchThrowsViewModel()
    var body: some View {
        Text(viewModel.text)
            .frame(width: 300, height: 300)
            .background(Color.blue)
            .onTapGesture {
                viewModel.fetchTitle()
            }
    }
}

#Preview {
    DoTryCatchThrows()
}
