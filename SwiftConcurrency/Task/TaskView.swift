//
//  TaskView.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 10/05/2025.
//

import SwiftUI

struct TaskView: View {
    @StateObject private var viewModel = TaskViewModel()
//    @State private var fetchImageTask: Task<(), Never>? = nil
    
    var body: some View {
        VStack(spacing: 40) {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
            }
            
            if let image2 = viewModel.image2 {
                Image(uiImage: image2)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
            }
        }
        .task {
            await viewModel.fetchImage()
        }
//        .onDisappear() {
//            fetchImageTask?.cancel()
//        }
        .onAppear {
//            fetchImageTask = Task {
//                print(Thread.current)
//                print(Task.currentPriority)
//                await viewModel.fetchImage()
//            }
//            Task {
//                await viewModel.fetchImage2()
//                print(Thread.current)
//                print(Task.currentPriority)
//            }
            
            /*Task(priority: .low) {
                print("Low: \(Thread.current) : \(Task.currentPriority)")
            }
            
            Task(priority: .medium) {
                print("Medium: \(Thread.current) : \(Task.currentPriority)")
            }
            
            Task(priority: .high) {
                print("High: \(Thread.current) : \(Task.currentPriority)")
            }
            
            Task(priority: .background) {
                print("Background: \(Thread.current) : \(Task.currentPriority)")
            }
            
            Task(priority: .userInitiated) {
                print("UserInitialized: \(Thread.current) : \(Task.currentPriority)")
            }*/
            
            /*Task(priority: .low) {
                print("Low: \(Thread.current) : \(Task.currentPriority)")
                
                Task.detached {
                    print("Detached: \(Thread.current) : \(Task.currentPriority)")
                }
            }*/
            
            
        }
    }
}

#Preview {
    TaskView()
}
