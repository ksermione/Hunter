//
//  ClickPuzzleView.swift
//  Hunter
//
//  Created by oksana on 24.12.21.
//

import Foundation
import ARKit
import SwiftUI
import RealityKit
import Combine

public struct ClickPuzzleView: UIViewRepresentable {
    
    @ObservedObject var viewModel: ClickPuzzleViewModel
        
    public func makeUIView(context: Context) -> ARView {
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
        drawPuzzle(arView: arView)
        viewModel.updateText()
        return arView
    }
    
    // MARK: - Coordinator
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(delegate: self)
    }
    
    public class Coordinator: NSObject, ARSessionDelegate {
        weak var arView: ARView?
        let delegate: ClickPuzzleCoordinatorDelegate
        
        init(delegate: ClickPuzzleCoordinatorDelegate) {
            self.delegate = delegate
        }
        
        @objc func handleTap(_ sender: UITapGestureRecognizer) {
            let tapLocation = sender.location(in: arView)
            if let card = arView?.entity(at: tapLocation) {
                card.removeFromParent()
                delegate.boxCollected()
            }
        }
    }
    
    public func updateUIView(_ uiView: ARView, context: Context) {
        if uiView.scene.anchors.count == 0 {
            drawPuzzle(arView: uiView)
        }
    }
    
    private func drawPuzzle(arView: ARView) {
        let anchor = AnchorEntity(plane: .horizontal, minimumBounds: [1, 1])
        arView.scene.addAnchor(anchor)
        
        // load models
        if let entity = try? Entity.load(named: RealityObject.plane.name) {
            entity.setScale(RealityObject.plane.scaleForClickGame, relativeTo: anchor)
            entity.generateCollisionShapes(recursive: true)
            entity.position = [0, 0, 0]
            anchor.addChild(entity)
            
        }
    }
}

extension ClickPuzzleView: ClickPuzzleCoordinatorDelegate {
    func boxCollected() {
        viewModel.puzzleDidTap()
    }
}

protocol ClickPuzzleCoordinatorDelegate {
    func boxCollected()
}
