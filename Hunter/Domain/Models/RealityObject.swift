//
//  RealityObject.swift
//  Hunter
//
//  Created by oksana on 04.01.22.
//

import Foundation

enum RealityObject: Int {
    case plane = 0, drummer, cup, kettle, tv, sneaker
    
    var name: String {
        switch self {
        case .cup:
            return "cup"
        case .plane:
            return "plane"
        case .drummer:
            return "drummer"
        case .kettle:
            return "kettle"
        case .tv:
            return "tv"
        case .sneaker:
            return "sneaker"
        }
    }
    
    var scaleForMemoryGame: SIMD3<Float> {
        switch self {
        case .cup:
            return SIMD3<Float>(0.007, 0.007, 0.007)
        case .plane:
            return SIMD3<Float>(0.009, 0.009, 0.009)
        case .drummer:
            return SIMD3<Float>(0.012, 0.012, 0.012)
        case .kettle:
            return SIMD3<Float>(0.003, 0.003, 0.003)
        case .tv:
            return SIMD3<Float>(0.002, 0.002, 0.002)
        case .sneaker:
            return SIMD3<Float>(0.008, 0.008, 0.008)
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
        case .tv:
            return SIMD3<Float>(0.002, 0.002, 0.002)
        case .sneaker:
            return SIMD3<Float>(0.002, 0.002, 0.002)
        }
    }
}
