//
//  HeuristicAlgorithm.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 25/10/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

enum Algorithms: String {
	case Random = "Random"
	
	static let allAlgorithms = [Random]
}

class HeuristicAlgorithm : NSObject {
	
	func solve(problem: Problem) -> [Int] {
		// No-op.
		// Subclasses must implement this
		return [Int]()
	}
}
