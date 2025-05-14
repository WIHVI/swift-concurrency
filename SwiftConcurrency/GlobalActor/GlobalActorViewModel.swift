//
//  GlobalActorViewModel.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 14/05/2025.
//

import Foundation

//@MainActor
class GlobalActorViewModel: ObservableObject {
    @MainActor @Published var dataArray: [String] = []
    let manager = GlobalActorDataManager.shared
    
    @GlobalActorDataManager func getData() async {
        let data = await manager.getDataFromDataBase()
        await MainActor.run {
            self.dataArray = data
        }
    }
}
