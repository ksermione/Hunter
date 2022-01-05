//
//  Marker.swift
//  Hunter
//
//  Created by oksana on 28.12.21.
//

import Foundation
import CoreLocation
import UIKit

protocol MarkerDelegate {
    func puzzleDidFinish()
    func updatePuzzleText(_ text: String)
}

protocol Marker {
    var location: CLLocation { get }
}

struct ClickMarker: Marker {
    let location: CLLocation
}

struct MemoryCardMarker: Marker {
    let location: CLLocation
    let cardPairs: [RealityObject]
}

struct MatchingMarker: Marker {
    let location: CLLocation
    let object: String
    let color: UIColor
}
