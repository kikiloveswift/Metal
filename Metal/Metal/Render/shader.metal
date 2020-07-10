//
//  shaderDemo.metal
//  MetalApp
//
//  Created by konglee on 2020/7/4.
//

#include <metal_stdlib>
#include <simd/simd.h>
#import "ViewRenderShaderTypes.h"

using namespace metal;
// vertexShader_demoRender  fragmentShader_demoRender

typedef struct {
    // [[position]] is attribute, vertex's position data
    float4 position [[position]];
//    float4 color [[flat]];
    float4 color;
} RasterData;

vertex RasterData vertexShader_demoRender(uint vertextID[[vertex_id]],
                                          constant ViewRenderVertex *vertices [[buffer(ViewRenderInputIndexVertices)]],
                                          constant vector_uint2 *viewportSizePointer [[buffer(ViewRenderInputIndexViewportsize)]]) {
    RasterData out;
    
    float2 pixelSpacePosition = vertices[vertextID].position.xy;
    
    vector_float2 viewportSize = vector_float2(*viewportSizePointer);
    
    out.position = vector_float4(0.0, 0.0, 0.0, 1.0);
    
    // trans Coordinate & Ask question
    out.position.xy = pixelSpacePosition.xy / (viewportSize.xy / 2.0);
    out.color = vertices[vertextID].color;
    
    // pass to raster stage
    return out;
}

// data from Raster stage
fragment float4 fragmentShader_demoRender(RasterData in [[stage_in]]) {
    return in.color;
}
