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
		
			// line 0 has strip width.
			self.stripWidth = Int(lines[0])!
			
			var readRectangles = [Rectangle]()
			// line 1 is the number of rectangles, which we don't need.
			for i in 2 ..< lines.count {
				let rectangleProperties = lines[i].components(separatedBy: NSCharacterSet.whitespaces)
				readRectangles.append(Rectangle(id: i - 1, width: Int(rectangleProperties[0])!, height: Int(rectangleProperties[1])!))
			}
			
			self.rectangles = readRectangles
		}
		catch {
			self.stripWidth = 0
			self.rectangles = []
			
			throw ProblemError.couldNotRead
		}
	}
	
	public func applySolution(solution: [Int]) throws -> Strip {
		guard (solution.count == rectangles.count) else {
			throw ProblemError.invalidSolution
		}
		
		return Strip(width: self.stripWidth)
	}
}
