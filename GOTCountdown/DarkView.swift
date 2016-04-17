//
//  DarkView.swift
//  GOTCountdown
//
//  Created by user on 4/16/16.
//  Copyright © 2016 Javoid. All rights reserved.
//

import Cocoa


/** Cocoa doesn't appear to have IB support for simply adding a UIView with a color and alpha level.  This class performs that task with the intent of making the checkbox and HBO text more visible. */
class DarkView: NSView {
    
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        // partial code made easier by PaintCode
        let radius = CGFloat(4.0)
        let rectanglePath = NSBezierPath(roundedRect: dirtyRect, xRadius: radius, yRadius: radius)
        NSColor.blackColor().setFill()
        rectanglePath.fill()
    }
    
}
