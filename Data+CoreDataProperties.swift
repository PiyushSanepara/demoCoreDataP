//
//  Data+CoreDataProperties.swift
//  DemoCoreData
//
//  Created by Ratnakala21 on 1/23/16.
//  Copyright © 2016 Ratnakala21. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Data {

    @NSManaged var name: String?
    @NSManaged var contact: String?
    @NSManaged var standard: String?

}
