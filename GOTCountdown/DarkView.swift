
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
//  DarkView.swift
//  GOTCountdown
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
