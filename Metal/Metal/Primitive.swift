//
//  Primitive.swift
//  MetalApp
//
//  Created by konglee on 2020/7/5.
//

import MetalKit

final class Primitive {
    
    enum PrimitiveType<T> {
        case value(T)
        case error(Error)
    }
    
    enum MeshType {
        case box
        case cone
        case sphere
    }
    
    typealias ObjectType = PrimitiveType<(MeshType, Any?)>

    class func make(type: ObjectType, device: MTLDevice, size: Float) -> MDLMesh? {
        let allocator = MTKMeshBufferAllocator(device: device)
        let extent = vector3(size, size, size)
        
        switch type {
        case .value((let type, _)):
            switch type {
            case .box:
                return MDLMesh(boxWithExtent: extent, segments: vector3(1, 1, 1), inwardNormals: false, geometryType: .triangles, allocator: allocator)
            case .cone:
                return MDLMesh(coneWithExtent: extent, segments: vector2(10, 10), inwardNormals: false, cap: true, geometryType: .triangles, allocator: allocator)
            case.sphere:
                return MDLMesh(sphereWithExtent: extent, segments: vector2(100, 100), inwardNormals: false, geometryType: .triangles, allocator: allocator)
            }
        case .error(let error):
            print(error.localizedDescription);
            return nil
        }
    }
    
}
