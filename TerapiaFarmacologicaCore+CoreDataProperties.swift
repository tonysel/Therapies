//
//  TerapiaFarmacologicaCore+CoreDataProperties.swift
//  
//
//  Created by TonySellitto on 16/05/18.
//
//

import Foundation
import CoreData
import UIKit

extension TerapiaFarmacologicaCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TerapiaFarmacologicaCore> {
        return NSFetchRequest<TerapiaFarmacologicaCore>(entityName: "TerapiaFarmacologicaCore")
    }

    @NSManaged public var cadenza: String?
    @NSManaged public var codice: String?
    @NSManaged public var orarioLibero: Int16
    @NSManaged public var raccomandazioni: String?
    @NSManaged public var tipoOrario: String?
    @NSManaged public var medicinali: NSSet?
    @NSManaged public var orariApprossimati: NSSet?
    @NSManaged public var orariEsatti: NSSet?

}

// MARK: Generated accessors for medicinali
extension TerapiaFarmacologicaCore {

    @objc(addMedicinaliObject:)
    @NSManaged public func addToMedicinali(_ value: MedicinaleCore)

    @objc(removeMedicinaliObject:)
    @NSManaged public func removeFromMedicinali(_ value: MedicinaleCore)

    @objc(addMedicinali:)
    @NSManaged public func addToMedicinali(_ values: NSSet)

    @objc(removeMedicinali:)
    @NSManaged public func removeFromMedicinali(_ values: NSSet)

}

// MARK: Generated accessors for orariApprossimati
extension TerapiaFarmacologicaCore {

    @objc(addOrariApprossimatiObject:)
    @NSManaged public func addToOrariApprossimati(_ value: OrarioApprossimato)

    @objc(removeOrariApprossimatiObject:)
    @NSManaged public func removeFromOrariApprossimati(_ value: OrarioApprossimato)

    @objc(addOrariApprossimati:)
    @NSManaged public func addToOrariApprossimati(_ values: NSSet)

    @objc(removeOrariApprossimati:)
    @NSManaged public func removeFromOrariApprossimati(_ values: NSSet)

}

// MARK: Generated accessors for orariEsatti
extension TerapiaFarmacologicaCore {

    @objc(addOrariEsattiObject:)
    @NSManaged public func addToOrariEsatti(_ value: OrarioEsatto)

    @objc(removeOrariEsattiObject:)
    @NSManaged public func removeFromOrariEsatti(_ value: OrarioEsatto)

    @objc(addOrariEsatti:)
    @NSManaged public func addToOrariEsatti(_ values: NSSet)

    @objc(removeOrariEsatti:)
    @NSManaged public func removeFromOrariEsatti(_ values: NSSet)
    
    public static func convert(array: [TerapiaFarmacologica]) -> NSSet {
        var set = Set<TerapiaFarmacologicaCore>()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        for terapiaFarmacologica in array {
            
            let terapiaFarmacologicaCore = TerapiaFarmacologicaCore(context: (appDelegate?.persistentContainer.viewContext)!)
            terapiaFarmacologicaCore.codice = terapiaFarmacologica.getCodice()
            terapiaFarmacologicaCore.cadenza = terapiaFarmacologica.getCadenza()
            terapiaFarmacologicaCore.raccomandazioni = terapiaFarmacologica.getRaccomandazioni()
            terapiaFarmacologicaCore.orarioLibero = Int16(terapiaFarmacologica.getOrarioLibero())
            terapiaFarmacologicaCore.tipoOrario = terapiaFarmacologica.getTipoOrario()
            
            terapiaFarmacologicaCore.orariApprossimati = OrarioApprossimato.convert(dictionary: terapiaFarmacologica.getOrarioApprossimato())
            terapiaFarmacologicaCore.orariEsatti = OrarioEsatto.convert(array: terapiaFarmacologica.getOrarioEsatto())
            terapiaFarmacologicaCore.medicinali = MedicinaleCore.convert(array: terapiaFarmacologica.getMedicinali())
            set.insert(terapiaFarmacologicaCore)
        }
        
        return set as NSSet
    }


}
