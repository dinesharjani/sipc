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
	case HillClimbingAlgorithm = "Local Search"
	
	private static var randomInstance = Random()
	private static let hillClimbingInstance = HillClimbing()
	
	static let allAlgorithms = [RandomAlgorithm, HillClimbingAlgorithm]
	
	func instance() -> HeuristicAlgorithm {
		switch self {
		case .RandomAlgorithm:
			return Algorithms.randomInstance
		case .HillClimbingAlgorithm:
			return Algorithms.hillClimbingInstance
		}
	}
	
	static func algorithmFromValue(value: String) -> HeuristicAlgorithm {
		switch value {
		case RandomAlgorithm.rawValue:
			return RandomAlgorithm.instance()
		case HillClimbingAlgorithm.rawValue:
			return hillClimbingInstance
		default:
			return HillClimbingAlgorithm.instance()
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
