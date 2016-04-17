//
//  Countdown.swift
//  GOTCountdown
//
//  Created by user on 4/13/16.
//  Copyright © 2016 Javoid. All rights reserved.
//

import Foundation
import SwiftDate


/** An encapsulated struct that calculates the amount of time remaining until the show starts. */
struct Countdown {
    
    /** Made estRegion static because startDateEst depends on this for init, and this way avoids an unecessary optional. */
    static private let estRegion = Region(calendarName: nil, timeZoneName: TimeZoneName.AmericaNewYork, localeName: nil)
    
    /** The exact global release time the show starts. */
    private let startDateEst: DateInRegion = DateInRegion(era: 1, year: 2016, month: 4, day: 24, hour: 21, minute: 0, second: 0, nanosecond: 0, region: Countdown.estRegion)
    
    /** create calendar units here so we don't have to re-create them every call. */
    private let calendarUnits: NSCalendarUnit = [.Day, .Minute, .Hour, .Second]
    
    func remainingTime() -> RemainingTime {
        
        // get a local region so we can compare it
        let localRegion = Region()
        let localDateInRegion = DateInRegion(absoluteTime: NSDate(), region: localRegion)
        
        // difference returns an optional, so guard it
        guard let difference = localDateInRegion.difference(startDateEst, unitFlags: calendarUnits) else {
            return RemainingTime()
        }
        
        return RemainingTime(days: difference.day, hours: difference.hour, minutes: difference.minute, seconds: difference.second)
    }
    
    func showStartDate() -> NSDate {
        return startDateEst.absoluteTime
    }
}

