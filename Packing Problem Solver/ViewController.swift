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
	
	var problem: Problem?
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
		} catch {
			
		}
	}
}

