//
//  InitialView.swift
//  Hunter
//
//  Created by oksana on 28.12.21.
//

import Foundation
import SwiftUI

struct InitialView: View {
    
    var body: some View {
        VStack {
            NavigationView {
                VStack{
                    Text("Ready for the next hunt?")
                        .navigationTitle("Welcome!")
                        .font(.title2)
                        .padding()
                    
                    NavigationLink(destination: GenerateGameView()) {
                        Text("Start a game")
                            .textCase(.uppercase)
                            .font(Font.headline.weight(.semibold))
                    }
                        .padding()
                        .foregroundColor(Color.white)
                        .background(Color(red: 0.18, green: 0.70, blue: 0.46))
                        .cornerRadius(25)
                    
                }
            }
        }
    }
}

#if DEBUG
struct InitialView_Previews : PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
#endif
