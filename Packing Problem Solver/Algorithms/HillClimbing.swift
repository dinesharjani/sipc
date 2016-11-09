//
//  HillClimbing.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 1/11/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

class HillClimbing: HeuristicAlgorithm {

	private let NumberOfMovements = 10
	private let MaxNumberOfTriesWithoutImprovement = 3
	
	override func solve(problem: Problem) -> [Int] {
		let randomSolution = Algorithms.RandomAlgorithm.instance().solve(problem: problem)
		return findBestNeighbor(problem: problem, initialSolution: randomSolution)
	}
	
	func findBestNeighbor(problem: Problem, initialSolution: [Int]) -> [Int] {
		var bestNeighbor = initialSolution
		var bestNeighborStrip: BaseStrip
		do {
			bestNeighborStrip = try problem.applySolution(solution: bestNeighbor)
			var numberOfTriesWithoutImprovement = 0
			
			while (numberOfTriesWithoutImprovement < MaxNumberOfTriesWithoutImprovement) {
				numberOfTriesWithoutImprovement += 1
				let neighbors = self.neighbors(initialSolution: bestNeighbor)
				
				for i in 0..<neighbors.count {
					let neighborStrip = try problem.applySolution(solution: neighbors[i])
					if (neighborStrip.isBetterThan(otherStrip: bestNeighborStrip)) {
						bestNeighbor = neighbors[i]
						bestNeighborStrip = neighborStrip
						
						numberOfTriesWithoutImprovement = 0
					}
				}
			}
		}
		catch {
			// Keep going.
		}
		
		return bestNeighbor
	}
	
	private func neighbors(initialSolution: [Int]) -> [[Int]] {
		var neighbors = [[Int]]()
		for _ in 1...NumberOfMovements {
			let randomMovement = Movement.randomMovement()
			neighbors.append(randomMovement.performMovement(initialSolution: initialSolution))
		}
		
		return neighbors
	}
}
