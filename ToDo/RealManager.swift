//
//  RealManager.swift
//  ToDo
//
//  Created by Yahya Gahbiche on 2/12/24.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    private(set) var localRealm: Realm?
    @Published private(set) var tasks: [Task] = []
    
    init() {
        openRealm()
        getTasks()
    }
   
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1)
            
            Realm.Configuration.defaultConfiguration = config
            
            localRealm = try Realm()
            
        } catch {
            
            print("Enter opening Realm: \(error)")
        }
        
    }
    
    // CRUD
    // 1. CREATE: we create the function addTask() to add tasks to our Realm when users enter a new task
    
    func addTask(taskTitle: String) {
        if let localRealm = localRealm {
            do {
                try localRealm.write{
                    let newTask = Task(value: ["title": taskTitle, "completed": false] as [String : Any])
                    localRealm.add(newTask)
                    getTasks()
                    print("Added new taks to Realm: \(newTask)")
                }
            } catch {
               print("Error adding task to Realm \(error)")
            }
        }
    }
    
    // 2. READ: we create the function getTask() to read the input of users
    
    func getTasks() {
        if let localRealm = localRealm {
            let allTasks = localRealm.objects(Task.self).sorted(byKeyPath: "completed")
            tasks = []
            allTasks.forEach { task in
                tasks.append(task)
            }
        }
        
    }
    
   // 3. UPDATE: we create the function updateTask() to update the status of the tasks. A task can be updated based on the completed argument
                                      
    func updateTask(id: ObjectId, completed: Bool) {
        if let localRealm = localRealm {
            do {
                let taskToUpdate = localRealm.objects(Task.self).filter(NSPredicate(format: "id == %@", id))
                guard !taskToUpdate.isEmpty else { return }
                try localRealm.write {
                    taskToUpdate[0].completed = completed
                    getTasks()
                    print("Updated task with id \(id)! Completed status: \(completed)")
                }
            } catch {
                print("Error updating task \(id) to Realm: \(error)")
            }
        }
        
    }
                     
   // 4. DELETE: we create the function deletTask() to delete a task that users wishes to delete
                     
    func deleteTask(id: ObjectId) {
        if let localRealm = localRealm {
            do {
                let taskToDelete = localRealm.objects(Task.self).filter(NSPredicate(format: "id == %@", id))
                guard !taskToDelete.isEmpty else {return}
                
                try localRealm.write {
                    localRealm.delete(taskToDelete)
                    getTasks()
                    print("Deleted task with id \(id)")
                }
                
                
            } catch {
                print("Error deleting task \(id) from Realm: \(error)")
            }
        }
        
    }
}





























