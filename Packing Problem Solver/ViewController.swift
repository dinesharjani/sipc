//
//  ViewController.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 5/10/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

	@IBOutlet weak var problemFilePathField: NSTextField!
	@IBOutlet weak var problemTypePopUp: NSPopUpButton!
	@IBOutlet weak var experimentTimeLimitField: NSTextField!
	@IBOutlet weak var experimentNumberOfThreads: NSPopUpButton!
	
	@IBOutlet weak var stripView: StripView!
	@IBOutlet weak var solutionHeightField: NSTextField!
	@IBOutlet weak var solutionUnusedAreaField: NSTextField!
	
	var problem: Problem?
	
    override func viewDidLoad() {
        super.viewDidLoad()

        problemTypePopUp?.isEnabled = false
		problemTypePopUp?.removeAllItems()
		for stripType in StripType.allTypes {
				problemTypePopUp?.addItem(withTitle: stripType.rawValue)
		}
		updateProblemType()
		
		experimentTimeLimitField?.formatter = IntegerNumberFormatter()
		experimentTimeLimitField?.intValue = 300
		
		experimentNumberOfThreads?.removeAllItems()
		for threadNumber in 1...ProcessInfo.processInfo.activeProcessorCount {
			experimentNumberOfThreads?.addItem(withTitle: String(threadNumber))
		}
		experimentNumberOfThreads?.isEnabled = false
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
	
	@IBAction func browseButtonTapped(sender: AnyObject) {
		let problemFileDialog: NSOpenPanel = NSOpenPanel()
		problemFileDialog.runModal()
		
		guard let problemFilePath = problemFileDialog.url?.path else {
			problemFilePathField?.stringValue = "No file selected!"
			problemFilePathField?.textColor = NSColor.red
			return
		}
		
		problemFilePathField?.stringValue = problemFilePath
		problemFilePathField?.textColor = NSColor.black
		
		do {
			problem = try Problem(filePath: problemFilePath)
			let solution = problem!.randomSolution()
			let strip = try problem!.applySolution(solution: solution)
			stripView!.strip = strip
			updateProblemType()
			
			solutionHeightField?.stringValue = strip.solutionStringValue()
			solutionUnusedAreaField?.stringValue = String(format: "Unused Area: %.2f%%", strip.unusedAreaPercentage())
		} catch {
			// TODO
		}
	}
	
	private func updateProblemType() {
		guard problem != nil else {
			problemTypePopUp?.selectItem(at: 0)
			return
		}
		
		switch problem!.stripType {
		case .BinPackingProblem:
			problemTypePopUp?.selectItem(at: 1)
		case .StripPackingProblem:
			problemTypePopUp?.selectItem(at: 2)
		default:
			problemTypePopUp?.selectItem(at: 0)
		}
	}
}

