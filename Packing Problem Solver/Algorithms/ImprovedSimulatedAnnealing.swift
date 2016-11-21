//
//  ImprovedSimulatedAnnealing.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 14/11/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

class ImprovedSimulatedAnnealing: SimulatedAnnealing {

	private static let ThreeMovementTemperatureThreshold = 1.0
	private static let TwoMovementTemperatureThreshold = 0.1
	
	override internal func neighbor(startingSolution: [Int], currentTemperature: Double) -> [Int] {
		if (currentTemperature >= ImprovedSimulatedAnnealing.ThreeMovementTemperatureThreshold) {
			return Movement.ThreeExchange.performMovement(initialSolution: startingSolution)
		} else if (currentTemperature >= ImprovedSimulatedAnnealing.TwoMovementTemperatureThreshold) {
			return Movement.TwoExchange.performMovement(initialSolution: startingSolution)
		} else {
			return Movement.OneExchange.performMovement(initialSolution: startingSolution)
		}
	}
	
	override internal func startingTemperature() -> Double {
		return 2.87
	}
	
	override internal func haltingTemperature() -> Double {
		return 0.01
	}
}
