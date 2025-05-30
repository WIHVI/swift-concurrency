//
//  ObservableMacroViewModel.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 30/05/2025.
//

import Foundation

@Observable
class ObservableMacroViewModel: ObservableObject {
    @MainActor
    var title: String = "Starting title!"
    
    @ObservationIgnored
    let manager = ObservableMacroManager()
    
    @MainActor
    func updateTitle() {
//        title = await manager.getNewTitle()
        
//        let title = await manager.getNewTitle()
//        await MainActor.run {
//            self.title = title
//        }
        
        Task { @MainActor in
            title = await manager.getNewTitle()
        }
    }
}
