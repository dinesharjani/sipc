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
	let stripType: StripType
	let rectangles: [Rectangle]
	
	init(filePath: String) throws {
		
		do {
			let textFile = try String(contentsOf: URL(fileURLWithPath: filePath), encoding:String.Encoding.utf8)
			let lines = textFile.components(separatedBy: NSCharacterSet.newlines)
		
			let numberOfRectangles = Int(lines[0])!
			self.stripWidth = Int(lines[1])!
			
			if (lines[2].components(separatedBy: NSCharacterSet.whitespaces).count == 1) {
				stripType = .BinPackingProblem
			} else {
				stripType = .StripPackingProblem
			}
			
			var readRectangles = [Rectangle]()
			for i in 0 ..< numberOfRectangles {
				let rectangleProperties = lines[i + 2].components(separatedBy: NSCharacterSet.whitespaces)
				
				if (stripType == .BinPackingProblem) {
					// BPP - width is same as the bin's width, and height is given for each rectangle.
					readRectangles.append(Rectangle(id: i + 1, width: stripWidth, height: Int(rectangleProperties[0])!))
				} else {
					// SPP - both width and height for every rectangle are given.
					readRectangles.append(Rectangle(id: i + 1, width: Int(rectangleProperties[0])!, height: Int(rectangleProperties[1])!))
				}
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
	
	public func applySolution(solution: [Int], placementAlgorithm: PlacementAlgorithm) throws -> Strip {
		guard (solution.count == rectangles.count) else {
			throw ProblemError.invalidSolution
		}
		
		let strip = Strip(width: self.stripWidth)
		placementAlgorithm.placeRectangles(rectangles: rectangles, order: solution, strip: strip)
		
		return strip
	}
}
