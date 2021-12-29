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
    
    var locationManager: LocationManager?
    private let neighbourhood: Neighbourhood
    private let gameType: GameType
    private let numberOfLocations: Int
    
    init(_ neighbourhood: Neighbourhood, _ gameType: GameType, _ numberOfLocations: Int) {
        self.neighbourhood = neighbourhood
        self.gameType = gameType
        self.numberOfLocations = numberOfLocations
    }
    
    var distanceToNextMarker: Double { // in meters
        if let nextMarkerLocation = nextMarkerLocation {
            return Double(locationManager?.updatedLocation?.distance(from: nextMarkerLocation) ?? 1000.0)
        } else {
            return 1000.0
        }
    }
    
    var nextMarkerLocation: CLLocation? {
        return (game.locations.count > 0 && currentLevel < game.locations.count ) ? game.locations[currentLevel] : nil
    }
    
    var levelsAmount: Int {
        game.locations.count
    }
    
    func generateGame() {
        
        var locations: [CLLocation] = []
        for _ in 1...numberOfLocations {
            let randomIndex = Int.random(in: 0..<(neighbourhood.locations.count - 1))
            let randomLocation = neighbourhood.locations[randomIndex]
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
        
        
//        game = Game(type: .click, locations: [
//            CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.513615, longitude: 13.453161), altitude: CLLocationDistance(100))
//        ])
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
