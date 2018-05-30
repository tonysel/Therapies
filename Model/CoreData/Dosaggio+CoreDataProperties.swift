//
//  Dosaggio+CoreDataProperties.swift
//  
//
//  Created by TonySellitto on 16/05/18.
//
//

import Foundation
import CoreData
import UIKit


extension Dosaggio {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dosaggio> {
        return NSFetchRequest<Dosaggio>(entityName: "Dosaggio")
    }
    
    @NSManaged public var qta: Double
    @NSManaged public var giorno: Int16
    
    public static func convert(dictionary: [Int:Double]) -> NSSet {
        var set = Set<Dosaggio>()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        for key in dictionary.keys {
          
            let dosaggio = Dosaggio(context: (appDelegate?.persistentContainer.viewContext)!)
            dosaggio.giorno = Int16(key)
            dosaggio.qta = dictionary[key]!
            set.insert(dosaggio)
        }
        
        return set as NSSet
    }
   


}
