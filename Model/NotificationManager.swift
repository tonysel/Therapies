//
//  NotificationManager.swift
//  Tesi
//
//  Created by TonySellitto on 19/05/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationManager{
    
    var delegateNotification : NotificationManagerDelegate!
    
    static func createAuthorization(){
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { granted, error in
            if error == nil {
                print("Authorization successfully")
            }
        })
        
    }
    
    //RICORDA PER LA CANCELLAZIONE
//    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    
    static func createNotificationsForTerapieFarmacologiche (paziente: Paziente){
        
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        
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
                            
                            notification.categoryIdentifier = "Done"
                            
                            if medicinale.getDosaggioFisso() != 0{
                                notification.body = "\(medicinale.getDosaggioFisso() ) - \(medicinale.getMisuraDosaggio())"
                            }
                                
                            else{
                                let currentDate = Date()
                                
                                var days = [Int]()
                                
                                for day in medicinale.getDosaggioVariabile().keys{
                                    days.append(day)
                                }
                                
                                for dayValue in medicinale.getDosaggioVariabile(){
                                    
                                    for i in days{
                                        
                                        if currentDate.days(from_date: (paziente.getUltimaModifica())) >= dayValue.key && currentDate.days(from_date: (paziente.getUltimaModifica())) < days[i]{
                                            notification.body = "\(dayValue.value) - \(medicinale.getMisuraDosaggio() )"
                                        }
                                        
                                    }
                                }
                            }
                            
                            // add notification
                            var dateComponents = DateComponents()
                            
                            dateComponents.weekday = specificDay
                            
                            let dateFormatter = DateFormatter.init()
                            
                            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
                            
                            dateFormatter.dateFormat = "HH"
                            
                            dateComponents.hour = Int(dateFormatter.string(from: specificTime))
                            
                            dateFormatter.dateFormat = "mm"
                            
                            dateComponents.minute =  Int(dateFormatter.string(from: specificTime))
                            
                            print("NOTIFICA ora: \(dateComponents.hour!)")
                            
                            print("NOTIFICA minuti: \(dateComponents.minute!)")
                            
                            let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                            //let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
                            
                            
                            let request = UNNotificationRequest(identifier: "notification \(medicinale.getNome())-\(dateComponents.weekday!)-\(dateComponents.hour!)-\(dateComponents.minute!)", content: notification, trigger: notificationTrigger)
                            
                            //        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                            
                            
                            
                            // Schedule the request.
                            let center = UNUserNotificationCenter.current()
                            
                            center.add(request) { (error : Error?) in
                                if let theError = error {
                                    print("vedi bene l'errore \(theError.localizedDescription)")
                                }
                            }
                        }
                    }
                    
                    
                    if (terapiaFarmacologica.getTipoOrario() == "orario_libero"){
                        
                        for _ in 1...terapiaFarmacologica.getOrarioLibero(){
                            
                            let notification = UNMutableNotificationContent()
                            
                            notification.sound = UNNotificationSound.default()
                            notification.title = "Terapia Farmacologica"
                            notification.subtitle = medicinale.getNome()
                            
                            if medicinale.getDosaggioFisso() != 0{
                                notification.body = "\(medicinale.getDosaggioFisso() ) - \(medicinale.getMisuraDosaggio())"
                            }
                                
                            else{
                                let currentDate = Date()
                                
                                var days = [Int]()
                                
                                for day in medicinale.getDosaggioVariabile().keys{
                                    days.append(day)
                                }
                                
                                for dayValue in medicinale.getDosaggioVariabile(){
                                    
                                    for i in days{
                                        
                                        if currentDate.days(from_date: (paziente.getUltimaModifica())) >= dayValue.key && currentDate.days(from_date: (paziente.getUltimaModifica())) < days[i]{
                                            notification.body = "\(dayValue.value) - \(medicinale.getMisuraDosaggio() )"
                                        }
                                        
                                    }
                                }
                            }
                            
                            // add notification
                            var dateComponents = DateComponents()
                            
                            dateComponents.timeZone = TimeZone(abbreviation: "GMT")
                            
                            dateComponents.weekday = specificDay
                            
                            dateComponents.hour = 12
                            
                            dateComponents.minute = 00
                            
                            let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                            //let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
                            
                            
                            let request = UNNotificationRequest(identifier: "notification \(medicinale.getNome())-\(dateComponents.weekday!)-\(dateComponents.hour!)-\(dateComponents.minute!)", content: notification, trigger: notificationTrigger)
                            
                            //        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                            
                            // Schedule the request.
                            let center = UNUserNotificationCenter.current()
                            
                            center.add(request) { (error : Error?) in
                                if let theError = error {
                                    print("vedi bene l'errore \(theError.localizedDescription)")
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
                            
                            if medicinale.getDosaggioFisso() != 0{
                                notification.body = "\(medicinale.getDosaggioFisso() ) - \(medicinale.getMisuraDosaggio())"
                            }
                                
                            else{
                                let currentDate = Date()
                                
                                var days = [Int]()
                                
                                for day in medicinale.getDosaggioVariabile().keys{
                                    days.append(day)
                                }
                                
                                for dayValue in medicinale.getDosaggioVariabile(){
                                    
                                    for i in days{
                                        
                                        if i <= days.count{
                                            if currentDate.days(from_date: (paziente.getUltimaModifica())) >= dayValue.key && (currentDate.days(from_date: (paziente.getUltimaModifica()))) < days[i]{
                                                notification.body = "\(dayValue.value) - \(medicinale.getMisuraDosaggio() )"
                                            }
                                        }
                                        else{
                                            notification.body = "\(dayValue.value) - \(medicinale.getMisuraDosaggio() )"
                                        }
                                    }
                                }
                            }
                            
                            // add notification
                            var dateComponents = DateComponents()
                            
                            dateComponents.weekday = specificDay
                            
                            let dateFormatter = DateFormatter.init()
                            
                            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
                            
                            dateFormatter.dateFormat = "HH"
                            
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
                            
                            dateFormatter.dateFormat = "mm"
                            
                            dateComponents.minute =  Int("00")
                            
                            print("NOTIFICA ora: \(dateComponents.hour!)")
                            
                            print("NOTIFICA minuti: \(dateComponents.minute!)")
                            
                            let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                            //let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
                            
                            let request = UNNotificationRequest(identifier: "notification \(medicinale.getNome())-\(dateComponents.weekday!)-\(dateComponents.hour!)-\(dateComponents.minute!)", content: notification, trigger: notificationTrigger)
                            
                            //        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                            
                            // Schedule the request.
                            let center = UNUserNotificationCenter.current()
                            
                            center.add(request) { (error : Error?) in
                                if let theError = error {
                                    print("vedi bene l'errore \(theError.localizedDescription)")
                                }
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
