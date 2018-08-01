//
//  PlayerCD+CoreDataProperties.swift
//  5second
//
//  Created by Maximal Mac on 01.08.2018.
//  Copyright © 2018 vz. All rights reserved.
//
//

import Foundation
import CoreData


extension PlayerCD: EntityCreating {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayerCD> {
        return NSFetchRequest<PlayerCD>(entityName: "PlayerCD")
    }

    @NSManaged public var name: String?
    @NSManaged public var avatarKey: String?
    @NSManaged public var id: Int64

}
