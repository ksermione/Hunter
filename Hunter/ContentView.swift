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
    
    @State private var showRealityView = false
    @State private var boxesCollected = 0
    
    var body: some View {
        VStack {
            if showRealityView {
                ARViewContainer()
            }
            if !showRealityView {
                SceneViewContainer()
            }
                //.edgesIgnoringSafeArea(.all)
            Button(action: {
                showRealityView.toggle()
            }) {
                Text("Switch")
            }
//            Text("You've collected \(boxesCollected) boxes! ")
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

    func makeUIView(context: Context) -> SceneLocationView {

        let sceneLocationView = SceneLocationView()
        sceneLocationView.run()
        
        let locationManager = CLLocationManager()
        let current: CLLocation? = locationManager.location
        
        let coordinate = CLLocationCoordinate2D(latitude: 52.51364861314343, longitude: 13.450571390720818)
        let location = CLLocation(coordinate: coordinate, altitude: CLLocationDistance(current?.altitude ?? 0))
        

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
        ContentView()
    }
}
#endif
