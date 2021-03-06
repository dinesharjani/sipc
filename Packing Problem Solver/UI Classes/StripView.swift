//
//  StripView.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 9/10/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

extension PlacedRectangle {
	func draw(xStart: Float, yStart: Float, widthAspectRatio: Float, heightAspectRatio: Float) {
		NSColor.black.setStroke()
		
		let xLowerLeftCorner = xStart + Float(position.x) * widthAspectRatio
		let yLowerLeftCorner = yStart + Float(position.y) * heightAspectRatio
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

extension BaseStrip {
	func draw(rect: NSRect, xStart: Float, yStart: Float, widthAspectRatio: Float, heightAspectRatio: Float) {
		let stripWidthInPx = Float(width) * widthAspectRatio
		let stripHeightInPx = Float(height) * heightAspectRatio
		
		let xEnd =  xStart + stripWidthInPx
		let yEnd = yStart + stripHeightInPx
		
		NSColor.black.setStroke()
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
	}
}

extension Strip {
	override func draw(rect: NSRect, xStart: Float, yStart: Float, widthAspectRatio: Float, heightAspectRatio: Float) {
		super.draw(rect: rect, xStart: xStart, yStart: yStart, widthAspectRatio: widthAspectRatio, heightAspectRatio: heightAspectRatio);
		
		let xEnd =  xStart + Float(width) * widthAspectRatio
		
		NSColor.blue.setStroke()
		let dashes: [CGFloat] = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
		for shelf in shelves {
			let yShelf = yStart + Float(shelf) * heightAspectRatio
			
			let shelfDashedPath = NSBezierPath()
			shelfDashedPath.move(to: NSMakePoint(0.0, CGFloat(yShelf)))
			shelfDashedPath.line(to: NSMakePoint(CGFloat(xEnd + xStart), CGFloat(yShelf)))
			shelfDashedPath.setLineDash(dashes, count: dashes.count, phase: 0.0)
			shelfDashedPath.lineCapStyle = .buttLineCapStyle
			shelfDashedPath.stroke()
		}
	}
}

extension BinStrip {
	override func draw(rect: NSRect, xStart: Float, yStart: Float, widthAspectRatio: Float, heightAspectRatio: Float) {
		super.draw(rect: rect, xStart: xStart, yStart: yStart, widthAspectRatio: widthAspectRatio, heightAspectRatio: heightAspectRatio);
		
		let yTop = yStart + Float(height) * heightAspectRatio
		let stripTopPath = NSBezierPath()
		stripTopPath.move(to: NSMakePoint(CGFloat(xStart), CGFloat(yTop)))
		stripTopPath.line(to: NSMakePoint(CGFloat(xStart + Float(width) * widthAspectRatio), CGFloat(yTop)))
		stripTopPath.stroke()
		
		var verticalLines = bins
		verticalLines.append(width)
		
		NSColor.blue.setStroke()
		for line in verticalLines {
			let xLine = xStart + Float(line) * widthAspectRatio
			
			let dashedBinPath = NSBezierPath()
			dashedBinPath.move(to: NSMakePoint(CGFloat(xLine), 0.0))
			dashedBinPath.line(to: NSMakePoint(CGFloat(xLine), CGFloat(rect.maxY)))
			dashedBinPath.stroke()
		}
	}
}

class StripView: NSView {

	var strip: BaseStrip? {
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
		let yStart = heightAspectRatio * yOffset
		
		strip!.draw(rect: dirtyRect, xStart: xStart, yStart: yStart, widthAspectRatio: widthAspectRatio, heightAspectRatio: heightAspectRatio)
		
		for rectangle in strip!.placedRectangles {
			rectangle.draw(xStart: xStart, yStart: yStart, widthAspectRatio: widthAspectRatio, heightAspectRatio: heightAspectRatio)
		}
    }
}
