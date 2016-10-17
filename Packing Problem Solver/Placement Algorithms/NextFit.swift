//
//  BottomLeft.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 9/10/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

class NextFit: PlacementAlgorithm {

	let INF = Int.max
	
	func placeRectangles(rectangles: [Rectangle], order: [Int], strip: Strip) {
		var y = 0
		var rectanglesToPlace = rectangles
		
		// One while iteration per shelf.
		while (!rectanglesToPlace.isEmpty) {
			var x = 0
			var availableWidth = strip.width
			var shelfHeight = INF
			var i = 0
			
			while (i < rectanglesToPlace.count) {
				let rectangle = rectanglesToPlace[i]
				
				if (rectangle.fitsIn(width: availableWidth, height: shelfHeight)) {
					if (shelfHeight == INF) {
						shelfHeight = rectangle.height
					}
					
					strip.placeRectangle(rectangle: rectangle, position: Position(x: x, y: y))
					if (rectangle.height < shelfHeight) {
						strip.addEmptySpace(width: rectangle.width, height: shelfHeight - rectangle.height)
					}
					rectanglesToPlace.remove(at: i)
					
					x += rectangle.width
					availableWidth -= rectangle.width
				} else {
					i += 1
				}
			}
			
			// Move to next shelf.
			y += shelfHeight
			strip.addShelf(shelfHeight: y)
			
			if (availableWidth > 0) {
				strip.addEmptySpace(width: availableWidth, height: shelfHeight)
			}
		}
	}
}
