//
//  BinStrip.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 21/10/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

class BinStrip: BaseStrip {

	private (set) public var bins: [Int]
	
	override init(width: Int, height: Int) {
		self.bins = [Int]()
		super.init(width: width, height: height)
	}
}
