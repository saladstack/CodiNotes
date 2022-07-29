//
//  Item+CoreDataProperties.swift
//  test
//
//  Created by Shaqina Yasmin on 27/07/22.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var timestamp: Date?
    @NSManaged public var title: String?
    @NSManaged public var content: String?

}

extension Item : Identifiable {

}
