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
        
        init(delegate: MemoryCardPuzzleCoordinatorDelegate) {
            self.delegate = delegate
        }
        
        @objc func handleTap(_ sender: UITapGestureRecognizer) {
//            let tapLocation = sender.location(in: arView)
//            if let card = arView?.entity(at: tapLocation) {
//
//                delegate.pairMatched()
//            }
            
            let tapLocation = sender.location(in: arView)
            if let card = arView?.entity(at: tapLocation) {
                if card.transform.rotation.angle == .pi { // rotated to 180 deg
                    untap(card: card)
                } else {
                    tap(card: card)
                }
            }
        }
        
        private func tap(card: Entity) {
            var flipUpTransform = card.transform
            flipUpTransform.rotation = simd_quatf(angle: .pi, axis: [1, 0, 0])
            card.move(to: flipUpTransform, relativeTo: card.parent, duration: 0.25, timingFunction: .easeInOut)
        }
        
        private func untap(card: Entity) {
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
        let anchor = AnchorEntity(plane: .horizontal, minimumBounds: [0.5, 0.5])
        arView.scene.addAnchor(anchor)
        
        var cards: [Entity] = []
        for _ in 1...(viewModel.marker.cardPairs*2) {
            let box = MeshResource.generateBox(width: 0.1, height: 0.008, depth: 0.1)
            let metalMaterial = SimpleMaterial(color: .gray, isMetallic: true)
            let model = ModelEntity(mesh: box, materials: [metalMaterial])
            
            model.generateCollisionShapes(recursive: true)
            
            cards.append(model)
        }
        
        for (index,card) in cards.enumerated() {
            let x = Float(index % viewModel.marker.cardPairs)
            let z = Float(index / viewModel.marker.cardPairs)
            card.position = [x*0.2, 0, z*0.2]
            anchor.addChild(card)
        }
        
        // create occlusion
        let boxSize: Float = 0.7
        let occlusionBoxMesh = MeshResource.generateBox(size: boxSize)
        let occlusionBox = ModelEntity(mesh: occlusionBoxMesh, materials: [OcclusionMaterial()])
        occlusionBox.position.y = -boxSize/2
        anchor.addChild(occlusionBox)
        
        // load models
        var cancellable: AnyCancellable? = nil
        cancellable = ModelEntity.loadModelAsync(named: "plane")
            .append(ModelEntity.loadModelAsync(named: "drummer"))
            .append(ModelEntity.loadModelAsync(named: "cup"))
            .append(ModelEntity.loadModelAsync(named: "kettle"))
            .collect()
            .sink(receiveCompletion: {error in
                print("oksi Error \(error)")
                cancellable?.cancel()
            }, receiveValue: { (entities) in
                print("oksi success")
                var objects: [ModelEntity] = []
                for entity in entities {
                    entity.setScale(SIMD3<Float>(0.002, 0.002, 0.002), relativeTo: anchor)
                    entity.generateCollisionShapes(recursive: true)
                    for _ in 1...2 {
                        objects.append(entity.clone(recursive: true))
                    }
                }
                objects.shuffle()

                for (index, object) in objects.enumerated() {
                    if index == viewModel.marker.cardPairs*2 {
                        break
                    }
                    cards[index].addChild(object)
                    cards[index].transform.rotation = simd_quatf(angle: .pi, axis: [1, 0, 0])
                }
                cancellable?.cancel()
            })
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
