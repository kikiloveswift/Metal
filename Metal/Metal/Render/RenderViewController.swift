//
//  RenderViewController.swift
//  Metal
//
//  Created by kong on 2020/7/7.
//  Copyright © 2020 kong. All rights reserved.
//

import Cocoa
import MetalKit

class RenderViewController: MetalViewController {

    var render: ViewRender?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Render Triangle"
        configRender()
    }
    
    func configRender() {
        guard let mtkView = self.view as? MTKView else {
            return
        }
        render = ViewRender(mView: mtkView)
        render?.mtkView(mtkView, drawableSizeWillChange: mtkView.drawableSize)
    }
    
    
}
