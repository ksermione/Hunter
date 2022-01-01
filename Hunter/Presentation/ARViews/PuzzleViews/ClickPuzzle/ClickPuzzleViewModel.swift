//
//  ClickPuzzleViewModel.swift
//  Hunter
//
//  Created by oksana on 27.12.21.
//

import Foundation
import SwiftUI
import RealityKit

class ClickPuzzleViewModel: ObservableObject {
    
    let boxesNumber: Int
    private var boxesCollected = 0
    private let delegate: MarkerDelegate
    
    let locations: [SIMD3<Float>] = [
        [0, 0, 0],
        [1.2, 0, 0.4],
        [-1.3, 0, 0.7],
        
        [-1.2, 0, -1.8],
        [1.1, 0, 1.3],
        
        [0, 0, -2.3],
        [1.5, 0, -2.4],
        [-1.5, 0, -2.6]
    ]
    
    init(boxesNumber: Int, delegate: MarkerDelegate) {
        self.boxesNumber = boxesNumber
        self.delegate = delegate
    }
    
    func puzzleDidTap() {
        boxesCollected += 1
        updateText()
        if boxesCollected == boxesNumber {
            delegate.puzzleDidFinish()
        }
    }
    
    func updateText() {
        delegate.updatePuzzleText("\(boxesCollected)/\(boxesNumber) boxes collected")
    }
}
