//
//  MemoryCardView.swift
//  Hunter
//
//  Created by oksana on 02.01.22.
//

import Foundation
import ARKit
import SwiftUI
import RealityKit
import Combine

public struct MemoryCardView: UIViewRepresentable {
    
    @ObservedObject var viewModel: MemoryCardViewModel
        
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
        let delegate: MemoryCardPuzzleCoordinatorDelegate
        
        var activeCard: Entity?
        var activeObject: Entity?
        
        init(delegate: MemoryCardPuzzleCoordinatorDelegate) {
            self.delegate = delegate
        }
        
        @objc func handleTap(_ sender: UITapGestureRecognizer) {
            let tapLocation = sender.location(in: arView)
            if let card = arView?.entity(at: tapLocation) {
                if card.transform.rotation.angle == .pi { // initial position - downward/inactive
                    turnUp(card: card)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        if let objc = card.children.first {
                            
                            if let activeCard = self.activeCard,
                               let activeObjectName = self.activeObject?.name { // there is an active card
                                
                                if objc.name == activeObjectName { // match found
                                    self.delegate.pairMatched()
                                    
                                } else { // not a match -> turn both down
                                    self.turnDown(card: card)
                                    self.turnDown(card: activeCard)
                                }
                                self.activeCard = nil
                                self.activeObject = nil
                                
                            } else { // no active cards
                                self.activeCard = card
                                self.activeObject = objc
                            }
                        }
                    }
                }
            }
        }
        
        private func turnDown(card: Entity) {
            var flipUpTransform = card.transform
            flipUpTransform.rotation = simd_quatf(angle: .pi, axis: [1, 0, 0])
            card.move(to: flipUpTransform, relativeTo: card.parent, duration: 0.25, timingFunction: .easeInOut)
        }
        
        private func turnUp(card: Entity) {
            var flipDownTransform = card.transform
            flipDownTransform.rotation = simd_quatf(angle: 0, axis: [1, 0, 0])
            card.move(to: flipDownTransform, relativeTo: card.parent, duration: 0.25, timingFunction: .easeInOut)
        }
    }
    
    public func updateUIView(_ uiView: ARView, context: Context) {
        if uiView.scene.anchors.count == 0 {
            drawBoxes(arView: uiView)
        }
    }
    
    private func drawBoxes(arView: ARView) {
        let anchor = AnchorEntity(plane: .horizontal, minimumBounds: [1, 1])
        arView.scene.addAnchor(anchor)
        
        var cards: [Entity] = []
        for _ in 1...(viewModel.marker.cardPairs.count*2) {
            let box = MeshResource.generateBox(width: 0.25, height: 0.02, depth: 0.25)
            let metalMaterial = SimpleMaterial(color: .brown, isMetallic: true)
            let model = ModelEntity(mesh: box, materials: [metalMaterial])
            
            model.generateCollisionShapes(recursive: true)
            
            cards.append(model)
        }
        
        for (index,card) in cards.enumerated() {
//            let x = Float(index % viewModel.marker.cardPairs.count)
//            let z = Float(index / viewModel.marker.cardPairs.count)
//            card.position = [-x*0.3, 0, z*0.3]
            card.position = viewModel.positions[index]
            anchor.addChild(card)
        }
        
        // create occlusion
        let boxSize: Float = 3
        let occlusionBoxMesh = MeshResource.generateBox(size: boxSize)
        let occlusionBox = ModelEntity(mesh: occlusionBoxMesh, materials: [OcclusionMaterial()])
        occlusionBox.position.y = -boxSize/2
        anchor.addChild(occlusionBox)
        
        
        var entities: [Entity] = []
        viewModel.marker.cardPairs.forEach { object in
            if let entity = try? Entity.load(named: object.name) {
                entity.name = object.name
                entity.setScale(object.scaleForMemoryGame, relativeTo: anchor)
                entity.generateCollisionShapes(recursive: true)
                for _ in 1...2 {
                    entities.append(entity.clone(recursive: true))
                }
            }
        }
        entities.shuffle()
        
        var index = 0
        entities.forEach { entity in
            cards[index].addChild(entity)
            cards[index].transform.rotation = simd_quatf(angle: .pi, axis: [1, 0, 0])
            index += 1
        }
    }
}

extension MemoryCardView: MemoryCardPuzzleCoordinatorDelegate {
    func pairMatched() {
        viewModel.pairMatched()
    }
}

protocol MemoryCardPuzzleCoordinatorDelegate {
    func pairMatched()
}
