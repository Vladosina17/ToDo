//
//  Task+CoreDataProperties.swift
//  ToDo
//
//  Created by Влад Барченков on 11.11.2020.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var headline: String?
    @NSManaged public var mainText: String?

}

extension Task : Identifiable {

}
