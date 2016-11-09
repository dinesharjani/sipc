//
//  SimulatedAnnealing.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 9/11/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

class SimulatedAnnealing: HeuristicAlgorithm {
	
	override func solve(problem: Problem) -> [Int] {
		return Algorithms.HillClimbingAlgorithm.instance().solve(problem: problem)
	}
}
