//
//  PuzzleView.swift
//  Hunter
//
//  Created by oksana on 24.12.21.
//

import Foundation
import ARKit
import SwiftUI
import RealityKit

public struct PuzzleView: UIViewRepresentable {
    
    @ObservedObject var viewModel: PuzzleViewModel
        
    public func makeUIView(context: Context) -> ARView {

//        let arView = ARView(frame: .zero)
//
//        // Load the "Box" scene from the "Experience" Reality File
//        let box = try! Experience.loadBox() // type: Entity
//        arView.scene.anchors.append(box)
//        return arView
        return viewModel.arView
    }
    
    public func updateUIView(_ uiView: ARView, context: Context) {
        print()
    }
}
