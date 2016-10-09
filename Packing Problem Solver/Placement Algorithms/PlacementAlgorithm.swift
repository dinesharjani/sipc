//
//  PlacementAlgorithm.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 9/10/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Foundation

protocol PlacementAlgorithm {
	
	func placeRectangles(rectangles: [Rectangle], order: [Int], strip: Strip)
}
