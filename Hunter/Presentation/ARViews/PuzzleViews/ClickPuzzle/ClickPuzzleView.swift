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

        // Load the "Box" scene from the "Experience" Reality File
        let box = try! Experience.loadBox() // type: Entity
        arView.scene.anchors.append(box)
        return arView
    }
    
    // MARK: - Coordinator
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(delegate: self)
    }
    
    public class Coordinator: NSObject, ARSessionDelegate {
        weak var arView: ARView?
        let delegate: CoordinatorDelegate
        
        init(delegate: CoordinatorDelegate) {
            self.delegate = delegate
        }
        
        @objc func handleTap() {
            delegate.handleTap()
        }
    }
    
    public func updateUIView(_ uiView: ARView, context: Context) {
        print()
    }
}

extension ClickPuzzleView: CoordinatorDelegate {
    func handleTap() {
        viewModel.puzzleDidTap()
    }
}

protocol CoordinatorDelegate {
    func handleTap()
}
