//
//  Movement.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 9/11/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

enum Movement {
	case OneExchange
	case TwoExchange
	case ThreeExchange
	
	func performMovement(initialSolution: [Int]) -> [Int] {
		let position1 = Int(arc4random_uniform(UInt32(initialSolution.count)))
		let position2 = randomPosition(max: initialSolution.count, exclusionGroup: [position1])
		
		switch self {
		case .OneExchange:
			return swap(initialSolution: initialSolution, x: position1, y: position2)
		case .TwoExchange:
			let position3 = randomPosition(max: initialSolution.count, exclusionGroup: [position1, position2])
			let position4 = randomPosition(max: initialSolution.count, exclusionGroup: [position1, position2, position3])
			
			let firstSwap = swap(initialSolution: initialSolution, x: position1, y: position3)
			return swap(initialSolution: firstSwap, x: position2, y: position4)
		case .ThreeExchange:
			let position3 = randomPosition(max: initialSolution.count, exclusionGroup: [position1, position2])
			let position4 = randomPosition(max: initialSolution.count, exclusionGroup: [position1, position2, position3])
			let position5 = randomPosition(max: initialSolution.count, exclusionGroup: [position1, position2, position3, position4])
			let position6 = randomPosition(max: initialSolution.count, exclusionGroup: [position1, position2, position3, position4, position5])
			
			let firstSwap = swap(initialSolution: initialSolution, x: position1, y: position4)
			let secondSwap = swap(initialSolution: firstSwap, x: position3, y: position6)
			return swap(initialSolution: secondSwap, x: position2, y: position5)
		}
	}
	
	private func swap(initialSolution: [Int], x: Int, y: Int) -> [Int] {
		var swappedSolution = initialSolution
		let helper = swappedSolution[y]
		swappedSolution[y] = swappedSolution[x]
		swappedSolution[x] = helper
		
		return swappedSolution
	}
	
	private func randomPosition(max:Int, exclusionGroup: [Int]) -> Int {
		var randomPosition: Int
		var valid = false
		
		repeat {
			randomPosition = Int(arc4random_uniform(UInt32(max)))
			valid = true
			
			for excluded in exclusionGroup {
				if (randomPosition == excluded) {
					valid = false
					break;
				}
			}
		} while (!valid)
		
		return randomPosition
	}
	
	static let allMovements = [OneExchange, TwoExchange, ThreeExchange]
	
	static func randomMovement() -> Movement {
		return allMovements[Int(arc4random_uniform(UInt32(allMovements.count)))]
	}
}
