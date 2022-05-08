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
    let puzzle: MemoryCardPuzzle
    private var pairsMatched = 0
    private let delegate: PuzzleDelegate
    
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
    
    init(puzzle: MemoryCardPuzzle, delegate: PuzzleDelegate) {
        self.puzzle = puzzle
        self.delegate = delegate
    }
    
    func getActiveCardName() -> String? {
        return activeCardName
    }
    
    func pairMatched() {
        pairsMatched += 1
        updateText()
        if pairsMatched == puzzle.cardPairs.count {
            delegate.puzzleDidFinish()
        }
    }
    
    func updateText() {
        delegate.updatePuzzleText("\(pairsMatched)/\(puzzle.cardPairs.count) pairs matched")
    }
}
