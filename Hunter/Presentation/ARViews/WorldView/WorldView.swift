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
    @StateObject var locationManager = LocationManager()
    

    func makeUIView(context: Context) -> SceneLocationView {
        
        let sceneLocationView = SceneLocationView()
        sceneLocationView.run()
        
        return sceneLocationView
    }

    func updateUIView(_ uiView: SceneLocationView, context: Context) {
        
        if let location = viewModel.nextMarkerLocation {
            uiView.removeAllNodes()
            let squareView = UIView(frame: CGRect(x: 0, y: 0, width: 140, height: 80))
            
            let levelLabel = UILabel(frame: CGRect(x: 25, y: 13, width: 100, height: 30))
            levelLabel.text = "Location \(viewModel.currentLevel+1)"
            levelLabel.textColor = .black
            levelLabel.numberOfLines = 0
            levelLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
            squareView.addSubview(levelLabel)
            
            let distanceLabel = UILabel(frame: CGRect(x: 40, y: 30, width: 100, height: 40))
            distanceLabel.text = "\(locationManager.visualDistance(to: viewModel.nextMarkerLocation).0) \(locationManager.visualDistance(to: viewModel.nextMarkerLocation).1)"
            distanceLabel.textColor = .black
            distanceLabel.numberOfLines = 0
            distanceLabel.font = UIFont.systemFont(ofSize: 14)
            squareView.addSubview(distanceLabel)
            
            squareView.backgroundColor = .white
            squareView.alpha = 0.7
            squareView.layer.cornerRadius = 15.0

            let annotationNode = LocationAnnotationNode(location: location, view: squareView)
    //        annotationNode.scaleRelativeToDistance = true
            uiView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
        }
    }
}
