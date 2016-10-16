//
//  Rectangle.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 5/10/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

class Rectangle: NSObject {

	let id: Int
	let width: Int
	let height: Int
	let margin: Int
	let color: NSColor
	
	override convenience init() {
		self.init(id: 0, width: 0, height: 0, margin: 0)
	}
	
	convenience init(rectangle: Rectangle) {
		self.init(id: rectangle.id, width: rectangle.width, height: rectangle.height, margin: rectangle.margin)
	}
	
	init(id: Int, width: Int, height: Int, margin: Int = 0) {
		self.id = id
		self.width = width
		self.height = height
		self.margin = margin
		
		srand48(width + height + id * 1400)
		self.color = NSColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1)
	}
	
	func fitsIn(width: Int, height: Int) -> Bool {
		return (self.width + 2 * margin) <= width && (self.height + 2 * margin) <= height;
	}
	
	func area() -> Int {
		return (width + 2 * margin) * (height + 2 * margin)
	}
}
