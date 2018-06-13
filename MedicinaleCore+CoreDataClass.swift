//
//  MedicinaleCore+CoreDataClass.swift
//  
//
//  Created by TonySellitto on 16/05/18.
//
//

import Foundation
import CoreData

//@objc(MedicinaleCore)
public class MedicinaleCore: NSManagedObject {
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
}
