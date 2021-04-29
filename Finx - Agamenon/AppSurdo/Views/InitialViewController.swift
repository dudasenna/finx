//
//  InitialViewController.swift
//  ChallengeDoisUnidos
//
//  Created by Elaine  Cruz on 31/08/20.
//  Copyright © 2020 Elaine  Cruz. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAnalytics

class InitialViewController: UIViewController {
    @IBOutlet weak var camButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var tittle: UILabel!
    var cores: [UIColor] = []
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tittle.font = UIFont(name: "RalewayDots-Regular", size: 250)
        tittle.minimumScaleFactor = 0.2
        tittle.numberOfLines = 0
        tittle.adjustsFontSizeToFitWidth = true
        tittle.baselineAdjustment = .alignCenters
        tittle.textAlignment  = .center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        camButton.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
        
        helpButton.addTarget(self, action: #selector(instructionsButtonAction), for: .touchUpInside)

        self.view.addSubview(helpButton)
        self.view.addSubview(camButton)

        tittle.translatesAutoresizingMaskIntoConstraints = false
        camButton.translatesAutoresizingMaskIntoConstraints  = false
        helpButton.translatesAutoresizingMaskIntoConstraints = false
  
        camButton.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        camButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        camButton.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3).isActive = true
        camButton.heightAnchor.constraint(equalTo: camButton.widthAnchor).isActive = true
        
        tittle.bottomAnchor.constraint(equalTo: camButton.topAnchor, constant: -50).isActive = true
        tittle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        tittle.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2).isActive = true
        tittle.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        
        helpButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        helpButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        helpButton.widthAnchor.constraint(equalToConstant: 41).isActive = true
        helpButton.heightAnchor.constraint(equalToConstant: 41).isActive = true
        
    }
    
    @IBAction func startButtonAction(sender: UIButton!) {
        Analytics.logEvent("pressed_play", parameters: nil)
    }
    
    @IBAction func instructionsButtonAction(sender: UIButton!) {
        Analytics.logEvent(AnalyticsEventTutorialBegin, parameters: nil)
        print("Button tapped")
    }
}
