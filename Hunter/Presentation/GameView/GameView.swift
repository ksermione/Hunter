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
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel: GameViewModel
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        
        ZStack {
            
            if viewModel.showPuzzleButtonPressed || (locationManager.distance(to: viewModel.nextMarkerLocation) < 5.0) {
                ClickPuzzleView(viewModel: ClickPuzzleViewModel(puzzle: ClickPuzzle(), delegate: viewModel)).edgesIgnoringSafeArea(.all)
            } else {
                WorldView(viewModel: viewModel).edgesIgnoringSafeArea(.all)
            }

            VStack {
                Spacer()
                Text("Location \(viewModel.currentLevel + 1) out of \(viewModel.levelsAmount).")
                    .multilineTextAlignment(.center)
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel Game")
                        
                }
            }
        }
        .onAppear {
            self.viewModel.generateGame()
        }
        .alert(isPresented: $viewModel.shouldShowFinishAlert) {
            Alert(
                title: Text("Nice job!"),
                message: Text("You've finished your game."),
                dismissButton: .default(
                                Text("OK"),
                                action: {
                                    presentationMode.wrappedValue.dismiss()
                                })
            )
        }
    }
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(.friedrichshainTest, .click, 1))
    }
}
#endif


//            Button(action: {
//                viewModel.showPuzzleButtonPressed.toggle()
//                if !viewModel.showPuzzleButtonPressed {
//                    viewModel.proceedToNextLevel()
//                }
//            }) {
//                Text( viewModel.shouldShowPuzzleView ? "Box Collected" : "I'm at the location!")
//            }
