//
//  AsyncPublisherManager.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 15/05/2025.
//

import Foundation

actor AsyncPublisherManager {
    @Published var myData: [String] = []
    
    func addData() async {
        myData.append("Apple")
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        myData.append("Banana")
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        myData.append("Orange")
    }
}
