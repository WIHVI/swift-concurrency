//
//  DataManager.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 14/05/2025.
//

import Foundation

@globalActor final class GlobalActorDataManager {
    static var shared = DataManager()
}

actor DataManager {
    func getDataFromDataBase() -> [String] {
        return ["one", "two", "three", "four"]
    }
}
