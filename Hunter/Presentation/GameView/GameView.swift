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
    
    @EnvironmentObject var locationManager: LocationManager
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        ZStack {
            
            if (locationManager.distance(to: viewModel.nextMarkerLocation) < 15.0) || viewModel.showPuzzleButtonPressed {
                ClickPuzzleView(viewModel: ClickPuzzleViewModel(puzzle: ClickPuzzle(), delegate: viewModel)).edgesIgnoringSafeArea(.all)
            } else {
                WorldView(viewModel: viewModel).edgesIgnoringSafeArea(.all)
            }

            VStack {
                Spacer()
                
                            Button(action: {
                                viewModel.showPuzzleButtonPressed.toggle()
                                if !viewModel.showPuzzleButtonPressed {
                                    viewModel.proceedToNextLevel()
                                }
                            }) {
                                Text( viewModel.showPuzzleButtonPressed ? "Box Collected" : "I'm at the location!")
                            }
                
                Text("Location \(viewModel.currentLevel + 1) out of \(viewModel.numberOfLocations).")
                    .multilineTextAlignment(.center)
                if viewModel.gameType == .timed {
                    Text("\(viewModel.secondsRemaining / 60) min \(viewModel.secondsRemaining % 60) sec remaining")
                                .onReceive(timer) { _ in
                                    if viewModel.secondsRemaining > 0 {
                                        viewModel.secondsRemaining -= 1
                                    } else {
                                        viewModel.shouldShowTimeFailedAlert = true
                                    }
                                }
                }
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel Game")
                        
                }
            }
            .alert(isPresented: $viewModel.shouldShowTimeFailedAlert) {
                Alert(
                    title: Text("Oh no...."),
                    message: Text("Unfortunately you weren't fast enough :/"),
                    dismissButton: .default(
                                    Text("Quit"),
                                    action: {
                                        presentationMode.wrappedValue.dismiss()
                                    })
                    )
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
                                Text("Quit"),
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
        GameView(viewModel: GameViewModel(.friedrichshainTest, .click, 1, locationManager: LocationManager()))
    }
}
#endif



