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
        drawBoxes(arView: arView)
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
        print("updating view, found \(uiView.scene.anchors.count) anchors")
        
        if uiView.scene.anchors.count == 0 {
            drawBoxes(arView: uiView)
        }
    }
    
    private func drawBoxes(arView: ARView) {
        // Add boxes
        let anchor = AnchorEntity(plane: .horizontal, minimumBounds: [3, 3])
        arView.scene.addAnchor(anchor)
        
        var cards: [Entity] = []
        for _ in 1...viewModel.boxesNumber {
            let box = MeshResource.generateBox(width: 0.3, height: 0.3, depth: 0.3)
            let metalMaterial = SimpleMaterial(color: .red, isMetallic: true)
            let model = ModelEntity(mesh: box, materials: [metalMaterial])
            
            model.generateCollisionShapes(recursive: true)
            
            cards.append(model)
        }
        
        let shuffledLocs = viewModel.locations.shuffled()
        
        for (index,card) in cards.enumerated() {
            card.position = shuffledLocs[index]
            anchor.addChild(card)
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
