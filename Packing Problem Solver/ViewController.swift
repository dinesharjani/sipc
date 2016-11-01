//
//  ViewController.swift
//  Packing Problem Solver
//
//  Created by Dinesh Harjani on 5/10/16.
//  Copyright © 2016 Dinesh Harjani. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

	@IBOutlet weak var problemBrowseButton: NSButton!
	@IBOutlet weak var problemFilePathField: NSTextField!
	@IBOutlet weak var problemTypePopUp: NSPopUpButton!
	
	@IBOutlet weak var experimentBox: NSBox!
	@IBOutlet weak var experimentTimeLimitField: NSTextField!
	@IBOutlet weak var experimentNumberOfThreads: NSPopUpButton!
	@IBOutlet weak var experimentAlgorithmPopUp: NSPopUpButton!
	@IBOutlet weak var experimentRunButton: NSButton!
	@IBOutlet weak var experimentProgressBar: NSProgressIndicator!
	
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
		
		experimentBox?.isHidden = true
		experimentTimeLimitField?.formatter = IntegerNumberFormatter()
		experimentTimeLimitField?.intValue = 20
		
		experimentAlgorithmPopUp?.removeAllItems()
		for algorithm in Algorithms.allAlgorithms {
			experimentAlgorithmPopUp?.addItem(withTitle: algorithm.rawValue)
		}
		
		experimentNumberOfThreads?.removeAllItems()
		for threadNumber in 1...ProcessInfo.processInfo.activeProcessorCount {
			experimentNumberOfThreads?.addItem(withTitle: String(threadNumber))
		}
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
		experimentBox?.isHidden = false
		
		do {
			problem = try Problem(filePath: problemFilePath)
			let solution = Random().solve(problem: problem!)
			let strip = try problem!.applySolution(solution: solution)
			updateStrip(strip: strip)
			updateProblemType()
		} catch {
			// TODO
		}
	}
	
	@IBAction func runButtonTapped(sender: AnyObject) {
		problemBrowseButton?.isEnabled = false
		experimentTimeLimitField?.isEnabled = false
		experimentAlgorithmPopUp?.isEnabled = false
		
		experimentRunButton.isEnabled = false
		experimentProgressBar.minValue = 0
		experimentProgressBar.maxValue = Double(experimentTimeLimitField.integerValue)
		experimentProgressBar.doubleValue = 0.0
		
		let experiment = Experiment(problem: problem!, algorithm: Algorithms.algorithmFromValue(value: experimentAlgorithmPopUp!.selectedItem!.title), timeLimit: experimentTimeLimitField!.integerValue, numberOfThreads: experimentNumberOfThreads!.indexOfSelectedItem + 1);
		experiment.run { (elapsed, finished) in
			self.experimentProgressBar.doubleValue = Double(elapsed)
			
			// Maybe one isn't ready yet.
			if (experiment.bestSolution != nil) {
				self.updateStrip(strip: experiment.bestSolution!)
			}
			
			if (finished) {
				self.problemBrowseButton?.isEnabled = true
				self.experimentRunButton.isEnabled = true
				self.experimentTimeLimitField?.isEnabled = true
				self.experimentAlgorithmPopUp?.isEnabled = true
			}
		}
	}
	
	private func updateStrip(strip: BaseStrip) {
		self.stripView!.strip = strip
		self.solutionHeightField?.stringValue = strip.solutionStringValue()
		self.solutionUnusedAreaField?.stringValue = String(format: "Waste Area: %.2f%%", strip.unusedAreaPercentage())
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

