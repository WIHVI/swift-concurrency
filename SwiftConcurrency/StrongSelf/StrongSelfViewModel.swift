//
//  StrongSelfViewModel.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 19/05/2025.
//

import Foundation

final class StrongSelfViewModel: ObservableObject {
    @Published var data: String = "Some title!"
    
    let dataService = StrongSelfDataService()
    
    private var someTask: Task<Void, Never>? = nil
    private var myTasks: [Task<Void, Never>] = []
    
    func cancelSomeTask() {
        someTask?.cancel()
        someTask = nil
        
        myTasks.forEach { task in
            task.cancel()
        }
        myTasks = []
    }
    
    // This implies a strong reference
    func updateData() -> Void {
        Task {
            data = await dataService.getData()
        }
    }
    
    // This is a strong reference
    func updateData2() -> Void {
        Task {
            self.data = await self.dataService.getData()
        }
    }
    
    // This is a strong reference
    func updateData3() -> Void {
        Task { [self] in
            self.data = await self.dataService.getData()
        }
    }
    
    // This is a weak reference
    func updateData4() -> Void {
        Task { [weak self] in
            if let data = await self?.dataService.getData() {
                self?.data = data
            }
        }
    }
    
    // We dont need to manage weak strong becouse we can manage the task
    func updateData5() -> Void {
        someTask = Task {
            self.data = await self.dataService.getData()
        }
    }
    
    // We dont need to manage weak strong becouse we can manage the task
    func updateData6() -> Void {
        let myTask1 = Task {
            self.data = await self.dataService.getData()
        }
        myTasks.append(myTask1)
        
        let myTask2 = Task {
            self.data = await self.dataService.getData()
        }
        myTasks.append(myTask2)
    }
    
    // We purposely do not cancel tasks to keep strong references
    func updateData7() -> Void {
        Task {
            data = await dataService.getData()
        }
        
        Task.detached {
            self.data = await self.dataService.getData()
        }
    }
    
    func updateData8() -> Void {
        Task {
            data = await dataService.getData()
        }
    }
}
