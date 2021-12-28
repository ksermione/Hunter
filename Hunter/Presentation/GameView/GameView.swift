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
    
    var body: some View {
        
        VStack {
            Button("Finish Game") {
                presentationMode.wrappedValue.dismiss()
            }
            
            viewModel.arViewToShow().edgesIgnoringSafeArea(.all)
            
            Button(action: {
                viewModel.showPuzzleButtonPressed.toggle()
                if !viewModel.showPuzzleButtonPressed {
                    viewModel.proceedToNextLevel()
                }
            }) {
                Text( viewModel.shouldShowPuzzleView ? "Box Collected" : "I'm at the location!")
            }
            Text("You're on level \(viewModel.currentLevel + 1) out of \(viewModel.levelsAmount).")
                .multilineTextAlignment(.center)
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
        GameView(viewModel: GameViewModel(.friedrichshain, .click, 1))
    }
}
#endif
