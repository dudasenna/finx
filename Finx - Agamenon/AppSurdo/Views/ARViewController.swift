//
//  ARViewController.swift
//  AppSurdo
//
//  Created by Luis Pereira on 31/08/20.
//  Copyright © 2020 Luis Pereira. All rights reserved.
//

import Foundation
import UIKit
import SceneKit
import ARKit
import FirebaseAnalytics

//@property (nonatomic, assign) BOOL isSomethingEnabled;


//colocar key na linha 334

class ARViewController: UIViewController, ARSCNViewDelegate {
    var facts: [(String, String)]!
    var numbers: [String]!
//    var vcLoad: LoadViewController!

    @IBOutlet var sceneView: ARSCNView!
    var baseLoaded:Bool = false
    
    @IBOutlet weak var popUp: UIImageView!
    @IBOutlet weak var card1: UIButton!
    @IBOutlet weak var card2: UIButton!
    @IBOutlet weak var card3: UIButton!
    @IBOutlet weak var answersButton: UIButton!
    
    
    //    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var popLabel: UILabel!
    @IBOutlet weak var popCheckAnswerLabel: UILabel!
    @IBOutlet weak var popButton: UIButton!
    let closeButton = UIButton()
//    @IBOutlet weak var nextButton: UIButton!
    
    
    var cubes: [SCNNode]!
    var cardButtons: [UIButton] = []
    var currentCard = 0
    var numberOfTouches = 0
    
    var lifes = 3
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        popButton.titleLabel?.font = UIFont(name: "Raleway-SemiBold", size: 30)
        popButton.titleLabel?.adjustsFontSizeToFitWidth = true
        popButton.titleLabel?.adjustsFontForContentSizeCategory = true
        
        popLabel.font = UIFont(name: "Raleway-SemiBold", size: 25)
        popLabel.adjustsFontSizeToFitWidth = true
        popLabel.adjustsFontForContentSizeCategory = true
        
        popCheckAnswerLabel.adjustsFontSizeToFitWidth = true
        popCheckAnswerLabel.adjustsFontForContentSizeCategory = true
        
        card1.setTitle(numbers[0], for: .normal)
        card1.titleLabel?.font = UIFont(name: "Raleway-SemiBold", size: 20)
        card1.titleLabel?.adjustsFontSizeToFitWidth = true
        card1.titleLabel?.adjustsFontForContentSizeCategory = true
        card1.setBackgroundImage(UIImage(named: "card"), for: .disabled)
        
        card2.setTitle(numbers[1], for: .normal)
        card2.titleLabel?.font = UIFont(name: "Raleway-SemiBold", size: 20)
        card2.titleLabel?.adjustsFontSizeToFitWidth = true
        card2.titleLabel?.adjustsFontForContentSizeCategory = true
        card2.setBackgroundImage(UIImage(named: "card"), for: .disabled)
        
        card3.setTitle(numbers[2], for: .normal)
        card3.titleLabel?.font = UIFont(name: "Raleway-SemiBold", size: 20)
        card3.titleLabel?.adjustsFontSizeToFitWidth = true
        card3.titleLabel?.adjustsFontForContentSizeCategory = true
        card3.setBackgroundImage(UIImage(named: "card"), for: .disabled)
        
        answersButton.setTitle("Ver Respostas", for: .normal)
        answersButton.titleLabel?.font = UIFont(name: "Raleway-SemiBold", size: 20)
        answersButton.titleLabel?.adjustsFontSizeToFitWidth = true
        answersButton.titleLabel?.adjustsFontForContentSizeCategory = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeButton.backgroundColor = .white
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .black
        closeButton.layer.cornerRadius = 10
        closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        self.view.addSubview(closeButton)
        answersButton.isHidden = true
        answersButton.addTarget(self, action: #selector(showAnswers), for: .touchUpInside)
//        presentingViewController?.dismiss(animated: false, completion: nil)
        popView.isHidden = false
      
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = false
        sceneView.debugOptions = [.showFeaturePoints]
        
        cubes = []
        for i in sceneView.scene.rootNode.childNodes{
            if i.name == "cube"{
                cubes.append(i)
            }
        }
        
        cardButtons = [card1,card2,card3]
        
        for button in cardButtons {
            button.isEnabled = false
            button.addTarget(self, action: #selector(testAnswer), for: .touchUpInside)
        }
        
        popLabel.numberOfLines = 0
        popLabel.textColor = .white
        popLabel.text = "Procure os cubos na cena para revelar as frases"
        popLabel.isHidden = false
        
        popCheckAnswerLabel.font = UIFont(name: "Raleway-SemiBold", size: 12)
        popCheckAnswerLabel.numberOfLines = 1
        popCheckAnswerLabel.textColor = .white
        popCheckAnswerLabel.isHidden = true
        
        popButton.setTitle("ok", for: .normal)
        popButton.isHidden = false
        popButton.addTarget(self, action: #selector(tapCollect), for: .touchUpInside)
        // Create a new scene
        //let scene = SCNScene(named: "art.scnassets/mainScene.scn")!
        
        // Set the scene to the view
        //sceneView.scene = scene
        
        popView.translatesAutoresizingMaskIntoConstraints = false
        popLabel.translatesAutoresizingMaskIntoConstraints = false
        popButton.translatesAutoresizingMaskIntoConstraints = false
//        nextButton.translatesAutoresizingMaskIntoConstraints = false
        popUp.translatesAutoresizingMaskIntoConstraints = false
        answersButton.translatesAutoresizingMaskIntoConstraints = false
        popCheckAnswerLabel.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        popView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5).isActive = true
        popView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.75).isActive = true
        popView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        popView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        popUp.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.75).isActive = true
        popUp.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.52).isActive = true
        popUp.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        popUp.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        popButton.centerXAnchor.constraint(equalTo: popView.centerXAnchor).isActive = true
        popButton.bottomAnchor.constraint(equalTo: popView.bottomAnchor, constant: -20).isActive = true
        popButton.heightAnchor.constraint(equalTo: popView.heightAnchor, multiplier: 0.15).isActive = true
        popButton.widthAnchor.constraint(equalTo: popView.widthAnchor, multiplier: 0.6).isActive = true
        
        popCheckAnswerLabel.centerXAnchor.constraint(equalTo: popView.centerXAnchor).isActive = true
        popCheckAnswerLabel.bottomAnchor.constraint(equalTo: popButton.topAnchor, constant: -20).isActive = true
        popCheckAnswerLabel.widthAnchor.constraint(equalTo: popView.widthAnchor, multiplier: 0.9).isActive = true
        popCheckAnswerLabel.heightAnchor.constraint(equalTo: popView.heightAnchor, multiplier: 0.1).isActive = true
        
        popLabel.centerYAnchor.constraint(equalTo: popView.centerYAnchor).isActive = true
        popLabel.centerXAnchor.constraint(equalTo: popView.centerXAnchor).isActive = true
        popLabel.widthAnchor.constraint(equalTo: popView.widthAnchor, multiplier: 0.9).isActive = true
        popLabel.topAnchor.constraint(equalTo: popView.topAnchor, constant: 20).isActive = true
        popLabel.bottomAnchor.constraint(equalTo: popCheckAnswerLabel.topAnchor, constant: -10).isActive = true
        
        answersButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        answersButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        answersButton.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7).isActive = true
        answersButton.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1).isActive = true
        
        closeButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        closeButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        numberOfTouches = numberOfTouches + 1
        if baseLoaded == false{
            addScenario(location: (touches.first?.location(in: sceneView))!)
        }else{
//            print("Scenario loaded")
            
            //Checking if cube was found
            let touch = touches.first!
            
            if(touch.view == self.sceneView){
                let viewTouchLocation:CGPoint = touch.location(in: sceneView)
                guard let result = sceneView.hitTest(viewTouchLocation, options: nil).first else {
                    return
                }
                if result.node.name == "cube" {
                    let encoded = self.hideNumbers(fact: facts[currentCard].1)
                    self.popLabel.text = encoded
                    popView.isHidden = false
                    popButton.isHidden = true
                    for button in cardButtons {
                        button.isEnabled = true
                        button.setBackgroundImage(UIImage(named: "CardActive"), for: .normal)
                    }
                    currentCard+=1
                    result.node.removeFromParentNode()
                }
            }
        }
        
    }
    
    func addScenario(location:CGPoint){
        let hitResult = sceneView.hitTest(location, types: [.existingPlane])
        if hitResult.count > 0 {
            let result = hitResult.first!
            let newPosition = SCNVector3(result.worldTransform.columns.3.x, result.worldTransform.columns.3.y, result.worldTransform.columns.3.z)
            let scene = SCNScene(named: "art.scnassets/mainScene.scn")!
            let rootNode = scene.rootNode.childNode(withName: "BaseReference", recursively: false)
            rootNode?.position = newPosition
            sceneView.scene = scene
            Analytics.logEvent("loaded_scenario", parameters: nil)
            Analytics.logEvent("touches_until_load", parameters: ["number_of_touches":numberOfTouches])
            print("Load scenario")
            baseLoaded = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        UIApplication.shared.isIdleTimerDisabled = true
        sceneView.autoenablesDefaultLighting = true
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    func addNodeAtLocation(location:CGPoint){
        print("adding node...")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if baseLoaded == false {
            Analytics.logEvent("did_not_load_ar", parameters: nil)
        }
        // Pause the view's session
        sceneView.session.pause()
//        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - ARSCNViewDelegate
    
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    
    @IBAction func tapCollect(_ sender: UIButton) {
        popUp.image = UIImage(named: "PopupFatos")
        popCheckAnswerLabel.isHidden = true
        
        if popButton.title(for: .normal) == "Coletar" || popLabel.text == "Procure os cubos na cena para revelar as frases" {
            popView.isHidden = true
            popLabel.text = ""
        } else {
            popButton.isHidden = true
            for button in cardButtons {
                button.isEnabled = true
                button.setBackgroundImage(UIImage(named: "CardActive"), for: .normal)
            }
        }
        
        if popButton.title(for: .normal) == "Jogar Novamente" {
            self.performSegue(withIdentifier: "LoadSegue", sender: nil)
        }
        popButton.setTitle("Coletar", for: .normal)
    }
    
    override func prepare (for segue: UIStoryboardSegue, sender:Any?) {
        if segue.identifier == "FactsSegue" {
            let vcEquation = segue.destination as? FactsViewController
            vcEquation?.factsOfNumbers = facts        }
    }
    
    func hideNumbers(fact:String)->String{
        let hidedString = Array(fact)
        var newString = String()
        var lastNumber = -1
        for indice in hidedString.indices{
            if hidedString[indice].isNumber {
                newString.append("_")
                lastNumber = indice
            } else {
                if lastNumber >= 0 {
                    let index = fact.index(fact.startIndex, offsetBy: lastNumber+1)
                    let substring = fact.suffix(from: index)
                    newString.append(contentsOf: substring)
                    break
                } else {
                    newString.append(hidedString[indice])
                }
            }

        }
        return newString
    }
    
    @IBAction func testAnswer(_ sender: UIButton) {
        let numberPressed = sender.title(for: .normal)
        let factNumber = facts[currentCard-1].0
        self.popCheckAnswerLabel.isHidden = false
        
        if numberPressed == factNumber {
            popButton.isHidden = false
            popUp.image = UIImage(named: "RectangleRight")
            
            if currentCard == 3 {
                popLabel.text = "Você ganhou! 🎉"
                popButton.setTitle("Jogar Novamente", for: .normal)
                popCheckAnswerLabel.isHidden = true
                card1.isHidden = true
                card2.isHidden = true
                card3.isHidden = true
                answersButton.isHidden = false
            } else {
                popCheckAnswerLabel.isHidden = false
                popCheckAnswerLabel.text = "Você acertou! 🥳"
            }
            
            cardButtons.removeAll(where: {$0 == sender})
            
            for button in cardButtons {
                button.isEnabled = false
                button.setBackgroundImage(UIImage(named: "Card"), for: .normal)
            }
            
            sender.setBackgroundImage(UIImage(named: "CardCorrect"), for: .normal)
            sender.isEnabled  = false
            
        } else {
            lifes -= 1
            popUp.image = UIImage(named: "RectangleWrong")
            
            if lifes == 0 {
                popLabel.text = "Poxa, não foi dessa vez...😔 Mas não desiste, na próxima você consegue! 😁"
                popButton.setTitle("Jogar Novamente", for: .normal)
                popButton.isHidden = false
                card1.isHidden = true
                card2.isHidden = true
                card3.isHidden = true
                popCheckAnswerLabel.isHidden = true
                answersButton.isHidden = false
            } else {
                self.popCheckAnswerLabel.text = "Pense mais um pouco! 🤔 (\(lifes) chances restantes)"
                popCheckAnswerLabel.isHidden = false
                popButton.isHidden = false
                popButton.setTitle("OK", for: .normal)
                
                for button in cardButtons {
                    button.isEnabled = false
                }
            }
        }
    }
    
    @IBAction func showAnswers (_ sender: UIButton) {
        self.performSegue(withIdentifier: "FactsSegue", sender: self)
    }
    
    @objc func closeButtonAction(sender: UIButton!) {
    
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let vcAR = storyBoard.instantiateViewController(withIdentifier: "ARViewController") as! ARViewController
//        let vcLoad = storyBoard.instantiateViewController(withIdentifier: "LoadViewController") as! LoadViewController
        let vcInit = storyBoard.instantiateViewController(withIdentifier: "InitialViewController") as! InitialViewController
        self.present(vcInit, animated:true, completion:nil)
//        let segue: UIStoryboardSegue = UIStoryboardSegue(identifier: "ARSegue", source: vcAR, destination: vcLoad)
//        self.unwind(for: segue, towards: vcInit)
    }
    /* func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
     
     print("new plane")
     // Cast ARAnchor as ARPlaneAnchor
     guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
     
     // Create SCNGeometry from ARPlaneAnchor details
     let width = CGFloat(planeAnchor.extent.x)
     let height = CGFloat(planeAnchor.extent.z)
     let planeGeometry = SCNPlane(width: width, height: height)
     
     // Add material to geometry
     let material = SCNMaterial()
     material.diffuse.contents = UIColor.blue.withAlphaComponent(0.8)
     planeGeometry.materials = [material]
     
     // Create a SCNNode from geometry
     let planeNode = SCNNode(geometry: planeGeometry)
     planeNode.position = SCNVector3(planeAnchor.center.x, planeAnchor.center.y, planeAnchor.center.z)
     planeNode.eulerAngles.x = -.pi / 2
     
     // Add the newly created plane node as a child of the node created for the ARAnchor
     
     node.addChildNode(planeNode)
     
     
     }
     
     func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
     print("update plane")
     guard let planeAnchor = anchor as? ARPlaneAnchor, let planeNode = node.childNodes.first,
     let planeGeometry = planeNode.geometry as? SCNPlane else { return }
     
     // Update the dimensions of the plane geometry based on the plane anchor.
     planeGeometry.width = CGFloat(planeAnchor.extent.x)
     planeGeometry.height = CGFloat(planeAnchor.extent.z)
     
     // Update the position of the plane node based on the plane anchor.
     planeNode.position = SCNVector3(planeAnchor.center.x, planeAnchor.center.y, planeAnchor.center.z)
     }
     
     func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
     print("removed")
     }*/
    
}
