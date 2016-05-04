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
//  MainTheme.swift
//  GOTCountdown
//

import Foundation
import AVFoundation


/** Manages playback of the main audio theme. */
struct MainTheme {
    
    /** Loads the audio setting boolean from NSUserDefaults. */
    private static var PlayThemeOnStartupKey = "MainTheme.PlayThemeOnStartupKey"
    /** When the user first runs the app, we need to know to ensure the true value is set.  I could use a default plist here, but this is a small side project and faster. */
    private static var InitialLoadSetupKey = "MainTheme.InitialLoadSetupKey"
    
    /** local var so we don't have to query NSUserDefaults over and over */
    private (set) var playThemeOnStartup: Bool
    
    private let themeSound = NSSound(named: "MainSample")
    
    init() {
        // need to set the initial values on init if they have never been set before
        if NSUserDefaults.standardUserDefaults().boolForKey(MainTheme.InitialLoadSetupKey) == false {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: MainTheme.InitialLoadSetupKey)
            
            // we've confirmed this is the first time we are setting up, so now enable play theme on startup
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: MainTheme.PlayThemeOnStartupKey)
            playThemeOnStartup = true
            
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