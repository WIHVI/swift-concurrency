//
//  CurrentUserManager.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 15/05/2025.
//

import Foundation

struct MyUserInfo: Sendable {
    let name: String
}

final class MyClassUserInfo: @unchecked Sendable {
    private var name: String
    let lock = DispatchQueue(label: "com.MyApp.MyClassUserInfo")
    init(name: String) {
        self.name = name
    }
    func updateName(_ newName: String) {
        lock.async {
            self.name = newName
        }
    }
}

actor CurrentUserManager {
    func updateDatabase(userInfo: MyClassUserInfo) {
        
    }
}
