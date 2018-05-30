//
//  MedicoCore+CoreDataProperties.swift
//  
//
//  Created by TonySellitto on 16/05/18.
//
//

import Foundation
import CoreData
import UIKit


extension MedicoCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MedicoCore> {
        return NSFetchRequest<MedicoCore>(entityName: "MedicoCore")
    }

    @NSManaged public var codice: String?
    @NSManaged public var cognome: String?
    @NSManaged public var nome: String?
    @NSManaged public var recapitoTelefonico: String?
    
    static func convert(medico: Medico) -> MedicoCore {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let medicoCore = MedicoCore(context: (appDelegate?.persistentContainer.viewContext)!)
        medicoCore.codice = medico.getCodice()
        medicoCore.nome = medico.getNome()
        medicoCore.cognome = medico.getCognome()
        medicoCore.recapitoTelefonico = medico.getRecapitoTelefonico()
        
        return medicoCore
    }

}
