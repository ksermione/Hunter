//
//  Puzzle.swift
//  Hunter
//
//  Created by oksana on 27.12.21.
//

import Foundation
import ARKit
import SwiftUI
import RealityKit
//import FocusEntity

protocol Puzzle {
    func create() -> ARView
}

protocol ClickPuzzleDelegate {
    func puzzleDidTap()
}

struct ClickPuzzle: Puzzle {
    
    var delegate: ClickPuzzleDelegate?
    
    func create(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        let session = arView.session
        
        // Handle ARSession events via delegate
        context.coordinator.arView = arView
        session.delegate = context.coordinator
        
        // Handle taps
        arView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: context.coordinator,
                action: #selector(Coordinator.handleTap)
            )
        )

        // Load the "Box" scene from the "Experience" Reality File
        let box = try! Experience.loadBox() // type: Entity
        arView.scene.anchors.append(box)
        return arView
    }
    
    // MARK: - Coordinator
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, ARSessionDelegate {
        weak var arView: ARView?
//        var focusEntity: FocusEntity?

        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            guard let arView = self.arView else { return }
            debugPrint("Anchors added to the scene: ", anchors)
//            self.focusEntity = FocusEntity(on: arView, style: .classic(color: .yellow))
        }
        
        @objc func handleTap() {
            print("puzzle tapped successfully")
            delegate?.puzzleDidTap()
        }
    }
    
}
