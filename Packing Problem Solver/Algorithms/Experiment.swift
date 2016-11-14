//
//  Experiment.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 26/10/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

class Experiment: NSObject {

	private let TimerInterval = 1
	
	var bestSolution: BaseStrip?
	var totalNumberOfIterations: Int
	var averageSolution: Float {
		get {
			var acc: Float = 0.0
			for value in solutionsList {
				acc += value
			}
			return acc / Float(solutionsList.count)
		}
	}
	
	private var callbackQueue: DispatchQueue {
		return DispatchQueue.main
	}
	private var controlQueue: DispatchQueue {
		return DispatchQueue(label: "com.packagesolver.experiment.control")
	}
	private var computationalQueue: DispatchQueue {
		return DispatchQueue.global(qos: DispatchQoS.QoSClass.utility)
	}
	
	private let problem: Problem
	private let algorithm: HeuristicAlgorithm
	private let timeLimit: Int
	private let numberOfThreads: Int
	private var solutionsList: [Float]
	
	private var timer: Timer
	private var accumulatedTime: Int
	private var finished: Bool
	private var callback: ((_ elapsed: Int, _ finished: Bool) -> Void)?
	
	init (problem: Problem, algorithm: HeuristicAlgorithm, timeLimit: Int, numberOfThreads: Int) {
		self.problem = problem
		self.algorithm = algorithm
		self.timeLimit = timeLimit
		self.numberOfThreads = numberOfThreads
		self.solutionsList = [Float]()
		self.timer = Timer()
		totalNumberOfIterations = 0
		accumulatedTime = 0
		finished = false
	}
	
	func run(callback: @escaping (_ elapsed: Int, _ finished: Bool) -> Void) {
		self.callback = callback
		self.timer.invalidate()
		finished = false
		accumulatedTime = 0
		
		timer = Timer.scheduledTimer(timeInterval: TimeInterval(TimerInterval), target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
		for i in 1...numberOfThreads {
			computationalQueue.async {
				self.solve(threadNumber: i)
			}
		}
	}
	
	func timerAction() {
		controlQueue.async {
			self.accumulatedTime += self.TimerInterval
			if (self.accumulatedTime >= self.timeLimit) {
				self.timer.invalidate()
				self.finished = true
			}
			
			self.callbackQueue.async {
				self.callback!(self.accumulatedTime, self.finished)
			}
		}
	}
	
	private func solve(threadNumber: Int) {
		var numberOfIterations = 0
		autoreleasepool {
			while (!finished) {
				do {
					let solutionOrder = algorithm.solve(problem: problem)
					let solution = try problem.applySolution(solution: solutionOrder)
					guard (!finished) else {
						return
					}
					
					controlQueue.sync {
						totalNumberOfIterations += 1
						solutionsList.append(Float(solution.guidanceValue()))
						
						guard (bestSolution != nil) else {
							bestSolution = solution
							return;
						}
					
						if (bestSolution!.guidanceValue() > solution.guidanceValue()
							|| bestSolution!.totalEmptySpacesArea() > solution.totalEmptySpacesArea()) {
							bestSolution = solution
						}
					}
				} catch {
					// try again
				}
				numberOfIterations += 1
			}
		}
	}
}
