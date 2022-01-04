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

enum GameType: String {
    case click = "Click & Collect"
    case timed = "Timed Game"
    case matching = "Matching Game"
    case memoryCard = "Memory Card Game"
}

enum GameLength: String {
    case short = "Short"
    case medium = "Medium"
    case long = "Long"
}
