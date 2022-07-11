//
//  TodoListCoreDataApp.swift
//  TodoListCoreData
//
//  Created by Tenzin wangyal on 7/9/22.
//

import SwiftUI

@main
struct TodoListCoreDataApp: App {
    
    let persistenceContainer = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                
                .environment(\.managedObjectContext,persistenceContainer.container.viewContext)
                
        }
    }
}
