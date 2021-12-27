//
//  Game.swift
//  Hunter
//
//  Created by oksana on 26.10.21.
//

import Foundation
import CoreLocation

struct Game {
//    let level: Int
    let markers: [Marker]
}

struct Marker {
    let location: CLLocation
    let puzzle: Puzzle
}
