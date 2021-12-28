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
    
    private let locationViewModel = LocationViewModel()
    
    var distanceToNextMarker: Double { // in meters
        if let nextMarkerLocation = nextMarkerLocation {
            return Double(locationViewModel.updatedLocation?.distance(from: nextMarkerLocation) ?? 1000.0)
        } else {
            return 1000.0
        }
    }
    
    var visualDistanceToNextMarker: Double {
        var dist = distanceToNextMarker
        if dist >= 1000.0 {
            dist = dist / 1000
        }
        
        return dist.rounded(toPlaces: 1)
    }
    
    var visualDistanceUnit: String {
        distanceToNextMarker >= 1000.0 ? "km" : "m"
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
    
    @ViewBuilder
    func arViewToShow() -> some View {
        if shouldShowPuzzleView {
            ClickPuzzleView(viewModel: ClickPuzzleViewModel(puzzle: nextPuzzle, delegate: self))
        } else {
            WorldView(viewModel: self)
        }
    }
    
    func generateGame() {
        
        game = Game(type: .click,
                    markers: [
            Marker(location: CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.51142381102419, longitude: 13.446427692145672),
                                        altitude: CLLocationDistance(50)),
                   puzzle: ClickPuzzle()),
            Marker(location: CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.519358, longitude: 13.464313),
                                        altitude: CLLocationDistance(50)),
                   puzzle: ClickPuzzle())
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
