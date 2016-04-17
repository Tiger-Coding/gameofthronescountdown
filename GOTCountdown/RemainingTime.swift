//
//  RemainingTime.swift
//  GOTCountdown
//
//  Created by user on 4/16/16.
//  Copyright © 2016 Javoid. All rights reserved.
//

import Foundation


struct RemainingTime {
    var days: Int
    var hours: Int
    var minutes: Int
    var seconds: Int
    
    init(days: NSInteger = 0, hours: NSInteger = 0, minutes: NSInteger = 0, seconds: NSInteger = 0) {
        self.days = days
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
    
    /** Returns true if the sum of all the properties > zero. */
    func greaterThanZero() -> Bool {
        return days + hours + minutes + seconds > 0
    }
}