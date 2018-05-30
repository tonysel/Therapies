//
//  OrarioApprossimato+CoreDataProperties.swift
//  
//
//  Created by TonySellitto on 16/05/18.
//
//

import Foundation
import CoreData
import UIKit


extension OrarioApprossimato {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrarioApprossimato> {
        return NSFetchRequest<OrarioApprossimato>(entityName: "OrarioApprossimato")
    }

    @NSManaged public var pranzo: String?
    @NSManaged public var quando: String?
    
    
    public static func convert(dictionary: [String:String]) -> NSSet {
        var set = Set<OrarioApprossimato>()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        for key in dictionary.keys {
            let orarioApprossimato = OrarioApprossimato(context: (appDelegate?.persistentContainer.viewContext)!)
            orarioApprossimato.pranzo = String(key)
            orarioApprossimato.quando = dictionary[key]!
            set.insert(orarioApprossimato)
        }
        
        return set as NSSet
    }


}
