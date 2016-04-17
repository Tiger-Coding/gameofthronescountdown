//
//  ViewController.swift
//  GOTCountdown
//
//  Created by user on 4/4/16.
//  Copyright © 2016 Javoid. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    //MARK: Outlets
    
    @IBOutlet weak var countdownLabel: NSTextField!
    
    // GoT theme music!
    @IBOutlet weak var playThemeCheckbox: NSButton!
    
    //MARK: Variables
    
    var timer: NSTimer?
    
    /** Used to flash the label when it's time to watch */
    var countdownLabelHidden: Bool = false
    
    let countdown: Countdown = Countdown()
    let localNotification = LocalNotification()
    
    var mainTheme = MainTheme()
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countdownLabel.font = NSFont(name: "GameofThrones", size: 18.0)
        
        // change the font color for the checkbox
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .Left
        playThemeCheckbox.attributedTitle = NSAttributedString(string: "Play theme on startup", attributes: [ NSForegroundColorAttributeName : NSColor.whiteColor(), NSParagraphStyleAttributeName : paragraphStyle ])
        
        // schedule notifications (if they haven't been already they won't be scheduled again)
        localNotification.scheduleReminderNotfication(countdown.showStartDate())
        
        updateCheckbox()
    }
    
    //MARK: Appearance
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        // no need to keep the timer going when not in the foregound
        if timer == nil {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(ViewController.updateLabel(_:)), userInfo: nil, repeats: true)
        }
        
        mainTheme.playTheme()
    }
    
    override func viewDidDisappear() {
        super.viewDidDisappear()
        
        if let existingTimer = timer {
            existingTimer.invalidate()
            timer = nil
        }
        
        mainTheme.stopTheme()
    }
    
    //MARK: Countdown!
    
    func updateLabel(timer: NSTimer!) {
        
        let remainingTime = countdown.remainingTime()
        countdownLabel.stringValue = String.formattedCountdownString(remainingTime)
        
        if remainingTime.greaterThanZero() == false {
            flashCountdownLabel()
        }
    }
    
    //MARK: Actions
    
    @IBAction func playThemeCheckboxClicked(sender: AnyObject) {
        if mainTheme.playThemeOnStartup {
            mainTheme.playOnStartupChanged(false)
            updateCheckbox()
        }
        else {
            mainTheme.playOnStartupChanged(true)
            updateCheckbox()
        }
    }
    
    //MARK: UI
    
    func updateCheckbox() {
        playThemeCheckbox.state = mainTheme.playThemeOnStartup ? NSOnState : NSOffState
    }
    
    func flashCountdownLabel() {
        if countdownLabelHidden {
            countdownLabel.hidden = false
            countdownLabelHidden = false
        }
        else {
            countdownLabel.hidden = true
            countdownLabelHidden = true
        }
    }
}

