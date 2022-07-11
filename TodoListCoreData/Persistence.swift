//
//  Persistence.swift
//  TodoListCoreData
//
//  Created by Tenzin wangyal on 7/9/22.
//

import CoreData

struct PersistenceController{
     static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "TodoList")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved Error \(error)")
            }
        }
    }
}
