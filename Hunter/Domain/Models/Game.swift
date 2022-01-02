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

extension Game {
    static func locations(for gameType: GameType, neighbourhood: Neighbourhood) -> [CLLocation] {
        switch gameType {
        case .click:
            return neighbourhood.locationsFar
        case .timed, .matching:
            return neighbourhood.locationsNear
        }
    }
}

enum GameType: String {
    case click = "Click & Collect"
    case timed = "Timed Game"
    case matching = "Matching Game"
}

enum GameLength: String {
    case short = "Short"
    case medium = "Medium"
    case long = "Long"
}
