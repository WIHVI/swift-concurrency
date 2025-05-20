//
//  RefreshableViewModel.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 20/05/2025.
//

import Foundation

@MainActor
final class RefreshableViewModel: ObservableObject {
    @Published private(set) var items: [String] = []
    let manager = RefreshableManager()
    
    func loadData() async {
        do {
            items = try await manager.getData()
        } catch {
            print(error)
        }
    }
}
