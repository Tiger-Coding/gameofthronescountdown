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
//  String+CountdownFormatter.swift
//  GOTCountdown
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