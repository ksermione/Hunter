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
    
    let marker: MemoryCardMarker
    private var pairsMatched = 0
    private let delegate: MarkerDelegate
    
    init(marker: MemoryCardMarker, delegate: MarkerDelegate) {
        self.marker = marker
        self.delegate = delegate
    }
    
    func pairMatched() {

        updateText()

    }
    
    func updateText() {
//        delegate.updatePuzzleText("\(boxesCollected)/\(boxesNumber) boxes collected")
    }
}
