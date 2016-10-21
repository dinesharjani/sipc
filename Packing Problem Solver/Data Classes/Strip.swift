//
//  Strip.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 8/10/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

enum StripType {
	case BinPackingProblem
	case StripPackingProblem
}

class Strip: NSObject {

	let INF = Int.max
	
	let width: Int
	private (set) public var height: Int
	
	private (set) public var placedRectangles: [PlacedRectangle]
	private (set) public var shelves: [Int]
	private var emptySpaces: [Rectangle]
	
	init(width: Int) {
		self.width = width
		self.height = 0
		self.placedRectangles = [PlacedRectangle]()
		self.shelves = [Int]()
		self.shelves.append(0)
		self.emptySpaces = [Rectangle]()
	}
	
	func placeRectangles(rectangles: [Rectangle], order: [Int]) {
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
	
	func placeRectangle(rectangle: Rectangle, position: Position) {
		let newRect = PlacedRectangle(rectangle: rectangle, position: position)
		placedRectangles.append(newRect)
		
		if (newRect.top() > self.height) {
			self.height = newRect.top()
		}
	}
	
	func addEmptySpace(width: Int, height: Int) {
		emptySpaces.append(Rectangle(id: emptySpaces.count, width: width, height: height))
	}
	
	func unusedAreaPercentage() -> Float {
		let stripArea = Float(width * height)
		let unusedArea = Float(totalEmptySpacesArea())
		return (unusedArea / stripArea) * 100
	}
	
	private func addShelf(shelfHeight: Int) {
		shelves.append(shelfHeight)
	}
	
	private func totalEmptySpacesArea() -> Int {
		var total = 0
		for emptySpace in emptySpaces {
			total += emptySpace.area()
		}
		return total
	}
}
