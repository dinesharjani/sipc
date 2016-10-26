//
//  Experiment.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 26/10/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

class Experiment: NSObject {

	let TimerInterval = 1
	
	let problem: Problem
	let algorithm: HeuristicAlgorithm
	let timeLimit: Int
	let numberOfThreads: Int
	
	var timer: Timer
	
	init (problem: Problem, algorithm: HeuristicAlgorithm, timeLimit: Int, numberOfThreads: Int) {
		self.problem = problem
		self.algorithm = algorithm
		self.timeLimit = timeLimit
		self.numberOfThreads = numberOfThreads
		self.timer = Timer()
	}
	
	func run() {
		// No-op.
	}
}
