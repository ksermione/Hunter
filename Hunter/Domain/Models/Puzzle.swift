//
//  Puzzle.swift
//  Hunter
//
//  Created by oksana on 28.12.21.
//

import Foundation
import CoreLocation
import UIKit

protocol PuzzleDelegate {
    func puzzleDidFinish()
    func updatePuzzleText(_ text: String)
}

protocol Puzzle {
    var location: CLLocation { get }
}

struct ClickPuzzle: Puzzle {
    let location: CLLocation
}

struct MemoryCardPuzzle: Puzzle {
    let location: CLLocation
    let cardPairs: [RealityObject]
}
