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
	
	let margin = Float(0.1)
	
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

		guard (strip != nil) else {
			return;
		}
		
		let xOffset = Int(margin * Float(strip!.width))
		let yOffset = Int(margin * Float(strip!.height))
		
		let widthAspectRatio = (Int(dirtyRect.size.width) + 2 * xOffset) / strip!.width
		let heightAspectRatio = (Int(dirtyRect.size.height) + 2 * yOffset) / strip!.height
		
		let xStart = xOffset * widthAspectRatio
		let xEnd =  strip!.width * widthAspectRatio
		let yStart = yOffset * heightAspectRatio
		let yEnd = strip!.height * heightAspectRatio
		
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
