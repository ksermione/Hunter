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
    
    private let delegate: MarkerDelegate
    
    init(delegate: MarkerDelegate) {
        self.delegate = delegate
    }
    
    func puzzleDidTap() {
        delegate.puzzleDidFinish()
    }
    
    func updateText() {
//        delegate.updatePuzzleText("\(objectsCollected)/\(marker.numberToCollect) objects collected")
    }
}
