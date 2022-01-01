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
//    @Published var showPuzzleButtonPressed = false
    
    // Timed Game
    var timer: Timer?
    @Published var secondsRemaining: Int = 0
    @Published var shouldShowTimeFailedAlert = false
    
    let locationManager: LocationManager //= LocationManager()
    private let neighbourhood: Neighbourhood
    let gameType: GameType
    @Published var numberOfLocations: Int
    
    init(_ neighbourhood: Neighbourhood, _ gameType: GameType, _ numberOfLocations: Int, locationManager: LocationManager) {
        self.neighbourhood = neighbourhood
        self.gameType = gameType
        
        let maxLocCount = Game.locations(for: gameType, neighbourhood: neighbourhood).count
        self.numberOfLocations = numberOfLocations <= maxLocCount ? numberOfLocations : maxLocCount
        
        self.locationManager = locationManager
    }
    
    var nextMarkerLocation: CLLocation? {
        return (game.locations.count > 0 && currentLevel < game.locations.count ) ? game.locations[currentLevel] : nil
    }
    
    func generateGame() {
        let neiLocs = Game.locations(for: gameType, neighbourhood: neighbourhood)
        var locations: [CLLocation] = []
        
        for index in 0..<numberOfLocations {
            locations.append(neiLocs[index])
        }
        
        game = Game(type: gameType, locations: locations.shuffled())

        switch gameType {
        case .timed:
            setupTimer()
        default:
            break
        }
        
    }
    
    private func setupTimer() {
        var seconds = 300
        if let loc = locationManager.updatedLocation {
            let nextCoor = game.locations[0]
            let distanceInMeters = loc.distance(from: nextCoor)
            seconds = Int(distanceInMeters)
        }
        
        
        for index in 0..<(numberOfLocations-2) {
            let currentCoor = game.locations[index]
            let nextCoor = game.locations[index+1]

            let distanceInMeters = currentCoor.distance(from: nextCoor)
            seconds += Int(distanceInMeters)
        }
        secondsRemaining = seconds
    }
    
    func proceedToNextLevel() {
        if currentLevel < numberOfLocations {
            currentLevel += 1
        }
//        showPuzzleButtonPressed = false
        shouldShowFinishAlert = currentLevel == numberOfLocations
    }
}

extension GameViewModel: PuzzleDelegate {
    func puzzleDidFinish() {
        proceedToNextLevel()
    }
}
