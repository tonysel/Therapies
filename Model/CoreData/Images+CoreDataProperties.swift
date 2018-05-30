//
//  Images+CoreDataProperties.swift
//  
//
//  Created by TonySellitto on 27/05/18.
//
//

import Foundation
import CoreData


extension Images {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Images> {
        return NSFetchRequest<Images>(entityName: "Images")
    }

    @NSManaged public var image: NSData?
    @NSManaged public var name: String?

}
