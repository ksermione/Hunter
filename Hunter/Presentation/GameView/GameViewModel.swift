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
    @Published private var game: Game = Game(type: .click, markers: [])
    @Published var currentLevel = 0
    @Published var shouldShowFinishAlert = false
    @Published var showPuzzleButtonPressed = false
    @Published var puzzleText: String = ""
    
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
    
    var defaultPuzzleText: String {
        return "Location \(currentLevel + 1) out of \(numberOfLocations)."
    }
    
    var nextMarker: Marker? {
        return (game.markers.count > 0 && currentLevel < game.markers.count ) ? game.markers[currentLevel] : nil
    }
    
    var shouldShowPuzzleView: Bool {
        return (locationManager.distance(to: nextMarker?.location) < 50.0) || showPuzzleButtonPressed
    }
    
    func generateGame() {
        let neiLocs = Game.locations(for: gameType, neighbourhood: neighbourhood)
        var markers: [Marker] = []
        
        for index in 0..<numberOfLocations {
            switch gameType {
            case .click, .timed:
                markers.append(ClickMarker(location: neiLocs[index],
                                           boxesNumber: index+1))
            default:
                break
            }
        }
        
        game = Game(type: gameType, markers: markers.shuffled())
        
        switch gameType {
//        case .click:
        case .timed:
            setupTimer()
        default:
            break
        }
        
        puzzleText = defaultPuzzleText
    }
    
    @ViewBuilder
    func makePuzzleView() -> some View {
        switch gameType {
        case .click, .timed:
            if let nextMarker = nextMarker as? ClickMarker {
                ClickPuzzleView(viewModel: ClickPuzzleViewModel(boxesNumber: nextMarker.boxesNumber, delegate: self))
            }
        default:
            EmptyView()
        }
        EmptyView()
    }
    
    private func setupTimer() {
        var seconds = 300
        if let loc = locationManager.updatedLocation {
            let nextCoor = game.markers[0].location
            let distanceInMeters = loc.distance(from: nextCoor)
            seconds = Int(distanceInMeters)
        }
        
        if numberOfLocations > 1 {
            for index in 0..<(numberOfLocations-2) {
                let currentCoor = game.markers[index].location
                let nextCoor = game.markers[index+1].location

                let distanceInMeters = currentCoor.distance(from: nextCoor)
                seconds += Int(distanceInMeters)
            }
        }
        secondsRemaining = seconds
    }
    
    func proceedToNextLevel() {
        if (currentLevel+1) < numberOfLocations {
            currentLevel += 1
        }
        showPuzzleButtonPressed = false
        shouldShowFinishAlert = (currentLevel + 1) == numberOfLocations
        puzzleText = defaultPuzzleText
    }
}

extension GameViewModel: MarkerDelegate {
    func puzzleDidFinish() {
        proceedToNextLevel()
    }
    
    func updatePuzzleText(_ text: String) {
        puzzleText = text
    }
}
