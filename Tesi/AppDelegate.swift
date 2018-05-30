//
//  AppDelegate.swift
//  Tesi
//
//  Created by TonySellitto on 14/04/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import AVFoundation

import UserNotifications
import FirebaseInstanceID
import FirebaseMessaging
import SystemConfiguration

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate{
    
    var window: UIWindow?
    
    var paziente : Paziente?
    
    var qrCode : String?
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0
    }
    
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//
//        // Setting up the class that will handle all the notifications
//        let notificationCenter = UNUserNotificationCenter.current()
//        notificationCenter.delegate = NotificationCenterManager.shared
//
//        // Request authorization to display notifications
//        NotificationCenterManager.shared.requestAuthorizationForNotifications()
//
//        // Register with APNs
////        self.registerForPushNotifications(application)
//
//        self.registerTherapiesRemindersNotificationActions()
//
//        // Manage the case the app is launched from notification
//        if let notification = launchOptions?[.remoteNotification] as? [String: AnyObject] {
//            // Code the desired actions
//            let aps = notification["aps"] as! [String: AnyObject]
//            if aps["content-available"] as? Int == 1 {
//                if aps["category"] as? String == "newCoffeeTipNotification" {
//                    _ =  APIManager.shared.makeTip(notification)
//                } else if aps["category"] as? String == "newCoffeeDealNotification" {
//                    _ =  APIManager.shared.makeDeal(notification)
//                    (window?.rootViewController as? UITabBarController)?.selectedIndex = 2
//                }
//            }
//        }
//        return true
//    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        if let rvc = self.window?.rootViewController {
            if UserDefaults.standard.bool(forKey: "notFirstTime") ==  true{
                self.window!.rootViewController = rvc.storyboard!.instantiateViewController(withIdentifier: "TabBarController")
            }
            if UserDefaults.standard.string(forKey: "qrCode") != nil {
                self.qrCode = UserDefaults.standard.string(forKey: "qrCode")
                print(self.qrCode ?? "nil" )
            }
        }
        
        
         UNUserNotificationCenter.current().delegate = self
        
//         UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        // Override point for customization after application launch.
        
//        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
//        actionSheet.view.tintColor = UIColor.black
//        
//        actionSheet.addAction(UIAlertAction(title: "Stop Alert", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
//            
//            
//            self.audioPlayer?.stop()
//        }))
//        window?.rootViewController!.present(actionSheet, animated: true, completion: nil)
        
        return true
    }

//    func playSound(_ soundName: String) {
//
//        //vibrate phone first
//        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
//        //set vibrate callback
//        AudioServicesAddSystemSoundCompletion(SystemSoundID(kSystemSoundID_Vibrate),nil,
//                                              nil,
//                                              { (_:SystemSoundID, _:UnsafeMutableRawPointer?) -> Void in
//                                                print("callback", terminator: "") //todo
//        },
//                                              nil)
//        let url = URL(
//            fileURLWithPath: Bundle.main.path(forResource: soundName, ofType: "mp3")!)
//
//        var error: NSError?
//
//        do {
//            var audioPlayer = try AVAudioPlayer(contentsOf: url)
//        } catch let error1 as NSError {
//            error = error1
//            audioPlayer = nil
//        }
//
//        if let err = error {
//            print("audioPlayer error \(err.localizedDescription)")
//        } else {
//            audioPlayer!.delegate = self
//            audioPlayer!.prepareToPlay()
//        }
//        //negative number means loop infinity
//        audioPlayer!.numberOfLoops = -1
//        audioPlayer!.play()
//    }
//
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

//    func applicationDidBecomeActive(_ application: UIApplication) {
//        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Tesi")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    func showInternetAlert(view: UIViewController) {
        let alert = UIAlertController(title: "Warning", message: "Internet is not available", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        
        alert.addAction(action)
        view.present(alert, animated: true, completion: nil)
    }

}

// MARK: - Register notification actions
extension AppDelegate {
    // TODO: Explain what it is
    func registerTherapiesRemindersNotificationActions() {
        // 1. Create the actions
        let doneTherapy =
            UNNotificationAction(identifier: NotificationActionIdentifier.doneTherapy,
                                 title: "Done",
                                 options: [.authenticationRequired])
        let sos =
            UNNotificationAction(identifier: NotificationActionIdentifier.sos,
                                 title: "SOS",
                                 options: [.authenticationRequired])
        
        // 2. Create the category associated with the actions
        let reminderCategory =
            UNNotificationCategory(identifier: NotificationCategoryIdentifier.reminder,
                                   actions: [doneTherapy, sos],
                                   intentIdentifiers: [],
                                   options: [])
        // 3. Register the category in the Notification Center
        UNUserNotificationCenter.current()
            .setNotificationCategories([reminderCategory])
    }
}

