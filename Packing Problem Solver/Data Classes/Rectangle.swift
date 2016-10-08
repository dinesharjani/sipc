//
//  Rectangle.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 5/10/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

class Rectangle: NSObject {

	let width: Int
	let height: Int
	let margin: Int
	
	override convenience init() {
		self.init(width: 0, height: 0, margin: 0)
	}
	
	convenience init(rectangle: Rectangle) {
		self.init(width: rectangle.width, height: rectangle.height, margin: rectangle.margin)
	}
	
	init(width: Int, height: Int, margin: Int = 0) {
		self.width = width
		self.height = height
		self.margin = margin
	}
}
