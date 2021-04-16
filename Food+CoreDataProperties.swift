//
//  Food+CoreDataProperties.swift
//  Food Journal App
//
//  Created by Ikmal Azman on 16/04/2021.
//
//

import Foundation
import CoreData


extension Food
{

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Food> {
        return NSFetchRequest<Food>(entityName: "Food")
    }

    @NSManaged public var date: String?
    @NSManaged public var foodDesc: String?
    @NSManaged public var foodImg: Data?

}

extension Food : Identifiable {

}
