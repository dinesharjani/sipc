//
//  Random.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 26/10/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

class Random: HeuristicAlgorithm {

	override func solve(problem: Problem) -> [Int] {
		var remainingRectangles = [Int]()
		for i in 0 ..< problem.rectangles.count {
			remainingRectangles.append(i)
		}
		
		var solution = [Int]()
		while (!remainingRectangles.isEmpty) {
			let randomRectanglePosition = Int(arc4random_uniform(UInt32(remainingRectangles.count)))
			let randomRectangle = remainingRectangles[randomRectanglePosition]
			
			solution.append(randomRectangle)
			remainingRectangles.remove(at: randomRectanglePosition)
		}
		return solution
	}
}
