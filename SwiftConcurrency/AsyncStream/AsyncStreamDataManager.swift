//
//  AsyncStreamDataManager.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 27/05/2025.
//

import Foundation

class AsyncStreamDataManager {
    func getAsyncStream() -> AsyncThrowingStream<Int, Error> {
        AsyncThrowingStream { [weak self] continuation in
            self?.getData { value in
                continuation.yield(value)
            } onFinish: { error in
                if let error {
                    continuation.finish(throwing: error)
                } else {
                    continuation.finish()
                }
            }

        }
    }
    
    func getData(
        completion: @escaping (_ value: Int) -> Void,
        onFinish: @escaping (_ error: Error?) -> Void
    ) {
        let items: [Int] = Array(1...10)
        
        for item in items {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(item), execute: {
                completion(item)
                
                if item == items.last {
                    onFinish(nil)
                }
            })
        }
    }
}
