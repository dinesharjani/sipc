//
//  PlacedRectangle.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 8/10/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

struct Position {
	let x: Int
	let y: Int
}

class PlacedRectangle: Rectangle {

	let position: Position
	
	init(rectangle: Rectangle, position: Position) {
		self.position = position
		
		super.init(id: rectangle.id, width: rectangle.width, height: rectangle.height, margin: rectangle.margin)
	}
	
	func top() -> Int {
		return super.height + position.y
	}
	
	func right() -> Int {
		return super.width + position.x
	}
}
