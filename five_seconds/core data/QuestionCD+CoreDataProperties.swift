//
//  QuestionCD+CoreDataProperties.swift
//  5second
//
//  Created by Maximal Mac on 01.08.2018.
//  Copyright © 2018 vz. All rights reserved.
//
//

import Foundation
import CoreData


extension QuestionCD: EntityCreating {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuestionCD> {
        return NSFetchRequest<QuestionCD>(entityName: "QuestionCD")
    }

    @NSManaged public var text: String?
    @NSManaged public var count: Int64

}
