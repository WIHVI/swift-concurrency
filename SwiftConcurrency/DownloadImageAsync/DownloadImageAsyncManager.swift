//
//  DownloadImageAsyncManager.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 07/05/2025.
//

import SwiftUI
import Combine

class DownloadImageAsyncManager {
    let url = URL(string: "https://picsum.photos/200")!
    
    // Escaping
    func downloadImageWithEscaping(
        completionHandler: @escaping (_ image: UIImage?, _ error: Error?) -> Void
    ) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data,
                let image = UIImage(data: data),
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                completionHandler(nil, error)
                return
            }
            
            completionHandler(image, nil)
        }
        .resume()
    }
    
    // Combine
    func downloadImageWithCombine() -> AnyPublisher<UIImage?, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { (data: Data?, response: URLResponse?) -> UIImage? in
                guard
                    let data = data,
                    let image = UIImage(data: data),
                    let response = response as? HTTPURLResponse,
                    response.statusCode >= 200 && response.statusCode < 300 else {
                    return nil
                }
                return image
            }
            .mapError({ error in
                return error
            })
            .eraseToAnyPublisher()
    }
    
    // Async
    func dowlodnImageWithAsync() async throws -> UIImage? {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard
                let image = UIImage(data: data),
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                return nil
            }
            return image
        } catch {
            throw error
        }
    }
}
