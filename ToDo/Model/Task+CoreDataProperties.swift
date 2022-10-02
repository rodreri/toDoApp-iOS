//
//  Task+CoreDataProperties.swift
//  ToDo
//
//  Created by Rafael González on 18/09/22.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var id_task: UUID?
    @NSManaged public var title: String?
    @NSManaged public var date: Date?
    @NSManaged public var notes: String?

}

extension Task : Identifiable {

}
