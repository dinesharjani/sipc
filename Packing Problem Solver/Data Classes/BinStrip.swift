//
//  BinStrip.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 21/10/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

class BinStrip: BaseStrip {

	private (set) public var bins: [Int]
	
	override init(width: Int, height: Int) {
		self.bins = [Int]()
		super.init(width: width, height: height)
	}
	
	override func placeRectangles(rectangles: [Rectangle], order: [Int]) {
		let binWidth = rectangles[0].width
		
		var rectanglesToPlace = rectangles
		var x = 0
		
		while (!rectanglesToPlace.isEmpty) {
			var y = 0
			var availableHeight = height
			var i = 0
			bins.append(x)
			
			while (i < rectanglesToPlace.count) {
				let currentRectangle = rectanglesToPlace[i]
				
				if (currentRectangle.fitsIn(width: binWidth, height: availableHeight)) {
					placeRectangle(rectangle: currentRectangle, position: Position(x: x, y: y))
					rectanglesToPlace.remove(at: i)
					y += currentRectangle.height
					availableHeight -= currentRectangle.height
				} else {
					i += 1
				}
			}
			
			// Move to next bin.
			if (!rectanglesToPlace.isEmpty) {
				x += binWidth
				
				if (availableHeight > 0) {
					addEmptySpace(width: binWidth, height: availableHeight)
				}
			}
		}
	}
}
