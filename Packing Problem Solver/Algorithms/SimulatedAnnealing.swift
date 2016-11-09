//
//  SimulatedAnnealing.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 9/11/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

class SimulatedAnnealing: HeuristicAlgorithm {
	
	private static let MaxNumberOfSteps = 10
	private static let StartingTemperature = 29.87
	private static let CoolingFactor = 0.877
	
	override func solve(problem: Problem) -> [Int] {
		var bestSolution: [Int]
		
		do {
			bestSolution = Algorithms.RandomAlgorithm.instance().solve(problem: problem)
			var bestStrip = try problem.applySolution(solution: bestSolution)
			
			var temperature = SimulatedAnnealing.StartingTemperature
			var numberOfSteps = 1
			print(String(format: "Temperature: %.2f°C", temperature))
			
			repeat {
				for _ in 1...numberOfSteps {
					let neighborSolution = neighbor(startingSolution: bestSolution, currentTemperature: temperature)
					let neighborStrip = try problem.applySolution(solution: neighborSolution)
					
					if (neighborStrip.isBetterThan(otherStrip: bestStrip)
						|| acceptWorseSolution(currentValue: bestStrip.guidanceValue(), proposedValue: neighborStrip.guidanceValue(), temperature: temperature)) {
						bestSolution = neighborSolution
						bestStrip = neighborStrip
					}
				}
				
				temperature *= SimulatedAnnealing.CoolingFactor
				if (numberOfSteps < SimulatedAnnealing.MaxNumberOfSteps) {
					numberOfSteps += 1
				}
				print(String(format: "Temperature: %.2f°C", temperature))
			} while (temperature >= 1)
		}
		catch {
			// Keep going.
		}
		
		return bestSolution
	}
	
	private func neighbor(startingSolution: [Int], currentTemperature: Double) -> [Int] {
		return Movement.OneExchange.performMovement(initialSolution: startingSolution)
	}
	
	private func acceptWorseSolution(currentValue: Int, proposedValue: Int, temperature: Double) -> Bool {
		let p = abs(Double(currentValue) - Double(proposedValue)) / temperature
		let r = randomNumberBetweenZeroAndOne()
		return exp(p) > r
	}
	
	private func randomNumberBetweenZeroAndOne() -> Double {
		return Double(arc4random()) / Double(UInt32.max)
	}
}
