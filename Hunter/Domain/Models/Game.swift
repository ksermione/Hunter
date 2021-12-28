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
    let locations: [CLLocation]
}

enum GameType: String {
    case click = "Click & Collect"
    case timed = "Timed Game"
    case trivia = "Trivia"
    case cards = "Cards"
}
