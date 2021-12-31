//
//  GameViewModel.swift
//  Hunter
//
//  Created by oksana on 26.10.21.
//

import Foundation
import CoreLocation
import SwiftUI

class GameViewModel: ObservableObject {
    @Published private var game: Game = Game(type: .click, locations: [])
    @Published var currentLevel = 0
    @Published var shouldShowFinishAlert = false
    @Published var showPuzzleButtonPressed = false
    
    // Timed Game
    var timer: Timer?
    @Published var secondsRemaining: Int = 0
    @Published var shouldShowTimeFailedAlert = false
    
//    var locationManager: LocationManager = LocationManager()
    private let neighbourhood: Neighbourhood
    let gameType: GameType
    private let numberOfLocations: Int
    
    init(_ neighbourhood: Neighbourhood, _ gameType: GameType, _ numberOfLocations: Int) {
        self.neighbourhood = neighbourhood
        self.gameType = gameType
        self.numberOfLocations = numberOfLocations
    }
    
    var nextMarkerLocation: CLLocation? {
        return (game.locations.count > 0 && currentLevel < game.locations.count ) ? game.locations[currentLevel] : nil
    }
    
    var levelsAmount: Int {
        game.locations.count
    }
    
    func generateGame() {
        let neiLocs = Game.locations(for: gameType, neighbourhood: neighbourhood)
        var locations: [CLLocation] = []
        for _ in 1...numberOfLocations {
            let randomIndex = Int.random(in: 0..<(neiLocs.count - 1))
            let randomLocation = neiLocs[randomIndex]
            var alreadyUsed: Bool = false
            locations.forEach { loc in
                if loc == randomLocation {
                    alreadyUsed = true
                }
            }
            if !alreadyUsed {
                locations.append(randomLocation)
            }
        }
        
        game = Game(type: gameType, locations: locations)

        switch gameType {
        case .timed:
            setupTimer()
        default:
            break
        }
        
    }
    
    private func setupTimer() {
//        secondsRemaining = 10
//        secondsRemaining = game.locations.count * 400
//        let loc = locationManager.updatedLocation
        var seconds = 200
        
        for index in 0..<(numberOfLocations-1) {
            let currentCoor = game.locations[index]
            let nextCoor = game.locations[index+1]

            let distanceInMeters = currentCoor.distance(from: nextCoor)
            seconds += Int(distanceInMeters)
        }
        secondsRemaining = seconds
    }
    
    func proceedToNextLevel() {
        currentLevel += 1
        showPuzzleButtonPressed = false
        shouldShowFinishAlert = currentLevel == game.locations.count
    }
}

extension GameViewModel: PuzzleDelegate {
    func puzzleDidFinish() {
        proceedToNextLevel()
    }
}
