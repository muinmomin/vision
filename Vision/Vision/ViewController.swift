//
//  ViewController.swift
//  Vision
//
//  Created by Muin Momin on 11/18/17.
//  Copyright © 2017 Muin Momin. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var planes : [UUID: VirtualPlane] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.showsStatistics = true
        
        // Create scene and set scene to view
        let scene = SCNScene()
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal

        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    func addPipe(x: Float, y: Float, z: Float) {
    }
    
    // MARK: - ARSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        let plane = VirtualPlane(anchor: planeAnchor)
        planes[planeAnchor.identifier] = plane
        node.addChildNode(plane)
    }
    
    // When a detected plane is updated, make a new planeNode
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        guard let plane = planes[planeAnchor.identifier] else { return }
        plane.updateWithNewAnchor(planeAnchor)
        
        guard let pipeScene = SCNScene(named: "pipe.dae"), let pipeNode = pipeScene.rootNode.childNode(withName: "pipe", recursively: true) else {
            print("ERROR HERE")
            return
        }
        pipeNode.position = SCNVector3(1, 1, 1)
        sceneView.scene.rootNode.addChildNode(pipeNode)
    }
    
    // When a detected plane is removed, remove the planeNode
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        guard let idx = planes.index(forKey: planeAnchor.identifier) else {return }
        planes.remove(at: idx)
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
