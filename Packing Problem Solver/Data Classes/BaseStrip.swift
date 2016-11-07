//
//  BaseStrip.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 21/10/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

enum StripType: String {
	case None = "---"
	case BinPackingProblem = "Bin Packing Problem"
	case StripPackingProblem = "Strip Packing Problem"
	
	static let allTypes = [None, BinPackingProblem, StripPackingProblem]
}

class BaseStrip: NSObject {

	private (set) public var width: Int
	private (set) public var height: Int
	private (set) public var placedRectangles: [PlacedRectangle]
	
	private var emptySpaces: [Rectangle]
	
	init(width: Int, height: Int) {
		self.width = width
		self.height = height
		placedRectangles = [PlacedRectangle]()
		emptySpaces = [Rectangle]()
	}
	
	func placeRectangles(rectangles: [Rectangle], order: [Int]) {
		// No-op.
		// Sub-classes must implement this.
	}
	
	func solutionStringValue() -> String {
		// No-op.
		// Sub-classes must implement this.
		return ""
	}
	
	func placeRectangle(rectangle: Rectangle, position: Position) {
		let newRect = PlacedRectangle(rectangle: rectangle, position: position)
		placedRectangles.append(newRect)
		
		if (newRect.top() > self.height) {
			self.height = newRect.top()
		}
		
		if (newRect.right() > self.width) {
			self.width = newRect.right()
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
	
	func isBetterThan(otherStrip: BaseStrip) -> Bool {
		return (self.height < otherStrip.height
			&& totalEmptySpacesArea() < otherStrip.totalEmptySpacesArea())
	}
	
	func guidanceValue() -> Int {
		return height
	}
	
	internal func totalEmptySpacesArea() -> Int {
		var total = 0
		for emptySpace in emptySpaces {
			total += emptySpace.area()
		}
		return total
	}
}
