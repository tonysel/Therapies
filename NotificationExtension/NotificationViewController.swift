//
//  NotificationViewController.swift
//  NotiExtension
//
//  Created by Tony Sellitto on 25/07/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        
       
        self.imageView.image = UIImage(data: notification.request.content.userInfo["image"] as! Data)
        
        // Check if there is there is an attachment and if not return.
//        guard let attachment = notification.request.content.attachments.first else { return }
//        
//        // Get the attachment and set the image view.
//        if attachment.url.startAccessingSecurityScopedResource(),
//            let data = try? Data(contentsOf: attachment.url) {
//            
//            self.imageView.image = UIImage(data: data)
//            attachment.url.stopAccessingSecurityScopedResource()
//        }
    }
    
    @IBOutlet var imageView: UIImageView!
    
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        

        switch response.actionIdentifier {
        case "sos":
            self.view.backgroundColor = .red
            let alert = UIAlertController(title: "Success", message: "Richiesta di assistenza inviata", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Continue", style:.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
            completion(.dismissAndForwardAction)

        default:
            completion(.dismissAndForwardAction)
        }
        
    }

}
