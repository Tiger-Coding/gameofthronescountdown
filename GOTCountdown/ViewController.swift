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
    
    let countdown: Countdown = Countdown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countdownLabel.font = NSFont(name: "GameofThrones", size: 18.0)
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
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
            countdownLabel.stringValue = "Game Of Thrones!"
        }
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}

