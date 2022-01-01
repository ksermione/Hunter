//
//  Marker.swift
//  Hunter
//
//  Created by oksana on 28.12.21.
//

import Foundation
import CoreLocation

protocol MarkerDelegate {
    func puzzleDidFinish()
    func updatePuzzleText(_ text: String)
}

protocol Marker {
    var location: CLLocation { get }
}

struct ClickMarker: Marker {
    let location: CLLocation
    let boxesNumber: Int
}

struct CardMarker: Marker {
    let location: CLLocation
    
}
