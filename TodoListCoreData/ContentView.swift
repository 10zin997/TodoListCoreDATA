//
//  ContentView.swift
//  TodoListCoreData
//
//  Created by Tenzin wangyal on 7/9/22.
//

import SwiftUI
import CoreData

//MARK :- After you create a core data, a @Task class is created which conforms to @NSManagedObect protocol . To check you can command+click and jump to definition the Task below, it will take you to a read-only @Task class definition.
//struct Test{
//    let task: Task
//}


struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Task.date, ascending: false)]) //sort the task
    //tasks needs to be intilized, the above code is a work around.
    private var tasks : FetchedResults<Task>
    
    var body: some View {
        NavigationView{
            List{
                ForEach(tasks){ task in
                    Text(task.title ?? "Untitled")
                        .onTapGesture(count: 1, perform: {
                            updateTask(task)
                        })
                }
                .onDelete(perform: deleteTask) //function call for delete method
            }
            
            .navigationTitle("Todo List")
            .navigationBarItems(trailing: Button("Add Task"){
                addTask()
            })
        }
        
        
    }
    private func saveContext(){
        do{
            try viewContext.save()
        }catch{
            let error = error as NSError
            fatalError("Unresolved Error \(error)")
        }
    }
    //CRUD: CRU Delete
    //IndexSet: the exact row that you want deleted.
    private func deleteTask(offsets: IndexSet){
        withAnimation{
            offsets.map{ tasks[$0]}.forEach(viewContext.delete)
            saveContext()
        }
        
    }
    //CRUD: CR Update D
    private func updateTask(_ task: FetchedResults<Task>.Element){
    
            task.title = "Updated"
            saveContext()
   
        
    }
    //CRUD: Create RUD
    private func addTask(){
        withAnimation{
            let newTask = Task(context: viewContext)
            newTask.title = ("New Task \(Date())")
            newTask.date = Date()
            
            saveContext()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        //this will let you view your code in "preview" the build in
        //simulator
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
