//
//  DoTryCatchThrowsViewModel.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 07/05/2025.
//

import Foundation

class DoTryCatchThrowsViewModel: ObservableObject {
    @Published var text = "Starting text."
    
    let manager = DoTryCatchThrowsManager()
    
    func fetchTitle() {
        /*let returnedValue = manager.getTitle()
        if let newText = returnedValue.title {
            self.text = newText
        } else if let error = returnedValue.error {
            self.text = error.localizedDescription
        }*/
        
        /*let result = manager.getTitle2()
        
        switch result {
        case .success(let newText):
            self.text = newText
        case .failure(let error):
            self.text = error.localizedDescription
        }*/
        
        let newText = try? manager.getTitle3()
        if let newText {
            self.text = newText
        }
        
        do {
            let newText = try? manager.getTitle3()
            if let newText {
                self.text = newText
            }
            
            let finalText = try manager.getTitle4()
            self.text = finalText
        } catch let error {
            self.text = error.localizedDescription
        }
    }
}
