//
//  ViewRenderShaderTypes.h
//  MetalDemo
//
//  Created by kong on 2020/7/8.
//  Copyright © 2020 kong. All rights reserved.
//

#ifndef ViewRenderShaderTypes_h
#define ViewRenderShaderTypes_h

#include <simd/simd.h>

typedef enum ViewRenderInputIndex {
    ViewRenderInputIndexVertices = 0,
    ViewRenderInputIndexViewportsize = 1,
} ViewRenderInputIndex;

typedef struct {
    vector_float3 position;
    vector_float4 color;
} ViewRenderVertex;

#endif /* ViewRenderShaderTypes_h */
