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
        guard game.markers.count > currentLevel else { return ClickPuzzle() }
        return game.markers[currentLevel].puzzle
    }
    
    func generateGame() {
        let clickPuzzle1 = ClickPuzzle()
        clickPuzzle1.delegate = self
        
        game = Game(markers: [
            Marker(location: CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.51142381102419, longitude: 13.446427692145672),
                                        altitude: CLLocationDistance(50)),
                   puzzle: clickPuzzle1),
            Marker(location: CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.519358, longitude: 13.464313),
                                        altitude: CLLocationDistance(50)),
                   puzzle: ClickPuzzle())
        ])
    }
    
    func startNewGame() {
        currentLevel = 0
        generateGame()
    }
    
    func proceedToNextLevel() {
        currentLevel += 1
        shouldShowFinishAlert = currentLevel == game.markers.count
    }
}

extension GameViewModel: ClickPuzzleDelegate {
    func puzzleDidTap() {
        proceedToNextLevel()
    }
}
