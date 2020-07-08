//
//  TextureViewController.swift
//  MetalDemo
//
//  Created by kong on 2020/7/8.
//  Copyright © 2020 kong. All rights reserved.
//

import Cocoa
import MetalKit

class TextureViewController: MetalViewController {

    private var render: TextureRender?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.title = "Texture"
        configRender()
    }
    
    func configRender() {
        guard let mtkView = self.view as? MTKView else {
            return
        }
        render = TextureRender(mView: mtkView)
        render?.mtkView(mtkView, drawableSizeWillChange: mtkView.drawableSize)
    }
    
}
