//
//  MainTheme.swift
//  GOTCountdown
//
//  Created by user on 4/15/16.
//  Copyright © 2016 Javoid. All rights reserved.
//

import Foundation
import AVFoundation


/** Manages playback of the main audio theme. */
struct MainTheme {
    
    /** Loads the audio setting boolean from NSUserDefaults. */
    private static var PlayThemeOnStartupKey = "PlayThemeOnStartupKey"
    /** When the user first runs the app, we need to know to ensure the true value is set.  I could use a default plist here, but this is a small side project and faster. */
    private static var PlayThemeUponInitialLoadSetKey = "PlayThemeUponInitialLoadSetKey"
    
    /** local var so we don't have to query NSUserDefaults over and over */
    private (set) var playThemeOnStartup: Bool
    
    private let themeSound = NSSound(named: "MainSample")
    
    init() {
        // need to get the initial values on init if they have never been set before
        if NSUserDefaults.standardUserDefaults().boolForKey(MainTheme.PlayThemeUponInitialLoadSetKey) == false {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: MainTheme.PlayThemeOnStartupKey)
            playThemeOnStartup = true
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: MainTheme.PlayThemeUponInitialLoadSetKey)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        else {
            playThemeOnStartup = NSUserDefaults.standardUserDefaults().boolForKey(MainTheme.PlayThemeOnStartupKey)
        }
    }
    
    /** Will update the playThemeOnStartup boolean value and start/stop playing audio if needed. */
    mutating func playOnStartupChanged(newValue: Bool) {
        
        playThemeOnStartup = newValue
        
        NSUserDefaults.standardUserDefaults().setBool(playThemeOnStartup, forKey: MainTheme.PlayThemeOnStartupKey)
        NSUserDefaults.standardUserDefaults().synchronize()
        
        if let _ = themeSound where playThemeOnStartup == true {
            playTheme()
        }
        else {
            stopTheme()
        }
    }
    
    /** If playThemeOnStartup is true, this method will play the audio file. */
    func playTheme() {
        if let sound = themeSound where sound.playing == false && playThemeOnStartup {
            sound.play()
        }
    }
    
    func stopTheme() {
        if let sound = themeSound where sound.playing {
            sound.stop()
        }
    }
}