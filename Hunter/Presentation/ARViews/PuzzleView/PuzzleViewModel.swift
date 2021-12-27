//
//  PuzzleViewModel.swift
//  Hunter
//
//  Created by oksana on 27.12.21.
//

import Foundation
import SwiftUI
import RealityKit

class PuzzleViewModel: ObservableObject {
    
    private let puzzle: Puzzle
    
    init(puzzle: Puzzle) {
        self.puzzle = puzzle
    }
    
    var arView: ARView {
        puzzle.create()
    }
}
