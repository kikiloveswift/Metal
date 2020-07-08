//
//  ViewRender.swift
//  MetalDemo
//
//  Created by kong on 2020/7/7.
//  Copyright © 2020 kong. All rights reserved.
//

import MetalKit

final class ViewRender: NSObject {
    
    var device: MTLDevice!
    
    var commandQueue: MTLCommandQueue!
    
    var mesh: MTKMesh!
    
    var vertexBuffer: MTLBuffer!
    
    var pipelineState: MTLRenderPipelineState!
    
    var metalView: MTKView!
    
    var viewportSize: vector_uint2
    
    var timer: Float = 0
    
    override init() {
        viewportSize = vector_uint2(x: 0, y: 0)
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(mView: MTKView) {
        self.init()
        guard let dvc = MTLCreateSystemDefaultDevice() else {
            fatalError()
        }
        device = dvc
        metalView = mView
        metalView.device = device
        metalView.clearColor = MTLClearColor(red: 242.0/255,
                                             green: 194.0/255,
                                             blue: 192.0/255,
                                             alpha: 1.0)
        metalView.delegate = self
        guard let cqueue = device.makeCommandQueue() else {
            return
        }
        commandQueue = cqueue
        
        /// bind Library
        let library = device.makeDefaultLibrary()
        let vertexFunc = library?.makeFunction(name: "vertexShader_demoRender")
        let fragmentFunc = library?.makeFunction(name: "fragmentShader_demoRender")
        
        /// Creat pipeline state
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.label = "view render pipeline"
        pipelineDescriptor.vertexFunction = vertexFunc
        pipelineDescriptor.fragmentFunction = fragmentFunc
        pipelineDescriptor.colorAttachments[0].pixelFormat = metalView.colorPixelFormat
        
        do {
            pipelineState = try device.makeRenderPipelineState(descriptor: pipelineDescriptor)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

}

extension ViewRender: MTKViewDelegate {
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        viewportSize.x = uint(size.width)
        viewportSize.y = uint(size.height)
    }
    
    func draw(in view: MTKView) {
        
        var vertices: [ViewRenderVertex] = [
           ViewRenderVertex(position: vector_float3(x: 250, y: -250, z: 0), color: vector_float4(x: 1, y: 0, z: 0, w: 1)),
           ViewRenderVertex(position: vector_float3(x: -250, y: -250, z: 0), color: vector_float4(x: 0, y: 1, z: 0, w: 1)),
           ViewRenderVertex(position: vector_float3(x: 0, y: 250, z: 0), color: vector_float4(x: 0, y: 0, z: 1, w: 1)),
        ]
        
        guard let descriptor = view.currentRenderPassDescriptor,
            let commandBuffer = commandQueue.makeCommandBuffer(),
            let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: descriptor) else {
            return
        }
        
        commandBuffer.label = "TriangleCommand"
        renderEncoder.label = "TriangleRender"
        
        /// Set the region and draw it
        renderEncoder.setViewport(MTLViewport(originX: 0.0, originY: 0.0, width: Double(viewportSize.x), height: Double(viewportSize.y), znear: 0.0, zfar: 1.0))
        renderEncoder.setRenderPipelineState(pipelineState)
        
        /// pass vertices
        /// cal bytes
        let verticsData = NSData(bytes: &vertices, length: MemoryLayout<ViewRenderVertex>.size * vertices.count)
        renderEncoder.setVertexBytes(vertices, length: verticsData.length, index: Int(ViewRenderInputIndexVertices.rawValue))
        renderEncoder.setVertexBytes(&viewportSize, length: MemoryLayout.size(ofValue: viewportSize), index: Int(ViewRenderInputIndexViewportsize.rawValue))
        renderEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 3)
        renderEncoder.endEncoding()
        
        guard let drawable = view.currentDrawable else {
            return
        }
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
