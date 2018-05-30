//
//  NotificationTypes.swift
//  Tesi
//
//  Created by TonySellitto on 24/05/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit

struct CoffeeReminderNotificationContent {
    // Notification content
    let title: String
    let bodyText: String
    
    // Trigger parameters
    let hour: Int
    let minutes: Int
    let repeating: Bool = true
    
    // Identifiers
    let requestUniqueIdentifier: String
    
    let categoryIdentifier: String = NotificationCategoryIdentifier.reminder
    
    let threadIdentifier: String = NotificationThreadIdentifier.coffeeReminder
    
    // User information
    var info = [
        "Name": "",
        "Value": ""
    ]
}
