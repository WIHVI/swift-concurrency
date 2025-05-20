//
//  MVVMAsyncAwaitViewModel.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 20/05/2025.
//

import Foundation

@MainActor
class MVVMAsyncAwaitViewModel: ObservableObject {
    let managerClass = ManagerClass()
    let managerActor = ManagerActor()
    
    @Published private(set) var myData: String = "Starting text"
    private var tasks: [Task<Void, Never>] = []
    
    func cancelTasks() {
        tasks.forEach({ $0.cancel() })
        tasks = []
    }
    
    func onCallAction()  {
        let task = Task {
            do {
//                myData = try await managerClass.getData()
                myData = try await managerActor.getData()
            } catch {
                print(error)
            }
        }
        
        tasks.append(task)
    }
}
