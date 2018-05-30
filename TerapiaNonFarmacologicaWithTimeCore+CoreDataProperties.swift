//
//  TerapiaNonFarmacologicaWithTimeCore+CoreDataProperties.swift
//  
//
//  Created by TonySellitto on 29/05/18.
//
//

import Foundation
import CoreData


extension TerapiaNonFarmacologicaWithTimeCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TerapiaNonFarmacologicaWithTimeCore> {
        return NSFetchRequest<TerapiaNonFarmacologicaWithTimeCore>(entityName: "TerapiaNonFarmacologicaWithTimeCore")
    }

    @NSManaged public var id: String?
    @NSManaged public var time: NSDate?
    @NSManaged public var orario: String?
    @NSManaged public var quando: String?
    @NSManaged public var value: Double
    @NSManaged public var nome: String?
    @NSManaged public var raccomandazioni: String?
    @NSManaged public var ripetizioni: Int16
    @NSManaged public var codiceTer: String?

}
