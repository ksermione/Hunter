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
            if (viewModel.shouldShowPuzzleView) {
                viewModel.makePuzzleView().edgesIgnoringSafeArea(.all)
            } else {
                WorldView(viewModel: viewModel).edgesIgnoringSafeArea(.all)
            }

            VStack(spacing: 10) {
                
                HStack {
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
                    Spacer()
                    Button("X") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding(.vertical , 8)
                    .padding(.horizontal , 15)
                    .foregroundColor(Color.gray)
                    .background(Color.white)
                    .cornerRadius(18)
                }
                .padding()
                
                Spacer()
                
                Button(action: {
                    viewModel.showPuzzleButtonPressed.toggle()
                    if !viewModel.showPuzzleButtonPressed {
                        viewModel.proceedToNextLevel()
                    }
                }) {
                    Text( viewModel.showPuzzleButtonPressed ? "Puzzle finished" : "I'm at the location!")
                }

                Text("\(viewModel.puzzleText)")
                    .multilineTextAlignment(.center)
                    .padding()
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
        GameView(viewModel: GameViewModel(.friedrichshainTest, .click, .short, locationManager: LocationManager()))
    }
}
#endif



