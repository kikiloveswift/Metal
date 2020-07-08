//
//  ViewController.swift
//  Metal
//
//  Created by kong on 2020/7/7.
//  Copyright © 2020 kong. All rights reserved.
//

import Cocoa
import MetalKit

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
   
    @IBAction func renderClick(_ sender: NSButton) {
        let renderVC = RenderViewController(nibName: "RenderViewController", bundle: Bundle.main)
        self.presentAsModalWindow(renderVC)
    }
    
    @IBAction func computeClick(_ sender: NSButton) {
        let textureVC = TextureViewController(nibName: "TextureViewController", bundle: Bundle.main)
        self.presentAsModalWindow(textureVC)
    }
    
    
}

