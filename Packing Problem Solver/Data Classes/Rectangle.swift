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
		
		let total = width + height
		srand48(total * 2000)
		let r = CGFloat(drand48())
		srand48(total)
		let g = CGFloat(drand48())
		srand48(total / 2000)
		let b = CGFloat(drand48())
		
		self.color = NSColor(red: r, green: g, blue: b, alpha: 1)
	}
	
	func fitsIn(width: Int, height: Int) -> Bool {
		return (self.width + 2 * margin) <= width && (self.height + 2 * margin) <= height;
	}
}
