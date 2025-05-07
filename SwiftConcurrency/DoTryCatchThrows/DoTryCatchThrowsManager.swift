//
//  DoTryCatchThrowsManager.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 07/05/2025.
//

import Foundation

class DoTryCatchThrowsManager {
    let isActive: Bool = true
    
    func getTitle() -> (title: String?, error: Error?) {
        if isActive {
            return ("New Text (Active).", nil)
        }
        
        return (nil, URLError(.badURL))
    }
    
    func getTitle2() -> Result<String, Error> {
        if isActive {
            return .success("New Text.")
        }
        
        return .failure(URLError(.badURL))
    }
    
    func getTitle3() throws -> String {
        if isActive {
            return "New Text."
        }
        
        throw URLError(.badURL)
    }
    
    func getTitle4() throws -> String {
        if isActive {
            return "Final Text."
        }
        
        throw URLError(.badURL)
    }
}
