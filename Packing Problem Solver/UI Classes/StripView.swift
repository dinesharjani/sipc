//
//  StripView.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 9/10/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

class StripView: NSView {

	weak var strip: Strip? {
		didSet {
			display()
		}
	}
	
	let widthMargin = Float(0.075)
	let heightMargin = Float(0.05)
	
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

		guard (strip != nil) else {
			return;
		}
		
		let xOffset = widthMargin * Float(strip!.width)
		let yOffset = heightMargin * Float(strip!.height)
		
		let widthAspectRatio = (Float(dirtyRect.size.width) - 2 * xOffset) / Float(strip!.width)
		let heightAspectRatio = (Float(dirtyRect.size.height) - 2 * yOffset) / Float(strip!.height)
		
		let xStart =  xOffset * widthAspectRatio
		let xEnd =  Float(strip!.width) * widthAspectRatio - xStart
		let yStart = heightAspectRatio * yOffset
		let yEnd = (Float(strip!.height) * heightAspectRatio) - yStart
		
		let blackColor = NSColor.black
		blackColor.set()
		
		let stripOutlinePath = NSBezierPath(rect: dirtyRect)
		stripOutlinePath.move(to: NSMakePoint(CGFloat(xStart), CGFloat(yStart)))
		stripOutlinePath.line(to: NSMakePoint(CGFloat(xStart), CGFloat(yEnd)))
		stripOutlinePath.move(to: NSMakePoint(CGFloat(xStart), CGFloat(yStart)))
		stripOutlinePath.line(to: NSMakePoint(CGFloat(xEnd), CGFloat(yStart)))
		stripOutlinePath.line(to: NSMakePoint(CGFloat(xEnd), CGFloat(yEnd)))
		stripOutlinePath.stroke()
		
		
		let i = 5
		
		
    }
    
}
