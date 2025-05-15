//
//  AsyncPublisherViewModel.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 15/05/2025.
//

import Foundation

class AsyncPublisherViewModel: ObservableObject {
    @MainActor @Published var dataArray: [String] = []
    
    let manager = AsyncPublisherManager()
    
//    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        
        Task {
            for await value in await manager.$myData.values {
                await MainActor.run {
                    self.dataArray = value
                }
            }
        }
        
        /*manager.addData
            .receive(on: DispatchQueue.main)
            .sink { dataArray in
                self.dataArray = dataArray
            }
            .store(in: &cancellables)*/
    }
    
    func start() async {
        await manager.addData()
    }
}
