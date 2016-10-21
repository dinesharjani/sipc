//
//  BaseStrip.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 21/10/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

enum StripType {
	case BinPackingProblem
	case StripPackingProblem
}

class BaseStrip: NSObject {

	let width: Int
	private (set) public var height: Int
	private (set) public var placedRectangles: [PlacedRectangle]
	
	private var emptySpaces: [Rectangle]
	
	init(width: Int) {
		self.width = width
		height = 0
		placedRectangles = [PlacedRectangle]()
		emptySpaces = [Rectangle]()
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
	
	internal func totalEmptySpacesArea() -> Int {
		var total = 0
		for emptySpace in emptySpaces {
			total += emptySpace.area()
		}
		return total
	}
}
