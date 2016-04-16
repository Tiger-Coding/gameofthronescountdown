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
    
    /** Used to flash the label when it's time to watch */
    var countdownLabelHidden: Bool = false
    
    let countdown: Countdown = Countdown()
    let localNotification = LocalNotification()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countdownLabel.font = NSFont(name: "GameofThrones", size: 18.0)
        
        // schedule notifications if they haven't been already
        localNotification.scheduleReminderNotfication(countdown.showStartDate())
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        // no need to keep the timer going when not in the foregound
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
        
        let remainingTime = countdown.remainingTime()
        
        if remainingTime.greaterThanZero() {
            countdownLabel.stringValue = "\(remainingTime.days):d  \(remainingTime.hours):h  \(remainingTime.minutes):m  \(remainingTime.seconds):s"
        }
        else {
            // its time, so flash to the user to watch the show
            
            if countdownLabelHidden {
                countdownLabel.hidden = false
                countdownLabelHidden = false
            }
            else {
                countdownLabel.hidden = true
                countdownLabelHidden = true
            }
            
            countdownLabel.stringValue = "Watch  It  Now"
        }
    }
}

