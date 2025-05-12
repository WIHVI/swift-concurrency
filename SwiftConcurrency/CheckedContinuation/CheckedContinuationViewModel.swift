//
//  CheckedContinuationViewModel.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 12/05/2025.
//

import SwiftUI

class CheckedContinuationViewModel: ObservableObject {
    let manager = CheckedContinuationManager()
    
    @Published var image: UIImage? = nil
    
    func getImage() async {
        guard let url = URL(string: "https://picsum.photos/200") else { return }
        
        do {
            let data = try await manager.getData2(url: url)
            
            if let image = UIImage(data: data) {
                await MainActor.run {
                    self.image = image
                }
            }
        } catch {
            print(error)
        }
    }
}
