//
//  NotificationManager.swift
//  Tesi
//
//  Created by TonySellitto on 19/05/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit
import UserNotifications

public class NotificationManager{
    
    
    
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var delegateNotification : NotificationManagerDelegate!

    static func createNotificationsForTerapieFarmacologiche (paziente: Paziente){
        
        
        //RICORDA PER LA CANCELLAZIONE
       
        
       UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        //
       UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

        
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

//
                            var finalDosaggio = Double()
                            
                            if medicinale.getDosaggioFisso() != 0{
                                notification.body = "\(medicinale.getDosaggioFisso() ) - \(medicinale.getMisuraDosaggio())"
                            }
                                
//                            else{
//                                let currentDate = Date()
//
//                                var days = [Int]()
//
//                                for day in medicinale.getDosaggioVariabile().keys{
//                                    days.append(day)
//                                }
//
//                                for dayValue in medicinale.getDosaggioVariabile(){
//
//                                    for i in days{
//
//                                        if currentDate.days(from_date: (paziente.getUltimaModifica())) >= dayValue.key && currentDate.days(from_date: (paziente.getUltimaModifica())) < days[i]{
//                                            notification.body = "\(dayValue.value) - \(medicinale.getMisuraDosaggio() )"
//                                        }
//
//                                    }
//                                }
//                            }
                           
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
                                        
                                        
                                        if currentDate.days(from_date: (paziente.getUltimaModifica())) >= day && currentDate.days(from_date: (paziente.getUltimaModifica())) < days[c + 1]{
                                            
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
                                
                                let dateFormatter = DateFormatter.init()
                                
                                dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
                                
                                dateFormatter.dateFormat = "HH"
                                
                                dateComponents.hour =  Int(dateFormatter.string(from: specificTime))
                                
                                dateFormatter.dateFormat = "mm"
                                
                                dateComponents.minute = Int(dateFormatter.string(from: specificTime))
                                
                                print("NOTIFICA ora esatto: \(dateComponents.hour!)")
                                
                                print("NOTIFICA minuti esatto: \(dateComponents.minute!)")
                                
                                let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                                //let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
//
                                let lastDateFormatter = DateFormatter.init()
                                lastDateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                                let lastDate = lastDateFormatter.string(from: Date())
                                
                                let request = UNNotificationRequest(identifier: "\(terapiaFarmacologica.getCodice())-\(medicinale.getNome())-\(lastDate)", content: notification, trigger: notificationTrigger)
                                
                                //        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                               
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
                        
//                        for _ in 1...terapiaFarmacologica.getOrarioLibero(){
                        
                            let notification = UNMutableNotificationContent()
                            
                            notification.sound = UNNotificationSound.default()
                            notification.title = "Terapia Farmacologica"
                            notification.subtitle = medicinale.getNome()
                            notification.badge = 1
                            
                            notification.categoryIdentifier = "actionCategory"
                        
                        
                            
//
//                            guard let path = Bundle.main.path(forResource: "Apple", ofType: "png") else {return}
//                            let url = URL(fileURLWithPath: path)
//
//                            do {
//                                let attachment = try UNNotificationAttachment(identifier: "logo", url: url, options: nil)
//                                notification.attachments = [attachment]
//                            }catch{
//                                print("The attachment could not be loaded")
//                            }

                            var finalDosaggio = Double()
                            
                            if medicinale.getDosaggioFisso() != 0{
                                notification.body = "\(medicinale.getDosaggioFisso() ) - \(medicinale.getMisuraDosaggio())"
                            }
                                
//                            else{
//                                let currentDate = Date()
//
//                                var days = [Int]()
//
//                                for day in medicinale.getDosaggioVariabile().keys{
//                                    days.append(day)
//                                }
//
//                                for dayValue in medicinale.getDosaggioVariabile(){
//
//                                    for i in days{
//
//                                        if currentDate.days(from_date: (paziente.getUltimaModifica())) >= dayValue.key && currentDate.days(from_date: (paziente.getUltimaModifica())) < days[i]{
//                                            notification.body = "\(dayValue.value) - \(medicinale.getMisuraDosaggio() )"
//                                        }
//
//                                    }
//                                }
//                            }
//
                                //significa che il dosaggio è variabile
                            else{
                                let currentDate = Date()
                                
                                var days = [Int]()
                                
                                for day in (medicinale.getDosaggioVariabile().keys){
                                    days.append(day)
                                    
                                    //                                        print(days)
                                }
                                //Ricorda di ordinare perchè quando li mette precedentemente nell'array vengono messi in disordine
                                days.sort()
                                
                                var c = 0
                                
                                for day in days{
                                    
                                    if c < days.count - 1 {
                                        
                                        
                                        if currentDate.days(from_date: (paziente.getUltimaModifica())) >= day && currentDate.days(from_date: (paziente.getUltimaModifica())) < days[c + 1]{
                                            
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
                                
                                dateComponents.timeZone = TimeZone(abbreviation: "GMT")
                                
                                dateComponents.weekday = specificDay
                                
                                dateComponents.hour = 12
                                
                                dateComponents.minute = 00
                                
                                let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                                //let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
//
                                let lastDateFormatter = DateFormatter.init()
                                lastDateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                                let lastDate = lastDateFormatter.string(from: Date())
//
                                let request = UNNotificationRequest(identifier: "\(terapiaFarmacologica.getCodice())-\(medicinale.getNome())-\(lastDate)", content: notification, trigger: notificationTrigger)
                                //       UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                                
                                // Schedule the request.
                                let center = UNUserNotificationCenter.current()
//
                                center.add(request) { (error : Error?) in
                                    if let theError = error {
                                        print("\(theError.localizedDescription)")
                                    }
                                }
                                
//                            }
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
                            
                            var finalDosaggio = Double()
                            
                            if medicinale.getDosaggioFisso() != 0{
                                notification.body = "\(medicinale.getDosaggioFisso() ) - \(medicinale.getMisuraDosaggio())"
                            }
                                
                                //                            else{
                                //                                let currentDate = Date()
                                //
                                //                                var days = [Int]()
                                //
                                //                                for day in medicinale.getDosaggioVariabile().keys{
                                //                                    days.append(day)
                                //                                }
                                //
                                //                                for dayValue in medicinale.getDosaggioVariabile(){
                                //
                                //                                    for i in days{
                                //
                                //                                        if i <= days.count{
                                //                                            if currentDate.days(from_date: (paziente.getUltimaModifica())) >= dayValue.key && (currentDate.days(from_date: (paziente.getUltimaModifica()))) < days[i]{
                                //                                                notification.body = "\(dayValue.value) - \(medicinale.getMisuraDosaggio() )"
                                //                                            }
                                //                                        }
                                //                                        else{
                                //                                            notification.body = "\(dayValue.value) - \(medicinale.getMisuraDosaggio() )"
                                //                                        }
                                //                                    }
                                //                                }
                                //                            }
                                
                                //significa che il dosaggio è variabile
                            else{
                                let currentDate = Date()
                                
                                var days = [Int]()
                                
                                for day in (medicinale.getDosaggioVariabile().keys){
                                    days.append(day)
                                    
                                    //                                        print(days)
                                }
                                //Ricorda di ordinare perchè quando li mette precedentemente nell'array vengono messi in disordine
                                days.sort()
                                
                                var c = 0
                                
                                for day in days{
                                    
                                    if c < days.count - 1 {
                                        
                                        
                                        if currentDate.days(from_date: (paziente.getUltimaModifica())) >= day && currentDate.days(from_date: (paziente.getUltimaModifica())) < days[c + 1]{
                                            
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
//
//                                let dateFormatter = DateFormatter.init()
//
//                                dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
//
//                                dateFormatter.dateFormat = "HH"
                                
                                if specificTime.key == "colazione"{
                                    
                                    if specificTime.value == "prima"{
                                        
                                        dateComponents.hour = Int("19")
                                        
                                    }
                                    
                                    if specificTime.value == "durante"{
                                        
                                        dateComponents.hour = Int("8")
                                        
                                    }
                                    
                                    if specificTime.value == "dopo"{
                                        
                                        dateComponents.hour = Int("13")
                                        
                                    }
                                    
                                }
                                
                                if specificTime.key == "pranzo"{
                                    
                                    if specificTime.value == "prima"{
                                        
                                        dateComponents.hour = Int("19")
                                  
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
                               
//                                dateFormatter.dateFormat = "mm"
                                
                                dateComponents.minute =  Int("56")
                    
                                let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//                                let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)

                                let lastDateFormatter = DateFormatter.init()
                                lastDateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                                let lastDate = lastDateFormatter.string(from: Date())
//
                                let request = UNNotificationRequest(identifier: "\(terapiaFarmacologica.getCodice())-\(medicinale.getNome())-\(lastDate)", content: notification, trigger: notificationTrigger)
        
//                              let request = UNNotificationRequest(identifier:  "\(terapiaFarmacologica.getCodice())-\(medicinale.getCodice())-\(lastDateFormatter.date(from: "\(dateComponents.year!)-\(dateComponents.month!)-\(dateComponents.day!) \(dateComponents.hour!): \(dateComponents.minute!)") ?? Date())", content: notification, trigger: notificationTrigger)
                                
                                // Schedule the request.
                                let center = UNUserNotificationCenter.current()
                                
                                center.add(request) { (error : Error?) in
                                    if let theError = error {
                                        print("\(theError.localizedDescription)")
                                    }
                                }
                                
                                print("NOTIFICA ora approssimato: \(dateComponents.hour!)")
                                
                                print("NOTIFICA minuti approssimato: \(dateComponents.minute!)")
                            }
                            
                        }
                        
                    }
                }
            }
            
        }
        
    }
    
}

public protocol NotificationManagerDelegate{
    func onSuccess()
    func onFailure()
}
