//
//  SearchableManager.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 23/05/2025.
//

import Foundation

struct Restaurant: Identifiable, Hashable {
    let id: String
    let title: String
    let cuisine: CuisineOption
}

enum CuisineOption: String, CaseIterable {
    case american, italian, japanese
}

final class RestaurantManager {
    func getAllRestaurants() async throws -> [Restaurant] {
        Array(1...100).map { id in
            Restaurant(
                id: "\(id)",
                title: "Restaurant \(id)",
                cuisine: .allCases.randomElement()!
            )
        }
    }
}
