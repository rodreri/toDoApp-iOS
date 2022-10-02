//
//  TaksDataManager.swift
//  ToDo
//
//  Created by Rafael González on 19/09/22.
//

import Foundation
import CoreData

class TaskDataManager{

    private var tasks : [Task] = []
    private var context : NSManagedObjectContext
    
    //Método para crear una instancia de tipo Task
    init(context : NSManagedObjectContext) {
        self.context = context
    }
    
    func fetch() -> [Task] {
        do {
            self.tasks = try self.context.fetch(Task.fetchRequest())
        }
        catch{
            print("err: ", error)
            return []
        }
        return tasks
    }
    
    func getTask(at index : Int) -> Task {
        return tasks[index]
    }
    
    func countTasks() -> Int {
        return tasks.count
    }
}



