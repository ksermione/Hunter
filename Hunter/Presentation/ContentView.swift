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

struct ContentView: View {
    
    @ObservedObject var viewModel: GameViewModel
    
    @State private var showRealityView = false
    
    var body: some View {
        VStack {
            if showRealityView || viewModel.distanceToNextMarker < 5.0 { 
                ARViewContainer().edgesIgnoringSafeArea(.all)
            } else {
                SceneViewContainer(viewModel: viewModel).edgesIgnoringSafeArea(.all)
            }
            Button(action: {
                showRealityView.toggle()
                if !showRealityView {
                    viewModel.proceedToNextLevel()
                }
                
            }) {
                Text( showRealityView ? "Puzzle solved" : "I'm at the location!")
            }
            Text("You're on level \(viewModel.currentLevel)")
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

struct ARViewContainer: UIViewRepresentable {
        
    func makeUIView(context: Context) -> ARView {

        let arView = ARView(frame: .zero)

        // Load the "Box" scene from the "Experience" Reality File
        let box = try! Experience.loadBox() // type: Entity
        arView.scene.anchors.append(box)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        print()
    }
}

struct SceneViewContainer: UIViewRepresentable {
    
    @ObservedObject var viewModel: GameViewModel

    func makeUIView(context: Context) -> SceneLocationView {

        let sceneLocationView = SceneLocationView()
        sceneLocationView.run()
        
        let location = viewModel.nextMarkerLocation

        let squareView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        squareView.backgroundColor = .red

        let annotationNode = LocationAnnotationNode(location: location, view: squareView)
        annotationNode.scaleRelativeToDistance = true
        
        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
        
        return sceneLocationView
    }

    func updateUIView(_ uiView: SceneLocationView, context: Context) {
        print()
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: GameViewModel())
    }
}
#endif
