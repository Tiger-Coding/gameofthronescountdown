//
//  String+CountdownFormatter.swift
//  GOTCountdown
//
//  Created by user on 4/16/16.
//  Copyright © 2016 Javoid. All rights reserved.
//

import Foundation


/** I had to use an extension somewhere :) */
extension String {
    
    /** Will format the remaining time to fit the Game of Thrones font. */
    static func formattedCountdownString(let remainingTime: RemainingTime) -> String {
        
        // function to format each time component
        func formattedInteger(value: NSInteger, leadingZero: Bool, label: String) -> String {
            if leadingZero {
                return String(format: "%02d:%@", value, label)
            }
            else {
                return String(format: "%d:%@", value, label)
            }
        }
        
        if remainingTime.greaterThanZero() {
            // only show values for actual time remaining
            // add leading zeros to all but the first component
            // I could improve this maybe with an array of values and a dictionary for labels but I'm lazy tonight :)
            if remainingTime.days > 0 {
                return formattedInteger(remainingTime.days, leadingZero: false, label: "d  ") +
                    formattedInteger(remainingTime.hours, leadingZero: true, label: "h  ") +
                    formattedInteger(remainingTime.minutes, leadingZero: true, label: "m  ") +
                    formattedInteger(remainingTime.seconds, leadingZero: true, label: "s")
            }
            else if remainingTime.hours > 0 {
                return formattedInteger(remainingTime.hours, leadingZero: false, label: "h  ") +
                    formattedInteger(remainingTime.minutes, leadingZero: true, label: "m  ") +
                    formattedInteger(remainingTime.seconds, leadingZero: true, label: "s")
            }
            else if remainingTime.minutes > 0 {
                return formattedInteger(remainingTime.minutes, leadingZero: false, label: "m  ") +
                    formattedInteger(remainingTime.seconds, leadingZero: true, label: "s")
            }
            else {
                return formattedInteger(remainingTime.seconds, leadingZero: false, label: "s")
            }
        }
        else {
            return "Watch  It  Now"
        }
    }
}