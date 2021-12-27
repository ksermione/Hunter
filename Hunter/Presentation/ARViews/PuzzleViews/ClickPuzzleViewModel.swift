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
    
    private let puzzle: Puzzle
    private let delegate: PuzzleDelegate
    
    init(puzzle: Puzzle, delegate: PuzzleDelegate) {
        self.puzzle = puzzle
        self.delegate = delegate
    }
    
    func puzzleDidTap() {
        delegate.puzzleDidFinish()
    }
}
