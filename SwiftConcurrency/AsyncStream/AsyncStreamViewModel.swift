//
//  AsyncStreamViewModel.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 27/05/2025.
//

import Foundation

final class AsyncStreamViewModel: ObservableObject {
    @Published private(set) var currentNumber: Int = 0
    let manager = AsyncStreamDataManager()
    
    func onViewAppear() {
//        manager.getData { [weak self] value in
//            self?.currentNumber = value
//        }
        
        let task = Task {
            do {
                for try await value in manager.getAsyncStream() {
                    currentNumber = value
                }
            } catch {
                print(error)
            }
        }
        
//        task.cancel()
    }
 }
