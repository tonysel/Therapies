//
//  OrarioEsatto+CoreDataProperties.swift
//  
//
//  Created by TonySellitto on 16/05/18.
//
//

import Foundation
import CoreData
import UIKit


extension OrarioEsatto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrarioEsatto> {
        return NSFetchRequest<OrarioEsatto>(entityName: "OrarioEsatto")
    }

    @NSManaged public var orario: String?
    
    public static func convert(array: [String]) -> NSSet {
        var set = Set<OrarioEsatto>()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
         
        for key in array {
          
            let orarioEsatto = OrarioEsatto(context: (appDelegate?.persistentContainer.viewContext)!)
            orarioEsatto.orario = String(key)
            
            set.insert(orarioEsatto)
        }
        
        return set as NSSet
    }

}
