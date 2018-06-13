//
//  MedicinaleCore+CoreDataProperties.swift
//  
//
//  Created by TonySellitto on 16/05/18.
//
//

import Foundation
import CoreData
import UIKit


extension MedicinaleCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MedicinaleCore> {
        return NSFetchRequest<MedicinaleCore>(entityName: "MedicinaleCore")
    }

    @NSManaged public var cod: String?
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
    
    public static func convert(array: [Medicinale]) -> NSSet {
        var set = Set<MedicinaleCore>()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        for medicinale in array {
            
            let medicinaleCore = MedicinaleCore(context: (appDelegate?.persistentContainer.viewContext)!)
            medicinaleCore.cod = medicinale.getCodice()
            medicinaleCore.dosaggioFisso = medicinale.getDosaggioFisso()
            
            medicinaleCore.misuraDosaggio = medicinale.getMisuraDosaggio()
            medicinaleCore.imageUrl = medicinale.getImageUrl()
            medicinaleCore.nome = medicinale.getNome()
            medicinaleCore.dosaggioVaria = Dosaggio.convert(dictionary: medicinale.getDosaggioVariabile())
            
            set.insert(medicinaleCore)
        }
        
        return set as NSSet
    }
    
    public static func invert(medicinaleCore: MedicinaleCore) -> Medicinale {
        
        //let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let medicinale = Medicinale(nome: medicinaleCore.nome!, codice: medicinaleCore.cod!, imageUrl: medicinaleCore.imageUrl!, misuraDosaggio: medicinaleCore.misuraDosaggio!, dosaggioFisso: medicinaleCore.dosaggioFisso)
        for row in medicinaleCore.dosaggioVaria! as! Set<Dosaggio>{
            medicinale.aggiungiDosaggioVariabile(giornoCambiamento: Int(row.giorno), dosaggio: row.qta)
            
        }
        
        
        return medicinale
    }

}
