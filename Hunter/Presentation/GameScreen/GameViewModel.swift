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
    @Published private var game: Game = Game(markers: [])
    @Published var currentLevel = 0
    @Published var shouldShowFinishAlert = false
    @Published var showPuzzleButtonPressed = false
    
    private let locationViewModel = LocationViewModel()
    
    var distanceToNextMarker: Double {
        if let nextMarkerLocation = nextMarkerLocation {
            return Double(locationViewModel.updatedLocation?.distance(from: nextMarkerLocation) ?? 0.0)
        } else {
            return 0.0
        }
    }
    
    var nextMarkerLocation: CLLocation? {
        return (game.markers.count > 0 && currentLevel < game.markers.count ) ? game.markers[currentLevel].location : nil
    }
    
    var levelsAmount: Int {
        game.markers.count
    }
    
    var shouldShowPuzzleView: Bool {
        showPuzzleButtonPressed || distanceToNextMarker < 5.0
    }
    
    var nextPuzzle: Puzzle {
        guard game.markers.count > currentLevel else { return .click }
        return game.markers[currentLevel].puzzle
    }
    
    @ViewBuilder
    func arViewToShow() -> some View {
        if shouldShowPuzzleView {
            ClickPuzzleView(viewModel: ClickPuzzleViewModel(puzzle: nextPuzzle, delegate: self))
        } else {
            WorldView(viewModel: self)
        }
    }
    
    func generateGame() {
        
        game = Game(markers: [
            Marker(location: CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.51142381102419, longitude: 13.446427692145672),
                                        altitude: CLLocationDistance(50)),
                   puzzle: .click),
            Marker(location: CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.519358, longitude: 13.464313),
                                        altitude: CLLocationDistance(50)),
                   puzzle: .click)
        ])
    }
    
    func startNewGame() {
        currentLevel = 0
        showPuzzleButtonPressed = false
        generateGame()
    }
    
    func proceedToNextLevel() {
        currentLevel += 1
        showPuzzleButtonPressed = false
        shouldShowFinishAlert = currentLevel == game.markers.count
    }
}

extension GameViewModel: PuzzleDelegate {
    func puzzleDidFinish() {
        proceedToNextLevel()
    }
}
