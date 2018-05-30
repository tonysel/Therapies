//
//  TerapiaNonFarmacologicaCore+CoreDataProperties.swift
//  
//
//  Created by TonySellitto on 16/05/18.
//
//

import Foundation
import CoreData
import UIKit


extension TerapiaNonFarmacologicaCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TerapiaNonFarmacologicaCore> {
        return NSFetchRequest<TerapiaNonFarmacologicaCore>(entityName: "TerapiaNonFarmacologicaCore")
    }

    @NSManaged public var cadenza: String?
    @NSManaged public var codice: String?
    @NSManaged public var nome: String?
    @NSManaged public var orarioLibero: Int16
    @NSManaged public var raccomandazioni: String?
    @NSManaged public var tipoOrario: String?
    @NSManaged public var orariApprossimati: NSSet?
    @NSManaged public var orariEsatti: NSSet?

}

// MARK: Generated accessors for orariApprossimati
extension TerapiaNonFarmacologicaCore {

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
extension TerapiaNonFarmacologicaCore {

    @objc(addOrariEsattiObject:)
    @NSManaged public func addToOrariEsatti(_ value: OrarioEsatto)

    @objc(removeOrariEsattiObject:)
    @NSManaged public func removeFromOrariEsatti(_ value: OrarioEsatto)

    @objc(addOrariEsatti:)
    @NSManaged public func addToOrariEsatti(_ values: NSSet)

    @objc(removeOrariEsatti:)
    @NSManaged public func removeFromOrariEsatti(_ values: NSSet)
    
    public static func convert(array: [TerapiaNonFarmacologica]) -> NSSet {
        var set = Set<TerapiaNonFarmacologicaCore>()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        for terapiaNonFarmacologica in array {
            
            let terapiaNonFarmacologicaCore = TerapiaNonFarmacologicaCore(context: (appDelegate?.persistentContainer.viewContext)!)
            terapiaNonFarmacologicaCore.nome = terapiaNonFarmacologica.getNome()
            terapiaNonFarmacologicaCore.codice = terapiaNonFarmacologica.getCodice()
            terapiaNonFarmacologicaCore.cadenza = terapiaNonFarmacologica.getCadenza()
            terapiaNonFarmacologicaCore.raccomandazioni = terapiaNonFarmacologica.getRaccomandazioni()
            terapiaNonFarmacologicaCore.orarioLibero = Int16(terapiaNonFarmacologica.getOrarioLibero())
            terapiaNonFarmacologicaCore.tipoOrario = terapiaNonFarmacologica.getTipoOrario()
            
            terapiaNonFarmacologicaCore.orariApprossimati = OrarioApprossimato.convert(dictionary: terapiaNonFarmacologica.getOrarioApprossimato())
            terapiaNonFarmacologicaCore.orariEsatti = OrarioEsatto.convert(array: terapiaNonFarmacologica.getOrarioEsatto())
           
            set.insert(terapiaNonFarmacologicaCore)
        }
        
        return set as NSSet
    }

}
