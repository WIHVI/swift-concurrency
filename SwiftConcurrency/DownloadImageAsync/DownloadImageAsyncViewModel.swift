//
//  DownloadImageAsyncViewModel.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 07/05/2025.
//

import SwiftUI
import Combine

class DownloadImageAsyncViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var error: BasicError? = nil
    var cancellables = Set<AnyCancellable>()
    
    let manager = DownloadImageAsyncManager()
    
    func fetchImage() async {
        /*manager.downloadImageWithEscaping { [weak self] image, error in
            if let image {
                DispatchQueue.main.async {
                    self?.image = image
                }
            } else if let error {
                self?.error = BasicError(message: error.localizedDescription)
            }
        }*/
        
        /*manager.downloadImageWithCombine()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.error = BasicError(message: "\(error)")
            } receiveValue: { [weak self] image in
                self?.image = image
            }
            .store(in: &cancellables)*/

        do {
            let image = try await manager.dowlodnImageWithAsync()
            await MainActor.run { self.image = image }
        } catch {
            self.error = BasicError(message: error.localizedDescription)
        }
    }
}

struct BasicError: Identifiable {
    let id: UUID = UUID()
    let message: String
}
