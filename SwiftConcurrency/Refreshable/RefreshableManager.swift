//
//  RefreshableManager.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 20/05/2025.
//

import Foundation

final class RefreshableManager {
    func getData() async throws -> [String] {
        ["Apple", "Orange", "Bannana"].shuffled()
    }
}
