//
//  StripView.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 9/10/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

extension PlacedRectangle {
	public func draw(xOffset: Float, yOffset: Float, widthAspectRatio: Float, heightAspectRatio: Float) {
		let xLowerLeftCorner = xOffset + Float(position.x) * widthAspectRatio
		let yLowerLeftCorner = yOffset + Float(position.y) * heightAspectRatio
		let xUpperRightCorner = xLowerLeftCorner + Float(width) * widthAspectRatio
		let yUpperRightCorner = yLowerLeftCorner + Float(height) * heightAspectRatio
		
		let path = NSBezierPath()
		path.move(to: NSMakePoint(CGFloat(xLowerLeftCorner), CGFloat(yLowerLeftCorner)))
		path.line(to: NSMakePoint(CGFloat(xLowerLeftCorner), CGFloat(yUpperRightCorner)))
		path.line(to: NSMakePoint(CGFloat(xUpperRightCorner), CGFloat(yUpperRightCorner)))
		path.line(to: NSMakePoint(CGFloat(xUpperRightCorner), CGFloat(yLowerLeftCorner)))
		path.line(to: NSMakePoint(CGFloat(xLowerLeftCorner), CGFloat(yLowerLeftCorner)))
		
		color.setFill()
		path.fill()
		path.stroke()
	}
}

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
		
		let stripWidthInPx = Float(strip!.width) * widthAspectRatio
		let stripHeightInPx = (Float(strip!.height) * heightAspectRatio)
		
		let xStart =  xOffset * widthAspectRatio
		let yStart = heightAspectRatio * yOffset
		
		let xEnd =  xStart + stripWidthInPx
		let yEnd = yStart + stripHeightInPx
		
		let blackColor = NSColor.black
		blackColor.setStroke()
		
		let stripOutlinePath = NSBezierPath()
		stripOutlinePath.move(to: NSMakePoint(CGFloat(xStart), CGFloat(yStart)))
		stripOutlinePath.line(to: NSMakePoint(CGFloat(xStart), CGFloat(yEnd)))
		stripOutlinePath.move(to: NSMakePoint(CGFloat(xStart), CGFloat(yStart)))
		stripOutlinePath.line(to: NSMakePoint(CGFloat(xEnd), CGFloat(yStart)))
		stripOutlinePath.line(to: NSMakePoint(CGFloat(xEnd), CGFloat(yEnd)))
		stripOutlinePath.stroke()
		
		let stripFillPath = NSBezierPath(rect: NSRect(x: CGFloat(xStart), y: CGFloat(yStart), width: CGFloat(stripWidthInPx), height: CGFloat(stripHeightInPx)))
		NSColor.white.setFill()
		stripFillPath.fill()
		
		for rectangle in strip!.placedRectangles {
			rectangle.draw(xOffset: xStart, yOffset: yStart, widthAspectRatio: widthAspectRatio, heightAspectRatio: heightAspectRatio)
		}
    }
	
	
}
