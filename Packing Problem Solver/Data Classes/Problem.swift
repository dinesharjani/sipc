//
//  Problem.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 5/10/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

enum ProblemError: Error {
	case couldNotRead
	case invalidSolution
}

class Problem: NSObject {

	let stripWidth: Int
	let rectangles: [Rectangle]
	
	init(filePath: String) throws {
		
		do {
			let textFile = try String(contentsOf: URL(fileURLWithPath: filePath), encoding:String.Encoding.utf8)
			let lines = textFile.components(separatedBy: NSCharacterSet.newlines)
		
			let numberOfRectangles = Int(lines[0])!
			self.stripWidth = Int(lines[1])!
			
			var readRectangles = [Rectangle]()
			for i in 0 ..< numberOfRectangles {
				let rectangleProperties = lines[i + 2].components(separatedBy: NSCharacterSet.whitespaces)
				readRectangles.append(Rectangle(id: i + 1, width: Int(rectangleProperties[0])!, height: Int(rectangleProperties[1])!))
			}
			
			self.rectangles = readRectangles
		}
		catch {
			self.stripWidth = 0
			self.rectangles = []
			
			throw ProblemError.couldNotRead
		}
	}
	
	public func randomSolution() -> [Int] {
		var remainingRectangles = [Int]()
		for i in 0 ..< rectangles.count {
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
	
	public func applySolution(solution: [Int]) throws -> Strip {
		guard (solution.count == rectangles.count) else {
			throw ProblemError.invalidSolution
		}
		
		return Strip(width: self.stripWidth)
	}
}
