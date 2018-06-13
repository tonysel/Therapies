//
//  PazienteCore+CoreDataClass.swift
//  
//
//  Created by TonySellitto on 16/05/18.
//
//

import Foundation
import CoreData


public class PazienteCore: NSManagedObject {
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
}
