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
		
		let widthAspectRatio = Float(dirtyRect.size.width) / (Float(strip!.width) + 2 * xOffset)
		let heightAspectRatio = Float(dirtyRect.size.height) / (Float(strip!.height) + 2 * yOffset)
		
		let xStart =  xOffset * widthAspectRatio
		let xEnd =  xStart + Float(strip!.width) * widthAspectRatio
		let yStart = heightAspectRatio * yOffset
		let yEnd = yStart + (Float(strip!.height) * heightAspectRatio)
		
		let blackColor = NSColor.black
		blackColor.setStroke()
		
		let stripOutlinePath = NSBezierPath()
		stripOutlinePath.move(to: NSMakePoint(CGFloat(xStart), CGFloat(yStart)))
		stripOutlinePath.line(to: NSMakePoint(CGFloat(xStart), CGFloat(yEnd)))
		stripOutlinePath.move(to: NSMakePoint(CGFloat(xStart), CGFloat(yStart)))
		stripOutlinePath.line(to: NSMakePoint(CGFloat(xEnd), CGFloat(yStart)))
		stripOutlinePath.line(to: NSMakePoint(CGFloat(xEnd), CGFloat(yEnd)))
		stripOutlinePath.stroke()
		
		let stripFillPath = NSBezierPath(rect: NSRect(x: CGFloat(xStart), y: CGFloat(yStart), width: CGFloat(Float(strip!.width) * widthAspectRatio), height: CGFloat((Float(strip!.height) * heightAspectRatio))))
		NSColor.white.setFill()
		stripFillPath.fill()
		
		for rectangle in strip!.placedRectangles {
			let xLowerLeftCorner = xStart + Float(rectangle.position.x) * widthAspectRatio
			let yLowerLeftCorner = yStart + Float(rectangle.position.y) * heightAspectRatio
			let xUpperRightCorner = xLowerLeftCorner + Float(rectangle.width) * widthAspectRatio
			let yUpperRightCorner = yLowerLeftCorner + Float(rectangle.height) * heightAspectRatio
			
			let rectPath = NSBezierPath()
			rectPath.move(to: NSMakePoint(CGFloat(xLowerLeftCorner), CGFloat(yLowerLeftCorner)))
			rectPath.line(to: NSMakePoint(CGFloat(xLowerLeftCorner), CGFloat(yUpperRightCorner)))
			rectPath.line(to: NSMakePoint(CGFloat(xUpperRightCorner), CGFloat(yUpperRightCorner)))
			rectPath.line(to: NSMakePoint(CGFloat(xUpperRightCorner), CGFloat(yLowerLeftCorner)))
			rectPath.line(to: NSMakePoint(CGFloat(xLowerLeftCorner), CGFloat(yLowerLeftCorner)))
			
			rectangle.color.setFill()
			rectPath.fill()
			rectPath.stroke()
		}
    }
	
	
}
