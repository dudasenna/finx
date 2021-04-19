//
//  CoachingOverlay.swift
//  testingARKit
//
//  Created by Jéssica Amaral on 07/04/21.
//

import Foundation
import UIKit
import ARKit

extension ARViewController: ARCoachingOverlayViewDelegate {
    func coachingOverlayViewWillActivate(_ coachingOverlayView: ARCoachingOverlayView) {
        //esconder os botões dos números
        card1.isHidden = true
        card2.isHidden = true
        card3.isHidden = true
    }
    
    func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        //mostrar os botões dos números
        card1.isHidden = false
        card2.isHidden = false
        card3.isHidden = false
    }
    
    func setCoachingOverlay() {
        coachingOverlay.session = sceneView.session
        coachingOverlay.delegate = self
        
        coachingOverlay.translatesAutoresizingMaskIntoConstraints = false
        
        sceneView.addSubview(coachingOverlay)
        
        coachingOverlay.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        coachingOverlay.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        coachingOverlay.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        coachingOverlay.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        coachingOverlay.activatesAutomatically = true
        coachingOverlay.goal = .horizontalPlane
    }
}
