//
//  ViewController.swift
//  GOTCountdown
//
//  Created by user on 4/4/16.
//  Copyright © 2016 Javoid. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var countdownLabel: NSTextField!
    
    var timer: NSTimer?
    
    let utcReleaseDate = NSDate(timeIntervalSince1970: 1461531600)
    let utcTimeZone = NSTimeZone(abbreviation: "UTC")
    //let utcDateFormatter = NSDateFormatter()
    
    let dateFormatter = NSDateFormatter()
    let timeZone = NSTimeZone.localTimeZone()
    let calendar = NSCalendar.currentCalendar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.title = "Game Of Thrones"
        
        dateFormatter.timeZone = timeZone
//        let unitFlags: NSCalendarUnit = [.Second, .Hour, .Day]
//        let components = NSCalendar.currentCalendar().components(unitFlags, fromDate: date)
        
        
        
        countdownLabel.font = NSFont(name: "GameofThrones", size: 20.0)
        
        if timer == nil {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(ViewController.updateLabel(_:)), userInfo: nil, repeats: true)
        }
    }
    
    override func viewDidDisappear() {
        super.viewDidDisappear()
        
        if let existingTimer = timer {
            existingTimer.invalidate()
            timer = nil
        }
    }
    
    func updateLabel(timer: NSTimer!) {
        let date = NSDate()
        let difference = utcReleaseDate.timeIntervalSinceReferenceDate - date.timeIntervalSinceReferenceDate
        
        if difference > 0 {
            //let years = round(difference / 365)
            let days = round(difference / (24 * 365) )
            let hours = round(difference / (24 * 60));
            let minutes = round(difference / (24 * 60 * 60))
            let seconds = round(difference / (24 * 60 * 60 * 60))
            let milliseconds = round(difference / (24 * 60 * 60 * 60 * 60))
            countdownLabel.stringValue = "\(days):d \(hours):h \(minutes):m \(seconds):s \(milliseconds):ms"
        }
        else {
            countdownLabel.stringValue = "Game Of Thrones!"
        }
        
//        NSTimeInterval dateDiff = [eventDate timeIntervalSinceNow];
//        int countDown=trunc(dateDiff/(60*60*24));
        
        //countdownLabel.stringValue = "COUNTDOWN\n\n" + "13:d 12:h 43:m 25:s"
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}

