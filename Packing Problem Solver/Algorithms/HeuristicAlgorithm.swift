//
//  HeuristicAlgorithm.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 25/10/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

enum Algorithms: String {
	case RandomAlgorithm = "Random"
	static var randomInstance = Random()
	
	case HillClimbingAlgorithm = "Local Search"
	static let hillClimbingInstance = HillClimbing()
	
	static let allAlgorithms = [RandomAlgorithm, HillClimbingAlgorithm]
	
	static func algorithmFromValue(value: String) -> HeuristicAlgorithm {
		switch value {
		case RandomAlgorithm.rawValue:
			return randomInstance
		case HillClimbingAlgorithm.rawValue:
			return hillClimbingInstance
		default:
			return randomInstance
		}
	}
}

class HeuristicAlgorithm : NSObject {
	
	func solve(problem: Problem) -> [Int] {
		// No-op.
		// Subclasses must implement this
		return [Int]()
	}
}
