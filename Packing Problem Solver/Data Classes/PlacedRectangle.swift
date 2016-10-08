//
//  PlacedRectangle.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 8/10/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

class PlacedRectangle: Rectangle {

	let x: Int
	let y: Int
	
	init(rectangle: Rectangle, x: Int, y: Int) {
		self.x = x
		self.y = y
		
		super.init(width: rectangle.width, height: rectangle.height, margin: rectangle.margin)
	}
}
