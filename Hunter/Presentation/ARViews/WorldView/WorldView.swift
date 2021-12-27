//
//  WorldView.swift
//  Hunter
//
//  Created by oksana on 27.12.21.
//

import Foundation
import SwiftUI
import ARKit
import CoreLocation
import ARCL

struct WorldView: UIViewRepresentable {
    
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
