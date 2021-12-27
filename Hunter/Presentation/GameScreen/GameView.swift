//
//  ContentView.swift
//  Hunter
//
//  Created by oksana on 21.10.21.
//

import SwiftUI
import RealityKit
import ARKit
import CoreLocation
import ARCL

struct GameView: View {
    
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        VStack {
            
            if viewModel.shouldShowPuzzleView {
                PuzzleView(viewModel: PuzzleViewModel(puzzle: viewModel.nextPuzzle)).edgesIgnoringSafeArea(.all)
            } else {
                WorldView(viewModel: viewModel).edgesIgnoringSafeArea(.all)
            }
            
            Button(action: {
                viewModel.showPuzzleButtonPressed.toggle()
                if !viewModel.showPuzzleButtonPressed {
                    viewModel.proceedToNextLevel()
                }
            }) {
                Text( viewModel.shouldShowPuzzleView ? "Puzzle solved" : "I'm at the location!")
            }
            Text("You're on level \(viewModel.currentLevel + 1) out of \(viewModel.levelsAmount).")
                .multilineTextAlignment(.center)
            Text("Distance is \(viewModel.distanceToNextMarker) meters")
        }
        .onAppear {
            self.viewModel.generateGame()
        }
        .alert(isPresented: $viewModel.shouldShowFinishAlert) {
            Alert(
                title: Text("Nice job!"),
                message: Text("You've finished your game. New games have been unlocked for you."),
                dismissButton: .default(
                                Text("Start New Game"),
                                action: {
                                    viewModel.startNewGame()
                                })
            )
        }
    }
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel())
    }
}
#endif
