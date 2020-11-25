//
//  Task+CoreDataClass.swift
//  ToDo
//
//  Created by Влад Барченков on 11.11.2020.
//
//

import Foundation
import CoreData

@objc(Task)
public class Task: NSManagedObject {

    convenience init() {
        self.init(entity: CoreDataStack.shared.entityForName(entityName: "Task"), insertInto: CoreDataStack.shared.persistentContainer.viewContext)
    }
}
