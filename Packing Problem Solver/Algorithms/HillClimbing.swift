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
		let randomSolution = Algorithms.randomInstance.solve(problem: problem)
		var bestNeighbor = randomSolution
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
	
	private enum Movement {
		case OneExchange
		case TwoExchange
		case ThreeExchange
		
		func performMovement(initialSolution: [Int]) -> [Int] {
			switch self {
			case .OneExchange:
				fallthrough
			case .TwoExchange:
				fallthrough
			case .ThreeExchange:
				let position1 = Int(arc4random_uniform(UInt32(initialSolution.count)))
				var position2: Int
				repeat {
					position2 = Int(arc4random_uniform(UInt32(initialSolution.count)))
				} while (position2 == position1)
				
				return swap(solution: initialSolution, x: position1, y: position2)
			}
		}
		
		private func swap(solution: [Int], x: Int, y: Int) -> [Int] {
			var swappedSolution = solution
			let helper = swappedSolution[y]
			swappedSolution[y] = swappedSolution[x]
			swappedSolution[x] = helper
			
			return swappedSolution
		}
		
		static let allMovements = [OneExchange, TwoExchange, ThreeExchange]
		
		static func randomMovement() -> Movement {
			return allMovements[Int(arc4random_uniform(UInt32(allMovements.count)))]
		}
	}
}
