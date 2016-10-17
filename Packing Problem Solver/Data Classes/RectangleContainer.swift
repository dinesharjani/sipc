//
//  RectangleContainer.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 17/10/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

protocol RectangleContainer {

	var width: Int { get }
	var height: Int { get }
	var placedRectangles: [PlacedRectangle] { get }
	var shelves: [Int] { get }
	
	func placeRectangle(rectangle: Rectangle, position: Position)
	
	func addShelf(shelfHeight: Int)
	
	func unusedAreaPercentage() -> Float
}
