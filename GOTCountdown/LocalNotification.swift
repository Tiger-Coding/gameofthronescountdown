/****************************************************************************
 MIT License
 
 Copyright (c) 2016 Russell Sullivan
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 ****************************************************************************/
//
//  LocalNotification.swift
//  GOTCountdown
//

import Foundation
import SwiftDate


/** This utility struct will schedule reminder local notifications for the show. */
struct LocalNotification {
    
    /** Make it static in case this struct is copied, we don't want to load multiple times */
    private static var hasBeenScheduled: Bool = false
    
    /** Used to verify if notifcations have been set by storing in NSUserDefaults. */
    private static var HasBeenScheduledKey = "LocalNotification.HasBeenScheduledKey"
    
    init() {
        loadLocalNotificationScheduled()
    }
    
    /** Schedules multiple notifications to remind the user to watch the show. Will not create multiple notifications if they have already been set. */
    func scheduleReminderNotfication(startDate: NSDate) {
        
        // uncomment for test - make sure the app is not in the foreground or it won't show!
//        let testDate = NSDate()
//        let testDatePlus5Seconds = testDate + 3.seconds
//        createLocalNotification(testDatePlus5Seconds, title: "Test", message: "Test successful!")
        
        // perform several safety checks before we schedule it
        
        let currentDate = NSDate()
        guard currentDate < startDate else {
            return
        }
        
        guard LocalNotification.hasBeenScheduled == false else {
            return
        }
        
        // we will make 3 notifications, so the user has time to get ready!
        // we will perform guard checks to make sure the date hasn't already passed as we create them
        
        // at the time the show starts
        createLocalNotification(startDate, title: "Game of Thrones", message: "Available to watch now!")
        
        // make another notification that is 15 minutes prior so the user has a chance to get ready
        let fifteenMinutesPriorDate = startDate - 15.minutes
        guard currentDate < fifteenMinutesPriorDate else {
            saveLocalNotificationScheduled()
            return
        }
        createLocalNotification(fifteenMinutesPriorDate, title: "Game of Thrones", message: "Starting in 15 minutes!")
        
        // make another at the start of the previous day
        let startOfDay = startDate.startOf(.Day)
        let startOfPreviousDay = startOfDay - 1.days
        guard currentDate < startOfPreviousDay else {
            saveLocalNotificationScheduled()
            return
        }
        createLocalNotification(startOfPreviousDay, title: "Game of Thrones", message: "Starting tomorrow!")
        
        // save it and we're done!
        saveLocalNotificationScheduled()
    }
    
    private func loadLocalNotificationScheduled() {
        LocalNotification.hasBeenScheduled = NSUserDefaults.standardUserDefaults().boolForKey(LocalNotification.HasBeenScheduledKey)
    }
    
    private func saveLocalNotificationScheduled() {
        LocalNotification.hasBeenScheduled = true
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: LocalNotification.HasBeenScheduledKey)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    private func createLocalNotification(date: NSDate, title: String, message: String) {
        let notification = NSUserNotification()
        notification.title = title
        notification.informativeText = message
        // I'm cheating here with a private API for the left icon :)
        // searches on this show lots of workarounds and I don't feel like spending more time on it
        // sadly, I'm still seeing a smaller icon next to the title though
        notification.setValue(NSApp.applicationIconImage, forKey: "_identityImage")
        notification.deliveryDate = date
        notification.soundName = NSUserNotificationDefaultSoundName
        let userNotificationCenter = NSUserNotificationCenter.defaultUserNotificationCenter()
        userNotificationCenter.scheduleNotification(notification)
    }
}