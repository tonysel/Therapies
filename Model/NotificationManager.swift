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

    static func createNotificationsForTerapieFarmacologiche (){
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        TerapieManager.createTerapieFarmacologicheInWeek(paziente: (appDelegate?.paziente)!).values.forEach{(medicinaliWithTime) in
            
            medicinaliWithTime.forEach{(medicinaleWithTime) in
            
               
                if !CoreDataController.shared.existsMedicinaleWithTimeFromId(id: medicinaleWithTime.getId()!){
                    
                    let notification = UNMutableNotificationContent()
                    
                    notification.sound = UNNotificationSound.default()
                    notification.title = "Terapia Farmacologica"
                    notification.subtitle = medicinaleWithTime.getMedicinale().getNome()
                    notification.badge = 1
                    
                    notification.categoryIdentifier = "actionCategory"
                    
                    let url = Bundle.main.url(forResource: "Images/medicinale", withExtension: "gif")

                    if let attachment = try? UNNotificationAttachment(identifier: "image", url: url!, options: nil) {
                        notification.attachments = [attachment]
                    }
                    
                    if CoreDataController.shared.existsImageFromName(nameImage: medicinaleWithTime.getMedicinale().getNome()){
                        
                        notification.userInfo = ["image" : CoreDataController.shared.loadImageFromName(nameImage: medicinaleWithTime.getMedicinale().getNome())]
                        
                    }
                    
                    notification.body = "\(medicinaleWithTime.getDosaggio() ?? 1) - \(medicinaleWithTime.getMedicinale().getMisuraDosaggio())"
                    
                    // add notification
                    var dateComponents = DateComponents()
                    
                    let dateFormatter = DateFormatter.init()
                    
                    //                dateFormatter.timeZone = TimeZone(secondsFromGMT: 7200)
                    
                    dateFormatter.dateFormat = "yyyy"
                    
                    dateComponents.year =  Int(dateFormatter.string(from: medicinaleWithTime.getTime()!))
                    
                    dateFormatter.dateFormat = "MM"
                    
                    dateComponents.month =  Int(dateFormatter.string(from: medicinaleWithTime.getTime()!))
                    
                    dateFormatter.dateFormat = "dd"
                    
                    dateComponents.day =  Int(dateFormatter.string(from: medicinaleWithTime.getTime()!))
                    
                    dateFormatter.dateFormat = "HH"
                    
                    dateComponents.hour =  Int(dateFormatter.string(from: medicinaleWithTime.getTime()!))
                    
                    dateFormatter.dateFormat = "mm"
                    
                    dateComponents.minute = Int(dateFormatter.string(from: medicinaleWithTime.getTime()!))
                    
                    let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                    
//                    let finalDate = medicinaleWithTime.getTime()!
                    
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                
                    let infoMedicinale = medicinaleWithTime.getId()!.components(separatedBy: "-")
                    
                    let request = UNNotificationRequest(identifier: "\(infoMedicinale[0]) \(medicinaleWithTime.getMedicinale().getNome()) \(dateFormatter.string(from: medicinaleWithTime.getTime()!))", content: notification, trigger: notificationTrigger)
                    
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
        
        UNUserNotificationCenter.current().getPendingNotificationRequests{requests -> () in
            print("\(requests.count) requests -------")
            for request in requests{
                print(request.identifier)
            }
        }
       
    }
    
}

public protocol NotificationManagerDelegate{
    func onSuccess()
    func onFailure()
}
