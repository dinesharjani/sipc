//
//  Problem.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 5/10/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

enum ProblemError: Error {
	case couldNotRead
}

class Problem: NSObject {

	let stripWidth: Int
	let rectangles: [Rectangle]
	
	init(filePath: String) throws {
		
		// TODO read from a file.
		self.stripWidth = 0
		self.rectangles = []
	}
}
