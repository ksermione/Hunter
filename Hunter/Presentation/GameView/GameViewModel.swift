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
    @Published var game: Game = Game(type: .click, markers: [])
    
    @Published var shouldShowFinishAlert = false
    @Published var showPuzzleButtonPressed = false
    @Published var puzzleText: String = ""
    
    // Click Game
    @Published var currentLevel = 1
    
    // Timed Game
    var timer: Timer?
    @Published var secondsRemaining: Int = 0
    @Published var shouldShowTimeFailedAlert = false
    
    let locationManager: LocationManager
    private let neighbourhood: Neighbourhood
    let gameType: GameType
    let gameLength: GameLength
    @Published var numberOfLocations: Int = 0
    
    init(_ neighbourhood: Neighbourhood, _ gameType: GameType, _ gameLength: GameLength, locationManager: LocationManager) {
        self.neighbourhood = neighbourhood
        self.gameType = gameType
        self.gameLength = gameLength
        self.locationManager = locationManager
    }
    
    var defaultPuzzleText: String {
        return "Find location \(currentLevel) out of \(numberOfLocations).\n50m is close enough to see the puzzle;)"
    }
    
    var nextMarker: Marker? {
        return (game.markers.count > 0 && currentLevel <= game.markers.count ) ? game.markers[currentLevel-1] : nil
    }
    
    var shouldShowPuzzleView: Bool {
        return (locationManager.distance(to: nextMarker?.location) < 50.0) || showPuzzleButtonPressed
    }
    
    func generateGame() {
        var markers: [Marker] = []
        let locations: [CLLocation] = neighbourhood.locations.shuffled()
        
        switch gameLength {
        case .short:
            numberOfLocations = locations.count >= 3 ?  locations.count / 3 : locations.count
        case .medium:
            numberOfLocations = locations.count >= 2 ?  locations.count * 2 / 3 : locations.count
        case .long:
            numberOfLocations = locations.count
        }
        
        for index in 0..<numberOfLocations {
            switch gameType {
            case .click, .timed:
                markers.append(ClickMarker(location: locations[index]))
            case .matching:
                markers.append(MatchingMarker(location: locations[index], object: "", color: .red))
            case .memoryCard:
                var pairs: [RealityObject] = []
                let numOfPairs = index > 4 ? 6 : index + 2
                for i in 0..<numOfPairs {
                    pairs.append((.init(rawValue: i) ?? .plane))
                }
                markers.append(MemoryCardMarker(location: locations[index], cardPairs: pairs))
            }
        }

        game = Game(type: gameType, markers: markers)
        
        if gameType == .timed {
            setupTimer()
        }
        puzzleText = defaultPuzzleText
    }
    
    @ViewBuilder
    func makePuzzleView() -> some View {
        switch gameType {
        case .click, .timed:
            if let _ = nextMarker as? ClickMarker {
                ClickPuzzleView(viewModel: ClickPuzzleViewModel(delegate: self))
            }
        case .memoryCard:
            if let nextMarker = nextMarker as? MemoryCardMarker {
                MemoryCardView(viewModel: MemoryCardViewModel(marker: nextMarker, delegate: self))
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
        if currentLevel <= numberOfLocations {
            currentLevel += 1
        }
        showPuzzleButtonPressed = false
        shouldShowFinishAlert = currentLevel > numberOfLocations
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
