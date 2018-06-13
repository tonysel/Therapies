//
//  Dosaggio+CoreDataProperties.swift
//  
//
//  Created by TonySellitto on 17/05/18.
//
//

import Foundation
import CoreData


extension Dosaggio {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dosaggio> {
        return NSFetchRequest<Dosaggio>(entityName: "Dosaggio")
    }

    @NSManaged public var giorno: Int16
    @NSManaged public var qta: Double

}
