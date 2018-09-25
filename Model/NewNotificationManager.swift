//
//  NewNotificationManager.swift
//  Tesi
//
//  Created by TonySellitto on 11/06/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit
import UserNotifications

class NewNotificationManager {
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var delegateNotification : NotificationManagerDelegate!

    
    static func createNotificationsForTerapieFarmacologiche (paziente: Paziente){
     
        for terapiaFarmacologica in paziente.getTerapieFarmacologiche(){
            
            for medicinale in terapiaFarmacologica.getMedicinali(){
                
                for specificDay in TraslationManager.convertStringDateToArrayIntDate(dayInString: terapiaFarmacologica.getCadenza()){
                    if (terapiaFarmacologica.getTipoOrario() == "orario_esatto"){
                        
                        for specificTime in TraslationManager.convertTimeInStringToDateArray(timeInString: terapiaFarmacologica.getOrarioEsatto()[0]){
                            
                            let notification = UNMutableNotificationContent()
                            
                            notification.sound = UNNotificationSound.default()
                            notification.title = "Terapia Farmacologica"
                            notification.subtitle = medicinale.getNome()
                            notification.badge = 1
                            
                            notification.categoryIdentifier = "actionCategory"
                            
                            let url = Bundle.main.url(forResource: "Images/medicinale", withExtension: "gif")
                            
                            if let attachment = try? UNNotificationAttachment(identifier: "image", url: url!, options: nil) {
                                notification.attachments = [attachment]
                            }

                            var finalDosaggio = Double()
                            
                            if medicinale.getDosaggioFisso() != 0{
                                notification.body = "\(medicinale.getDosaggioFisso() ) - \(medicinale.getMisuraDosaggio())"
                            }
                                
                                //dosaggio variabile
                                
                            else{
                                let currentDate = Date()
                                
                                var days = [Int]()
                                
                                for day in (medicinale.getDosaggioVariabile().keys){
                                    days.append(day)
                                }
                                
                                //Ricorda di ordinare perchè quando li mette precedentemente nell'array vengono messi in disordine
                                days.sort()
                                
                                var c = 0
                                
                                for day in days{
                                    
                                    if c < days.count - 1 {
                                        
                                        
                                        if (currentDate.days(from_date: (paziente.getUltimaModifica())) + 1 >= day && currentDate.days(from_date: (paziente.getUltimaModifica())) + 1 < days[c + 1]){
                                            
                                            notification.body = "\(medicinale.getDosaggioVariabile()[day]!) - \(medicinale.getMisuraDosaggio() )"
                                            finalDosaggio = medicinale.getDosaggioVariabile()[day]!
                                            break
                                            
                                        }
                                        
                                    }
                                        
                                    else{
                                        
                                        notification.body = "\(medicinale.getDosaggioVariabile()[days[c]]!) - \(medicinale.getMisuraDosaggio() )"
                                        finalDosaggio = medicinale.getDosaggioVariabile()[days[c]]!
                                        
                                    }
                                    
                                    c = c + 1
                                    
                                }
                                
                            }
                            
                            
                            if finalDosaggio != 0 || medicinale.getDosaggioFisso() != 0{
                                
                                // add notification
                                var dateComponents = DateComponents()
                                
                                dateComponents.weekday = specificDay
                                
//                                print(specificDay)
                                
                                let dateFormatter = DateFormatter.init()
                                
//                                dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
                                
                                dateFormatter.dateFormat = "HH"
                                
                                dateComponents.hour =  Int(dateFormatter.string(from: specificTime))
                                
                                dateFormatter.dateFormat = "mm"
                                
                                dateComponents.minute = Int(dateFormatter.string(from: specificTime))
                        
                                let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                                //let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
                                
//                                let lastDateFormatter = DateFormatter.init()
//                                lastDateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
//                                let lastDate = lastDateFormatter.string(from: Date())

                                let request = UNNotificationRequest(identifier: "\(terapiaFarmacologica.getCodice())-\(medicinale.getNome())-\(dateComponents.hour ?? 12):\(dateComponents.minute ?? 00)-\(specificDay)", content: notification, trigger: notificationTrigger)
                                
                                // Schedule the request.
                                let center = UNUserNotificationCenter.current()
                                
                                center.add(request) { (error : Error?) in
                                    if let theError = error {
                                        print("\(theError.localizedDescription)")
                                    }
                                }
                            }
                        }
                    }
                    
                    
                    if (terapiaFarmacologica.getTipoOrario() == "orario_libero"){
                        
                        
                        let notification = UNMutableNotificationContent()
                        
                        notification.sound = UNNotificationSound.default()
                        notification.title = "Terapia Farmacologica"
                        notification.subtitle = medicinale.getNome()
                        notification.badge = 1
                        
                        notification.categoryIdentifier = "actionCategory"
                        
                        let url = Bundle.main.url(forResource: "Images/medicinale", withExtension: "gif")
                        
                        if let attachment = try? UNNotificationAttachment(identifier: "image", url: url!, options: nil) {
                            notification.attachments = [attachment]
                        }
                        
                        if CoreDataController.shared.existsImageFromName(nameImage: medicinale.getNome()){
                            
                            notification.userInfo = ["image" : CoreDataController.shared.loadImageFromName(nameImage: medicinale.getNome())]
                            
                        }
                        
                        
                        var finalDosaggio = Double()
                        
                        if medicinale.getDosaggioFisso() != 0{
                            notification.body = "\(medicinale.getDosaggioFisso() ) - \(medicinale.getMisuraDosaggio())"
                        }
                            
                            //significa che il dosaggio è variabile
                        else{
                            let currentDate = Date()
                            
                            var days = [Int]()
                            
                            for day in (medicinale.getDosaggioVariabile().keys){
                                days.append(day)
                             
                            }
                            //Ricorda di ordinare perchè quando li mette precedentemente nell'array vengono messi in disordine
                            days.sort()
                            
                            var c = 0
                            
                            for day in days{
                                
                                if c < days.count - 1 {
                                    
                                    
                                    if (currentDate.days(from_date: (paziente.getUltimaModifica())) + 1 >= day && currentDate.days(from_date: (paziente.getUltimaModifica())) + 1 < days[c + 1]){
                                        
                                        notification.body = "\(medicinale.getDosaggioVariabile()[day]!) - \(medicinale.getMisuraDosaggio() )"
                                        finalDosaggio = medicinale.getDosaggioVariabile()[day]!
                                        break
                                        
                                    }
                                    
                                }
                                    
                                else{
                                    
                                    notification.body = "\(medicinale.getDosaggioVariabile()[days[c]]!) - \(medicinale.getMisuraDosaggio() )"
                                    finalDosaggio = medicinale.getDosaggioVariabile()[days[c]]!
                                }
                                
                                c = c + 1
                                
                            }
                            
                        }
                        
                        if finalDosaggio != 0 || medicinale.getDosaggioFisso() != 0{
                            
                            // add notification
                            
                            var dateComponents = DateComponents()
                            
//                            dateComponents.timeZone = TimeZone(abbreviation: "GMT")
                            
                            dateComponents.weekday = specificDay
                            
                            dateComponents.hour = 16
                            
                            dateComponents.minute = 25
                          
                            let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                            //let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)

                            let request = UNNotificationRequest(identifier: "\(terapiaFarmacologica.getCodice())-\(medicinale.getNome())-\(dateComponents.hour ?? 12)-\(dateComponents.minute ?? 0)-\(specificDay)", content: notification, trigger: notificationTrigger)
                            
                            // Schedule the request.
                            let center = UNUserNotificationCenter.current()
                            //
                            center.add(request) { (error : Error?) in
                                if let theError = error {
                                    print("\(theError.localizedDescription)")
                                }
                            }
                         
                        }
                        
                    }
                    
                    if (terapiaFarmacologica.getTipoOrario() == "orario_approssimato"){
                        
                        for specificTime in terapiaFarmacologica.getOrarioApprossimato(){
                            
                            let notification = UNMutableNotificationContent()
                            
                            notification.sound = UNNotificationSound.default()
                            notification.title = "Terapia Farmacologica"
                            notification.subtitle = medicinale.getNome()
                            notification.badge = 1
                            
                            notification.categoryIdentifier = "actionCategory"
                            
                            let url = Bundle.main.url(forResource: "Images/medicinale", withExtension: "gif")
                            
                            if let attachment = try? UNNotificationAttachment(identifier: "image", url: url!, options: nil) {
                                notification.attachments = [attachment]
                            }
                            
                            if CoreDataController.shared.existsImageFromName(nameImage: medicinale.getNome()){

                                notification.userInfo = ["image" : CoreDataController.shared.loadImageFromName(nameImage: medicinale.getNome())]

                            }
                            
                            var finalDosaggio = Double()
                            
                            if medicinale.getDosaggioFisso() != 0{
                                notification.body = "\(medicinale.getDosaggioFisso() ) - \(medicinale.getMisuraDosaggio())"
                            }
                
                                //significa che il dosaggio è variabile
                            else{
                                let currentDate = Date()
                                
                                var days = [Int]()
                                
                                for day in (medicinale.getDosaggioVariabile().keys){
                                    days.append(day)
                                    
                                }
                                //Ricorda di ordinare perchè quando li mette precedentemente nell'array vengono messi in disordine
                                days.sort()
                                
                                var c = 0
                                
                                for day in days{
                                    
                                    if c < days.count - 1 {
                                        
                                        
                                        if (currentDate.days(from_date: (paziente.getUltimaModifica())) + 1 >= day && currentDate.days(from_date: (paziente.getUltimaModifica())) + 1 < days[c + 1]){
                                            
                                            notification.body = "\(medicinale.getDosaggioVariabile()[day]!) - \(medicinale.getMisuraDosaggio() )"
                                            finalDosaggio = medicinale.getDosaggioVariabile()[day]!
                                            
                                            break
                                            
                                        }
                                        
                                    }
                                        
                                    else{
                                        
                                        notification.body = "\(medicinale.getDosaggioVariabile()[days[c]]!) - \(medicinale.getMisuraDosaggio() )"
                                        finalDosaggio = medicinale.getDosaggioVariabile()[days[c]]!
                                        
                                    }
                                    
                                    c = c + 1
                                    
                                }
                                
                            }
                            
                            if finalDosaggio != 0 || medicinale.getDosaggioFisso() != 0{
                                // add notification
                                var dateComponents = DateComponents()
                                
                                dateComponents.weekday = specificDay
                          
                                
                                if specificTime.key == "colazione"{
                                    
                                    if specificTime.value == "prima"{
                                        
                                        dateComponents.hour = Int("7")
                                        
                                    }
                                    
                                    if specificTime.value == "durante"{
                                        
                                        dateComponents.hour = Int("8")
                                        
                                    }
                                    
                                    if specificTime.value == "dopo"{
                                        
                                        dateComponents.hour = Int("9")
                                        
                                    }
                                    
                                }
                                
                                if specificTime.key == "pranzo"{
                                    
                                    if specificTime.value == "prima"{
                                        
                                        dateComponents.hour = Int("11")
                                        
                                    }
                                    
                                    if specificTime.value == "durante"{
                                        
                                        dateComponents.hour = Int("12")
                                        
                                    }
                                    
                                    if specificTime.value == "dopo"{
                                        
                                        dateComponents.hour = Int("13")
                                        
                                    }
                                    
                                }
                                
                                if specificTime.key == "cena"{
                                    
                                    if specificTime.value == "prima"{
                                        
                                        dateComponents.hour = Int("19")
                                        
                                    }
                                    
                                    if specificTime.value == "durante"{
                                        
                                        dateComponents.hour = Int("20")
                                        
                                    }
                                    
                                    if specificTime.value == "dopo"{
                                        
                                        dateComponents.hour = Int("21")
                                        
                                    }
                                    
                                }

                                dateComponents.minute =  Int("00")
                                
                                let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                        
                                let request = UNNotificationRequest(identifier: "\(terapiaFarmacologica.getCodice())-\(medicinale.getNome())-\(specificTime.key)-\(specificTime.value)-\(specificDay)", content: notification, trigger: notificationTrigger)
                                
                                // Schedule the request.
                                let center = UNUserNotificationCenter.current()
                                
                                center.add(request) { (error : Error?) in
                                    if let theError = error {
                                        print("\(theError.localizedDescription)")
                                    }
                                }
                            
                            }
                            
                        }
                        
                    }

                }
            }
        }
        
        UNUserNotificationCenter.current().getPendingNotificationRequests{requests -> () in
            print("\(requests.count) requests -------")
            for request in requests{
                print(request.identifier)
            }
        }
        
    }
    
}




