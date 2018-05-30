//
//  NotificationIdentifiers.swift
//  Tesi
//
//  Created by TonySellitto on 24/05/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit

// Content agnostic
public struct NotificationCategoryIdentifier {
    // Reminds you of something
    static let reminder: String = "reminderNotification"
    
   
}

// Content specific
struct NotificationThreadIdentifier {
    static let coffeeReminder: String = "therapyReminderNotification"
    static let update: String = "updateNotification"
}

public struct NotificationActionIdentifier {
    static let doneTherapy: String = "Done"
    static let sos: String = "sos"
}
