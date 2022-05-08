//
//  GenerateGameView.swift
//  Hunter
//
//  Created by oksana on 28.12.21.
//

import Foundation
import SwiftUI

struct GameGenerationView: View {
    
    let locationManager = LocationManager()
        
    @State private var showNeighbourhoods = false
    @State private var selectedNeighbourhood = Neighbourhood.friedrichshainTest
    
    @State private var showGameLength = false
    @State private var selectedGameLength = GameLength.short
    
    @State private var showTypeOfGame = false
    @State private var selectedTypeOfGame = GameType.click
    
    @State private var isGamePresented = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Lets create a game!")
                .font(.title2)
            List {
                HStack {
                    Text("Neighbourhood")
                    Spacer()
                    Text("\(selectedNeighbourhood.rawValue)")
                }.onTapGesture {
                    showNeighbourhoods.toggle()
                    showTypeOfGame = false
                    showGameLength = false
                }
                
                HStack {
                    Text("Game Length")
                    Spacer()
                    Text("\(selectedGameLength.rawValue)")
                }.onTapGesture {
                    showGameLength.toggle()
                    showNeighbourhoods = false
                    showTypeOfGame = false
                }
                
                HStack {
                    Text("Game Type")
                    Spacer()
                    Text("\(selectedTypeOfGame.rawValue)")
                }.onTapGesture {
                    showTypeOfGame.toggle()
                    showNeighbourhoods = false
                    showGameLength = false
                }
                
            }
            
            switch selectedTypeOfGame {
            case .click:
                Text("In a Click & Collect game you are showed the wayfinder to the next location, once you reach it, you need to collect an object, and you will see your next wayfinder. No time limit, no pressure.")
            case .timed:
                Text("In a Timed game, there is a limited amount of time to collect all the objects. If the time runs out, the game is lost.")
            default:
                Text("")
            }
            
            Spacer()
            
            Button(action: {
                isGamePresented.toggle()
            }) {
                Text("Let's go!")
                    .textCase(.uppercase)
                    .font(Font.headline.weight(.semibold))
            }
                .padding()
                .foregroundColor(Color.white)
                .background(Color(red: 0.18, green: 0.70, blue: 0.46))
                .cornerRadius(25)
                .fullScreenCover(isPresented: $isGamePresented, content: {
                    GameView(viewModel: GameViewModel(selectedNeighbourhood, selectedTypeOfGame, selectedGameLength, locationManager: locationManager))
                })
                .environmentObject(locationManager)
                
            
            if showNeighbourhoods == true {
                Picker("", selection: $selectedNeighbourhood) {
                    Text("\(Neighbourhood.friedrichshain.rawValue)").tag(Neighbourhood.friedrichshain)
                    Text("\(Neighbourhood.friedrichshainFrTor.rawValue)").tag(Neighbourhood.friedrichshainFrTor)
                    Text("\(Neighbourhood.friedrichshainTest.rawValue)").tag(Neighbourhood.friedrichshainTest)
                }
            }
            if showTypeOfGame == true {
                Picker("", selection: $selectedTypeOfGame) {
                    Text("Click & Collect").tag(GameType.click)
                    Text("Timed Game").tag(GameType.timed)
                    Text("\(GameType.memoryCard.rawValue)").tag(GameType.memoryCard)
                }
            }
            if showGameLength == true {
                Picker("", selection: $selectedGameLength) {
                    Text("\(GameLength.short.rawValue)").tag(GameLength.short)
                    Text("\(GameLength.medium.rawValue)").tag(GameLength.medium)
                    Text("\(GameLength.long.rawValue)").tag(GameLength.long)
                }
            }
        }
    }
    
}

#if DEBUG
struct GenerateGameView_Previews : PreviewProvider {
    static var previews: some View {
        GameGenerationView()
    }
}
#endif
