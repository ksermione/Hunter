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
    
    private let delegate: PuzzleDelegate
    
    init(delegate: PuzzleDelegate) {
        self.delegate = delegate
    }
    
    func puzzleDidTap() {
        delegate.puzzleDidFinish()
    }
    
    func updateText() {
    }
}
