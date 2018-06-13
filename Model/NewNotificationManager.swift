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
    
//    var center = UNUserNotificationCenter.current()
    
    static func createNotificationsForTerapieFarmacologiche (paziente: Paziente){
        
        for terapiaFarmacologica in paziente.getTerapieFarmacologiche(){
            
            for medicinale in terapiaFarmacologica.getMedicinali(){
                
                for specificDay in TraslationManager.convertStringDateToArrayIntDate(dayInString: terapiaFarmacologica.getCadenza()){
                    
                    if (terapiaFarmacologica.getTipoOrario() == "orario_approssimato"){
                        
                        for specificTime in terapiaFarmacologica.getOrarioApprossimato(){
                            
                            let notification = UNMutableNotificationContent()

                            notification.sound = UNNotificationSound.default()
                            notification.title = "Terapia Farmacologica"
                            notification.subtitle = medicinale.getNome()
                            notification.badge = 1

                            notification.categoryIdentifier = "actionCategory"
                            notification.body = "niente"
//
//                            var finalDosaggio = Double()
                            
                            
//                            ///////////////////////////////////////////////////////
                            
//                            if medicinale.getDosaggioFisso() != 0{
//                                notification.body = "\(medicinale.getDosaggioFisso() ) - \(medicinale.getMisuraDosaggio())"
//                            }
//
//                                //significa che il dosaggio è variabile
//                            else{
//                                let currentDate = Date()
//
//                                var days = [Int]()
//
//                                for day in (medicinale.getDosaggioVariabile().keys){
//                                    days.append(day)
//
//                                    //                                        print(days)
//                                }
//                                //Ricorda di ordinare perchè quando li mette precedentemente nell'array vengono messi in disordine
//                                days.sort()
//
//                                var c = 0
//
//                                for day in days{
//
//                                    if c < days.count - 1 {
//
//
//                                        if currentDate.days(from_date: (paziente.getUltimaModifica())) >= day && currentDate.days(from_date: (paziente.getUltimaModifica())) < days[c + 1]{
//
//                                            notification.body = "\(medicinale.getDosaggioVariabile()[day]!) - \(medicinale.getMisuraDosaggio() )"
//                                            finalDosaggio = medicinale.getDosaggioVariabile()[day]!
//
//                                            break
//
//                                        }
//
//                                    }
//
//                                    else{
//
//                                        notification.body = "\(medicinale.getDosaggioVariabile()[days[c]]!) - \(medicinale.getMisuraDosaggio() )"
//                                        finalDosaggio = medicinale.getDosaggioVariabile()[days[c]]!
//
//                                    }
//
//                                    c = c + 1
//
//                                }
//
//                            }
//
//                            if finalDosaggio != 0 || medicinale.getDosaggioFisso() != 0{
                                // add notification
                       
//
                            var dateComponents = DateComponents()
////
                            dateComponents.weekday = specificDay
                            
//                             dateComponents.timeZone = TimeZone(identifier: "GMT + 2")
////
//                            print(dateComponents.weekday)
//
//
//                                if specificTime.key == "colazione"{
//
//                                    if specificTime.value == "prima"{
//
//                                        dateComponents.hour = 19
//
//                                    }
////
////                                    if specificTime.value == "durante"{
////
////                                        dateComponents.hour = Int("8")
////
////                                    }
////
////                                    if specificTime.value == "dopo"{
////
////                                        dateComponents.hour = Int("13")
////
////                                    }
////
//                                }
                            
                              dateComponents.calendar = Calendar(identifier: .gregorian)
////
                                if specificTime.key == "pranzo"{

                                    if specificTime.value == "prima"{

                                        dateComponents.hour = 21
                                        
                                        dateComponents.minute = 58
                                    
                                
//                                        dateComponents.isLeapMonth = true
                                        
                                        print(dateComponents)

                                    
//
////                                    if specificTime.value == "durante"{
////
////                                        dateComponents.hour = Int("12")
////
////                                    }
////
////                                    if specificTime.value == "dopo"{
////
////                                        dateComponents.hour = Int("13")
////
////                                    }
////
//                                }

                                
////                                    if specificTime.value == "durante"{
////
////                                        dateComponents.hour = Int("20")
////
////                                    }
////
////                                    if specificTime.value == "dopo"{
////
////                                        dateComponents.hour = Int("21")
////
////                                    }
////
//                                }
//
//                                //dateFormatter.dateFormat = "mm"
//
//                             if specificTime.key == "pranzo"{
//
//                                if specificTime.value == "prima"{
//
//                                    print("entrato \(specificDay)")
//
//                                    dateComponents.hour = 20
//
//                                    dateComponents.minute = 28
//
//
//
//
//                                }
////
////                                notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 7, repeats: false)
//                            }
                            
                                let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
//
//                               let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 6, repeats: false)
                          
                            
                                let lastDateFormatter = DateFormatter.init()
                                lastDateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                                let lastDate = lastDateFormatter.string(from: Date())
                                //
//                                let request = UNNotificationRequest(identifier: "\(terapiaFarmacologica.getCodice())-\(medicinale.getNome())-\(lastDate)", content: notification, trigger: notificationTrigger)
                                        
                                          let request = UNNotificationRequest(identifier: "\(terapiaFarmacologica.getCodice())-\(medicinale.getNome())", content: notification, trigger: notificationTrigger)
                                        
                                    
                                
                                //                              let request = UNNotificationRequest(identifier:  "\(terapiaFarmacologica.getCodice())-\(medicinale.getCodice())-\(lastDateFormatter.date(from: "\(dateComponents.year!)-\(dateComponents.month!)-\(dateComponents.day!) \(dateComponents.hour!): \(dateComponents.minute!)") ?? Date())", content: notification, trigger: notificationTrigger)
                                
                                // Schedule the request.
                            
                                
                                UNUserNotificationCenter.current().add(request) { (error : Error?) in
                                    if let theError = error {
                                        print("\(theError.localizedDescription)")
                                    }
                                }
                                
                                        
//
                                print("NOTIFICA ora approssimato: \(dateComponents.hour!)")

                                print("NOTIFICA minuti approssimato: \(dateComponents.minute!)")
                            }
                            }
                            
                            else if specificTime.key == "cena"{
                                //
                                if specificTime.value == "prima"{
                                    //
                                    dateComponents.hour = 21
                                    
                                    dateComponents.minute = 59
                                    //
                                
                                ////
                                    
                                    let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                                    //
                                    //                               let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 6, repeats: false)
                                    
                                    
                                    let lastDateFormatter = DateFormatter.init()
                                    lastDateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                                    let lastDate = lastDateFormatter.string(from: Date())
                                    //
                                    //                                let request = UNNotificationRequest(identifier: "\(terapiaFarmacologica.getCodice())-\(medicinale.getNome())-\(lastDate)", content: notification, trigger: notificationTrigger)
                                    
                                    let request = UNNotificationRequest(identifier: "\(terapiaFarmacologica.getCodice())-\(medicinale.getNome())", content: notification, trigger: notificationTrigger)
                                    
                                    
                                    
                                    //                              let request = UNNotificationRequest(identifier:  "\(terapiaFarmacologica.getCodice())-\(medicinale.getCodice())-\(lastDateFormatter.date(from: "\(dateComponents.year!)-\(dateComponents.month!)-\(dateComponents.day!) \(dateComponents.hour!): \(dateComponents.minute!)") ?? Date())", content: notification, trigger: notificationTrigger)
                                    
                                    // Schedule the request.
                                    
                                    
                                    UNUserNotificationCenter.current().add(request) { (error : Error?) in
                                        if let theError = error {
                                            print("\(theError.localizedDescription)")
                                        }
                                    }
                                    //
                                    print("NOTIFICA ora approssimato: \(dateComponents.hour!)")
                                    
                                    print("NOTIFICA minuti approssimato: \(dateComponents.minute!)")
                                    }
                            }
                        }
                        
                        }
                        
//                    }
                        
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
    
    static  func scheduleNotification() {
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "Stay Health"
        content.body = "Just a reminder to eat your favourtite healty food."
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = "actionCategory"
        
        let request = UNNotificationRequest(identifier: "main", content: content, trigger: trigger)
        
        //        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) { (error:Error?) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
        
    }
}


