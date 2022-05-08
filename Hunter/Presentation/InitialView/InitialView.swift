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
                    Text("Here's how it works:\nSelect your preferences in the next screen, then a game will be generated for you! Now all you need to do is find the direction you need to travel to and get the hell out! \n\nOnce you are closer than 50 meters to the location, the view on your phone will change. There you need to point your camera at a flat surface to see the 3D puzzle. Once you solve your puzzle, on to the next location, until the game is done! \n\n After you complete one type, more puzzle types will be unlocked! \n")
                        .padding()
                    
                    NavigationLink(destination: GameGenerationView()) {
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
