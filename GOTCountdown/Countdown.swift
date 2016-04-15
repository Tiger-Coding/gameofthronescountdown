//
//  Countdown.swift
//  GOTCountdown
//
//  Created by user on 4/13/16.
//  Copyright © 2016 Javoid. All rights reserved.
//

import Foundation
import SwiftDate


struct Countdown {
    
    let estRegion = Region(calendarName: nil, timeZoneName: TimeZoneName.AmericaNewYork, localeName: nil)
    var startDateEst: DateInRegion?
    
    init() {
        startDateEst = DateInRegion(era: 1, year: 2016, month: 4, day: 24, hour: 21, minute: 0, second: 0, nanosecond: 0, region: estRegion)
    }
    
    func remainingTime() -> RemainingTime {
        
        guard let startDate = startDateEst else {
            return RemainingTime()
        }
        
        let localRegion = Region()
        let localDateInRegion = DateInRegion(absoluteTime: NSDate(), region: localRegion)
        
        let calendarUnits: NSCalendarUnit = [.Day, .Minute, .Hour, .Second]
        guard let difference = localDateInRegion.difference(startDate, unitFlags: calendarUnits) else {
            return RemainingTime()
        }
        
        return RemainingTime(days: difference.day, hours: difference.hour, minutes: difference.minute, seconds: difference.second)
    }
}

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
    
    func greaterThanZero() -> Bool {
        return days + hours + minutes + seconds > 0
    }
}