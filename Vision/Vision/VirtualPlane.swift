//
//  VirtualPlane.swift
//  Vision
//
//  Created by Mike Choi on 11/18/17.
//  Copyright © 2017 Muin Momin. All rights reserved.
//

import Foundation
import ARKit

class VirtualPlane : SCNNode {
    var anchor : ARPlaneAnchor!
    var planeGeometry: SCNPlane!
    
    init(anchor: ARPlaneAnchor) {
        super.init()
        
        // Initialize anchor and geometry
        self.anchor = anchor
        planeGeometry = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
        planeGeometry.materials = [initPlaneMaterial()]
        
        // Create SceneKit plane node
        let planeNode = SCNNode(geometry: planeGeometry)
        planeNode.position = SCNVector3(anchor.center.x, 0, anchor.center.z)
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2.0, 1.0, 0.0, 0.0)
        
        // Update material representtion
        updatePlaneMaterialDimensions()
        
        // Add node to hiearchy
        addChildNode(planeNode)
    }
    
    func initPlaneMaterial() -> SCNMaterial {
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.white.withAlphaComponent(0.50)
        return material
    }
    
    func updatePlaneMaterialDimensions() {
        // Get old material we need to update
        let material = planeGeometry.materials.first!
        
        // Update with new updated plane
        let width = Float(planeGeometry.width)
        let height = Float(planeGeometry.height)
        material.diffuse.contentsTransform = SCNMatrix4MakeScale(width, height, 1.0)
    }
    
    func updateWithNewAnchor(_ anchor: ARPlaneAnchor) {
        // Update extend of new plane just in case
        planeGeometry.width = CGFloat(anchor.extent.x)
        planeGeometry.height = CGFloat(anchor.extent.z)
        
        // Update position of plane
        position = SCNVector3(anchor.center.x, 0, anchor.center.z)
        
        // ... and its material
        updatePlaneMaterialDimensions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
