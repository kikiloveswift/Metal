//
//  MetalViewController.swift
//  MetalDemo
//
//  Created by kong on 2020/7/7.
//  Copyright © 2020 kong. All rights reserved.
//

import Cocoa
import MetalKit

class MetalViewController: NSViewController {
    
    lazy var mtkView: MTKView = {
        let v = MTKView(frame: self.view.bounds)
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        setupView()
    }
    
    func setupView() {
        self.view = mtkView;
    }
    
}
