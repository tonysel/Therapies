//
//  MedicinaleCore+CoreDataProperties.swift
//  
//
//  Created by TonySellitto on 16/05/18.
//
//

import Foundation
import CoreData


extension MedicinaleCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MedicinaleCore> {
        return NSFetchRequest<MedicinaleCore>(entityName: "MedicinaleCore")
    }

    @NSManaged public var codice: String?
    @NSManaged public var dosaggioFisso: Double
    @NSManaged public var imageUrl: String?
    @NSManaged public var misuraDosaggio: String?
    @NSManaged public var nome: String?
    @NSManaged public var dosaggioVaria: NSSet?

}

// MARK: Generated accessors for dosaggioVaria
extension MedicinaleCore {

    @objc(addDosaggioVariaObject:)
    @NSManaged public func addToDosaggioVaria(_ value: Dosaggio)

    @objc(removeDosaggioVariaObject:)
    @NSManaged public func removeFromDosaggioVaria(_ value: Dosaggio)

    @objc(addDosaggioVaria:)
    @NSManaged public func addToDosaggioVaria(_ values: NSSet)

    @objc(removeDosaggioVaria:)
    @NSManaged public func removeFromDosaggioVaria(_ values: NSSet)

}
