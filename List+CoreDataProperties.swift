//
//  List+CoreDataProperties.swift
//  iTao
//
//  Created by MIchelle Grover on 2/16/16.
//  Copyright © 2016 Norbert Grover. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension List {

    @NSManaged var lTitle: String?
    @NSManaged var lDesc: String?
    @NSManaged var lImage: NSData?
    @NSManaged var lVideo: String?

}
