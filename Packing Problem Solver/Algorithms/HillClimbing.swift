//
//  HillClimbing.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 1/11/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

class HillClimbing: HeuristicAlgorithm {

	override func solve(problem: Problem) -> [Int] {
		let randomSolution = Algorithms.randomInstance.solve(problem: problem)
		
		return randomSolution
	}
}
