//
//  PazienteCore+CoreDataProperties.swift
//  
//
//  Created by TonySellitto on 16/05/18.
//
//

import Foundation
import CoreData
import UIKit


extension PazienteCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PazienteCore> {
        return NSFetchRequest<PazienteCore>(entityName: "PazienteCore")
    }

    @NSManaged public var codiceFiscale: String?
    @NSManaged public var cognome: String?
    @NSManaged public var nome: String?
    @NSManaged public var prossimoControllo: NSDate?
    @NSManaged public var ultimaModifica: NSDate?
    @NSManaged public var medicoControllo: MedicoCore?
    @NSManaged public var terapieFarmacologiche: NSSet?
    @NSManaged public var terapieNonFarmacologiche: NSSet?

}

// MARK: Generated accessors for terapieFarmacologiche
extension PazienteCore {

    @objc(addTerapieFarmacologicheObject:)
    @NSManaged public func addToTerapieFarmacologiche(_ value: TerapiaFarmacologicaCore)

    @objc(removeTerapieFarmacologicheObject:)
    @NSManaged public func removeFromTerapieFarmacologiche(_ value: TerapiaFarmacologicaCore)

    @objc(addTerapieFarmacologiche:)
    @NSManaged public func addToTerapieFarmacologiche(_ values: NSSet)

    @objc(removeTerapieFarmacologiche:)
    @NSManaged public func removeFromTerapieFarmacologiche(_ values: NSSet)

}

// MARK: Generated accessors for terapieNonFarmacologiche
extension PazienteCore {

    @objc(addTerapieNonFarmacologicheObject:)
    @NSManaged public func addToTerapieNonFarmacologiche(_ value: TerapiaNonFarmacologicaCore)

    @objc(removeTerapieNonFarmacologicheObject:)
    @NSManaged public func removeFromTerapieNonFarmacologiche(_ value: TerapiaNonFarmacologicaCore)

    @objc(addTerapieNonFarmacologiche:)
    @NSManaged public func addToTerapieNonFarmacologiche(_ values: NSSet)

    @objc(removeTerapieNonFarmacologiche:)
    @NSManaged public func removeFromTerapieNonFarmacologiche(_ values: NSSet)
  
//        public static func invert(setTerapieNonFarmacologicheCore: Set<TerapiaNonFarmacologicaCore>) -> [TerapiaNonFarmacologica] {
//            var array = [TerapiaNonFarmacologica]()
//            let appDelegate = UIApplication.shared.delegate as? AppDelegate
//            for terapiaNonFarmacologicaCore in setTerapieNonFarmacologicheCore {
//    
//                let terapiaNonFarmacologica = TerapiaNonFarmacologica(codice: terapiaNonFarmacologicaCore.codice!, nome: terapiaNonFarmacologicaCore.nome!, cadenza: terapiaNonFarmacologicaCore.cadenza!, raccomandazioni: terapiaNonFarmacologicaCore.raccomandazioni!, tipoOrario: terapiaNonFarmacologicaCore.tipoOrario!)
//    
//                    terapiaNonFarmacologica.aggiungiOrarioEsatto(orario: terapiaNonFarmacologicaCore.o)
//                    //            terapiaNonFarmacologicaCore.nome = terapiaNonFarmacologica.getNome()
//                    //            terapiaNonFarmacologicaCore.codice = terapiaNonFarmacologica.getCodice()
//                    //            terapiaNonFarmacologicaCore.cadenza = terapiaNonFarmacologica.getCadenza()
//                    //            terapiaNonFarmacologicaCore.raccomandazioni = terapiaNonFarmacologica.getRaccomandazioni()
//                    //            terapiaNonFarmacologicaCore.orarioLibero = Int16(terapiaNonFarmacologica.getOrarioLibero())
//                    //            terapiaNonFarmacologicaCore.tipoOrario = terapiaNonFarmacologica.getTipoOrario()
//                    //
//                    //            terapiaNonFarmacologicaCore.orariApprossimati = OrarioApprossimato.convert(dictionary: terapiaNonFarmacologica.getOrarioApprossimato())
//                    //            terapiaNonFarmacologicaCore.orariEsatti = OrarioEsatto.convert(array: terapiaNonFarmacologica.getOrarioEsatto())
//    
//                    array.append(terapiaNonFarmacologica)
//            }
//    
//            return array
//        }
    
}
