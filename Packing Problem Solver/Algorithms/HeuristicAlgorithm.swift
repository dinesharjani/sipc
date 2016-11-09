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
	case SimulatedAnnealingAlgorithm = "Simulated Annealing"
	
	private static let randomInstance = Random()
	private static let hillClimbingInstance = HillClimbing()
	private static let saInstance = SimulatedAnnealing()
	
	static let allAlgorithms = [RandomAlgorithm, HillClimbingAlgorithm, SimulatedAnnealingAlgorithm]
	
	func instance() -> HeuristicAlgorithm {
		switch self {
		case .RandomAlgorithm:
			return Algorithms.randomInstance
		case .HillClimbingAlgorithm:
			return Algorithms.hillClimbingInstance
		case .SimulatedAnnealingAlgorithm:
			return Algorithms.saInstance
		}
	}
	
	static func algorithmFromValue(value: String) -> HeuristicAlgorithm {
		switch value {
		case RandomAlgorithm.rawValue:
			return RandomAlgorithm.instance()
		case HillClimbingAlgorithm.rawValue:
			return HillClimbingAlgorithm.instance()
		case SimulatedAnnealingAlgorithm.rawValue:
			return SimulatedAnnealingAlgorithm.instance()
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
