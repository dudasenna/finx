//
//  camCoords.swift
//  AppSurdo
//
//  Created by Jéssica Amaral on 09/04/21.
//  Copyright © 2021 Luis Pereira. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

class CamCoords {
    var x: Float
    var y: Float
    var z: Float
    
    init() {
        self.x = 0
        self.y = 0
        self.z = 0
    }
    
    func getCamCoords(sceneView: ARSCNView) {
        let cam = sceneView.session.currentFrame?.camera.transform
        let coords = MDLTransform(matrix: cam!)
        
        self.x = coords.translation.x
        self.y = coords.translation.y
        self.z = coords.translation.z
    }
}
