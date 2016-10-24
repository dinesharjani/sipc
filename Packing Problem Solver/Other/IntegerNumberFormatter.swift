//
//  IntegerNumberFormatter.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 24/10/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

class IntegerNumberFormatter: NumberFormatter {

	override func isPartialStringValid(_ partialString: String, newEditingString newString: AutoreleasingUnsafeMutablePointer<NSString?>?, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
		
		if partialString.isEmpty {
			return true
		}
		
		let nonDecimalCharacterSet = NSCharacterSet.decimalDigits.inverted
		if partialString.localizedLowercase.rangeOfCharacter(from: nonDecimalCharacterSet) != nil {
			NSBeep()
			return false
		}
		
		return true
	}
}
