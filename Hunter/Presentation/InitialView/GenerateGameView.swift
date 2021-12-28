//
//  GenerateGameView.swift
//  Hunter
//
//  Created by oksana on 28.12.21.
//

import Foundation
import SwiftUI

struct GenerateGameView: View {
    
    @State private var showNeighbourhoods = false
    @State private var selectedNeighbourhood = Neighbourhood.friedrichshain
    
    @State private var showNumberOfLocations = false
    @State private var selectedNumberOfLocations = 1
    
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
                    showNumberOfLocations = false
                }
                
                HStack {
                    Text("Number of Locations")
                    Spacer()
                    Text("\(selectedNumberOfLocations)")
                }.onTapGesture {
                    showNumberOfLocations.toggle()
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
                    showNumberOfLocations = false
                }
                
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
                    GameView(viewModel: GameViewModel(selectedNeighbourhood, selectedTypeOfGame, selectedNumberOfLocations))
                })
            
            
            
            Spacer()
            if showNeighbourhoods == true {
                Picker("", selection: $selectedNeighbourhood) {
                    Text("Fhain").tag(Neighbourhood.friedrichshain)
//                    Text("Pberg").tag(Neighbourhood.pBerg)
//                    Text("Mitte").tag(Neighbourhood.mitte)
                }
            }
            if showTypeOfGame == true {
                Picker("", selection: $selectedTypeOfGame) {
                    Text("Click & Collect").tag(GameType.click)
//                    Text("Timed Game").tag(GameType.timed)
//                    Text("Trivia").tag(GameType.trivia)
//                    Text("Cards").tag(GameType.cards)
                }
            }
            if showNumberOfLocations == true {
                Picker("", selection: $selectedNumberOfLocations) {
                    ForEach(1 ..< (selectedNeighbourhood.locations.count + 1), id:\.self) { i in
                        Text("\(i) locations").tag(i)
                    }
                }
            }
        }
    }
}

#if DEBUG
struct GenerateGameView_Previews : PreviewProvider {
    static var previews: some View {
        GenerateGameView()
    }
}
#endif
