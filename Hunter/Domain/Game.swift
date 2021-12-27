//
//  Game.swift
//  Hunter
//
//  Created by oksana on 26.10.21.
//

import Foundation
import CoreLocation

struct Game {
    let type: GameType
    let markers: [Marker]
}

enum GameType {
    case click
    case cards
    case guess
    case trivia
}

struct Marker {
    let location: CLLocation
    let puzzle: Puzzle
}
