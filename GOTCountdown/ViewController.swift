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
//  ViewController.swift
//  GOTCountdown
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
        
        // start the timer every time we appear, because it's disabled when we go to the background
        if timer == nil {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(ViewController.updateLabel(_:)), userInfo: nil, repeats: true)
        }
        
        mainTheme.playTheme()
    }
    
    override func viewDidDisappear() {
        super.viewDidDisappear()
        
        // no need to keep the timer going when not in the foregound
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

