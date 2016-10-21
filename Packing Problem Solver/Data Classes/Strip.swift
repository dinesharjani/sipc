//
//  Strip.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 8/10/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

class Strip: BaseStrip {

	let INF = Int.max
	
	private (set) public var shelves: [Int]
	
	convenience init (width: Int) {
		self.init(width: width, height: 0)
	}
	
	override init(width: Int, height: Int) {
		self.shelves = [Int]()
		self.shelves.append(0)
		super.init(width: width, height: 0)
	}
	
	override func placeRectangles(rectangles: [Rectangle], order: [Int]) {
		var y = 0
		var rectanglesToPlace = rectangles
		
		// One while iteration per shelf.
		while (!rectanglesToPlace.isEmpty) {
			var x = 0
			var availableWidth = width
			var shelfHeight = INF
			var i = 0
			
			while (i < rectanglesToPlace.count) {
				let rectangle = rectanglesToPlace[i]
				
				if (rectangle.fitsIn(width: availableWidth, height: shelfHeight)) {
					if (shelfHeight == INF) {
						shelfHeight = rectangle.height
					}
					
					placeRectangle(rectangle: rectangle, position: Position(x: x, y: y))
					if (rectangle.height < shelfHeight) {
						addEmptySpace(width: rectangle.width, height: shelfHeight - rectangle.height)
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
			addShelf(shelfHeight: y)
			
			if (availableWidth > 0) {
				addEmptySpace(width: availableWidth, height: shelfHeight)
			}
		}
	}
	
	private func addShelf(shelfHeight: Int) {
		shelves.append(shelfHeight)
	}
}
