//
//  MemoryCardViewModel.swift
//  Hunter
//
//  Created by oksana on 02.01.22.
//

import Foundation
import SwiftUI
import RealityKit

class MemoryCardViewModel: ObservableObject {
    
    private var activeCardName: String?
    let marker: MemoryCardMarker
    private var pairsMatched = 0
    private let delegate: MarkerDelegate
    
    let positions: [SIMD3<Float>] = [
        [0, 0, 0],
        [-0.3, 0, 0],
        [0, 0, 0.3],
        [-0.3, 0, 0.3],
        
        [0.3, 0, 0],
        [0.3, 0, 0.3],
        
        [0.3, 0, 0.6],
        [0, 0, 0.6],
        
        [-0.6, 0, 0],
        [-0.6, 0, 0.3],
        
        [-0.6, 0, 0.6],
        [-0.3, 0, 0.6],
    ]
    
    init(marker: MemoryCardMarker, delegate: MarkerDelegate) {
        self.marker = marker
        self.delegate = delegate
    }
    
    func getActiveCardName() -> String? {
        return activeCardName
    }
    
    func pairMatched() {
        pairsMatched += 1
        updateText()
        if pairsMatched == marker.cardPairs.count {
            delegate.puzzleDidFinish()
        }
    }
    
    func updateText() {
        delegate.updatePuzzleText("\(pairsMatched)/\(marker.cardPairs.count) pairs matched")
    }
}
