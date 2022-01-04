//
//  RealityObject.swift
//  Hunter
//
//  Created by oksana on 04.01.22.
//

import Foundation

enum RealityObject: String {
    case plane, drummer, cup, kettle
    
    var scaleForMemoryGame: SIMD3<Float> {
        switch self {
        case .cup:
            return SIMD3<Float>(0.002, 0.002, 0.002)
        case .plane:
            return SIMD3<Float>(0.006, 0.006, 0.006)
        case .drummer:
            return SIMD3<Float>(0.01, 0.01, 0.01)
        case .kettle:
            return SIMD3<Float>(0.002, 0.002, 0.002)
        }
    }
    
    var scaleForClickGame: SIMD3<Float> {
        switch self {
        case .cup:
            return SIMD3<Float>(0.002, 0.002, 0.002)
        case .plane:
            return SIMD3<Float>(0.02, 0.02, 0.02)
        case .drummer:
            return SIMD3<Float>(0.002, 0.002, 0.002)
        case .kettle:
            return SIMD3<Float>(0.002, 0.002, 0.002)
        }
    }
}
