//
//  MVVMAsyncAwaitManager.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 20/05/2025.
//

import Foundation

class ManagerClass {
    func getData() async throws -> String {
        "Some Data!"
    }
}

actor ManagerActor {
    func getData() async throws -> String {
        "Some Data!"
    }
}
