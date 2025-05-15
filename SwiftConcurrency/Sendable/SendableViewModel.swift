//
//  SendableViewModel.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 15/05/2025.
//

import Foundation

class SendableViewModel: ObservableObject {
    let manager = CurrentUserManager()
    
    func updateCurrentUserInfo() async {
        let info = MyClassUserInfo(name: "User Info")
        await manager.updateDatabase(userInfo: info)
    }
}
