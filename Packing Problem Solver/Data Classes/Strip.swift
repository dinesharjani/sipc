//
//  Strip.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 8/10/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

class Strip: NSObject {

	let width: Int
	var height: Int
	private(set) public var placedRectangles: [PlacedRectangle]
	
	init(width: Int) {
		self.width = width
		self.height = 0
		self.placedRectangles = [PlacedRectangle]()
	}
	
	func placeRectangle(rectangle: Rectangle, position: Position) {
		let newRect = PlacedRectangle(rectangle: rectangle, position: position)
		placedRectangles.append(newRect)
		
		if (newRect.top() > self.height) {
			self.height = newRect.top()
		}
	}
}
