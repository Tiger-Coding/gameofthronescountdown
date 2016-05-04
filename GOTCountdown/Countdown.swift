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
//  Countdown.swift
//  GOTCountdown
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

