//
//  SendableView.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 15/05/2025.
//

import SwiftUI

struct SendableView: View {
    @StateObject private var viewModel = SendableViewModel()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SendableView()
}
