//
//  Strip.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 8/10/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

class Strip: NSObject, RectangleContainer {

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
	
	func addShelf(shelfHeight: Int) {
		shelves.append(shelfHeight)
	}
	
	func unusedAreaPercentage() -> Float {
		let stripArea = Float(width * height)
		let unusedArea = Float(totalEmptySpacesArea())
		return (unusedArea / stripArea) * 100
	}
	
	private func totalEmptySpacesArea() -> Int {
		var total = 0
		for emptySpace in emptySpaces {
			total += emptySpace.area()
		}
		return total
	}
}
