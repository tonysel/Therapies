//
//  MedicinaleWithTimeCore+CoreDataProperties.swift
//  
//
//  Created by TonySellitto on 28/05/18.
//
//

import Foundation
import CoreData


extension MedicinaleWithTimeCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MedicinaleWithTimeCore> {
        return NSFetchRequest<MedicinaleWithTimeCore>(entityName: "MedicinaleWithTimeCore")
    }

    @NSManaged public var id: String?
    @NSManaged public var nome: String?
    @NSManaged public var tipoOrario: String?
    @NSManaged public var time: NSDate?
    @NSManaged public var orario: String?
    @NSManaged public var quando: String?
    @NSManaged public var dosaggio: NSNumber
    @NSManaged public var raccomandazioni: String?
    @NSManaged public var ultimaModifica: NSDate?
    @NSManaged public var codiceTer: String?
    @NSManaged public var ripetizioni: Int16
    @NSManaged public var codiceMed: String?
}
