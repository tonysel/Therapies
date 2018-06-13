//
//  TerapiaNonFarmacologicaWithTimeCore+CoreDataProperties.swift
//  
//
//  Created by TonySellitto on 13/06/18.
//
//

import Foundation
import CoreData


extension TerapiaNonFarmacologicaWithTimeCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TerapiaNonFarmacologicaWithTimeCore> {
        return NSFetchRequest<TerapiaNonFarmacologicaWithTimeCore>(entityName: "TerapiaNonFarmacologicaWithTimeCore")
    }

    @NSManaged public var codiceTer: String?
    @NSManaged public var id: String?
    @NSManaged public var nome: String?
    @NSManaged public var orario: String?
    @NSManaged public var quando: String?
    @NSManaged public var raccomandazioni: String?
    @NSManaged public var ripetizioni: Int16
    @NSManaged public var time: NSDate?
    @NSManaged public var tipoOrario: String?
    @NSManaged public var value: Double

}
