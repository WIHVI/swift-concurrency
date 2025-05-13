//
//  StructClassActor.swift
//  SwiftConcurrency
//
//  Created by Mihai Cojocaru on 13/05/2025.
//

/*
 VALUE TYPES:
 - Struct, Enum, String, Int, etc.
 - Stored in the Stack
 - Faster
 - Thread safe
 - Create a new copy
 
 REFERENCE TYPES:
 - Class, Function, Actor
 - Stored in the Heap
 - Slower, but synchronized
 - Not thread safe
 - A new reference of the original class will be created(pointer)
 
 STACK:
 - Stores value types
 - Stored directly to the memory, and accesso this memory is very fast
 - Each thread has its own stack
 
 HEAP:
 - Stores reference types
 - Shared across threads
 
 STRUCT:
 - Based on Values
 - Can be mutated
 - Stored in the Stack
 
 CLASS:
 - Based on References(Instances)
 - Can not be mutated
 - Stored in the Heap
 - Inherit from other Classes
 
 ACTOR:
 - Same as Class but thread safe
 
 Structs: Data Models, Views
 Classes: View Models
 Actors: Shared "Manager" and "Data Store"
*/

import SwiftUI

class StructClassActorViewModel: ObservableObject {
    @Published var isActive: Bool = false
}

struct StructClassActor: View {
    @StateObject private var viewModel = StructClassActorViewModel()

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .foregroundColor(viewModel.isActive ? Color.red : Color.green)
            .onAppear {
                runTest()
            }
    }
}

struct StructClassActor2: View {
    @StateObject private var viewModel = StructClassActorViewModel()
    var body: some View {
        StructClassActor()
            .onTapGesture {
                viewModel.isActive.toggle()
            }
    }
}

#Preview {
    StructClassActor()
}

struct MyStruct {
    var title: String
}

class MyClass {
    var title: String
    init(title: String) {
        self.title = title
    }
}

actor MyActor {
    var title: String
    init(title: String) {
        self.title = title
    }
    
    func updateTitle(_ newTitle: String) {
        self.title = newTitle
    }
}

extension StructClassActor {
    private func runTest() {
        print("Test started!")
        structTest1()
        print("Test started!")
        classTest1()
        print("Test started!")
        actorTest1()
    }
    
    private func structTest1() {
        let objectA = MyStruct(title: "Starting title!")
        print("ObjectA: ", objectA.title)
        
        var objectB = objectA
        print("ObjectB: ", objectB.title)
        
        objectB.title = "Second title!"
        print("ObjectA: ", objectA.title)
        print("ObjectB: ", objectB.title)
    }
    
    private func classTest1() {
        let objectA = MyClass(title: "Starting title!")
        print("ObjectA: ", objectA.title)
        
        let objectB = objectA
        print("ObjectB: ", objectB.title)
        
        objectB.title = "Second title!"
        print("ObjectA: ", objectA.title)
        print("ObjectB: ", objectB.title)
    }
    
    private func actorTest1() {
        Task {
            let objectA = MyActor(title: "Starting title!")
            await print("ObjectA: ", objectA.title)
            
            let objectB = objectA
            await print("ObjectB: ", objectB.title)
            
            await objectB.updateTitle("Second title!")
            await print("ObjectA: ", objectA.title)
            await print("ObjectB: ", objectB.title)
        }
    }
}


