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
//#import "EquationViewController.swift"

//colocar key na linha 334

class ARViewController: UIViewController, ARSCNViewDelegate {
    var facts: [(String, String)]! = []
    var numbers: [String]! = []
    
    @IBOutlet var sceneView: ARSCNView!
    var baseLoaded:Bool = false
    
    @IBOutlet weak var card1: UIButton!
    @IBOutlet weak var card2: UIButton!
    @IBOutlet weak var card3: UIButton!
    
    //    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var popLabel: UILabel!
    @IBOutlet weak var popButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    var cubes: [SCNNode]!
    var cardButtons: [UIButton] = []
    var currentCard = 0
    var numberOfTouches = 0
    
    //*****used after parsing to create variables with language information
    struct TranslatorLanguageDetails: Codable {
        var code = String()
        var name = String()
        var nativeName = String()
        var dir = String()
    }
    
    //Recebe values do json decoded
    struct AzureLanguageDetails: Codable {
        var name: String
        var nativeName: String
        var dir: String
    }
    
    //*****used in the parsing of request Json
    struct AllLanguages: Codable {
        var translation: [String: AzureLanguageDetails]
    }
    
    struct encodeText: Codable {
        var text = String()
    }
    
    //*****Format JSON for body of translation request
    struct TranslatedString: Codable {
        var text: String
        var to: String
    }
    
    struct TranslatedData: Codable {
        var translations: [TranslatedString]
    }
    
    var portugueseBrLanguage = TranslatorLanguageDetails(code: " ", name: " ", nativeName: " ", dir: " ")
    var englishLanguage = TranslatorLanguageDetails(code: " ", name: " ", nativeName: " ", dir: " ")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popView.isHidden = false
        popView.backgroundColor = .white
        popView.alpha = 0.9
        popView.layer.borderWidth = 1
        popView.layer.borderColor = UIColor.white.cgColor
        popView.layer.cornerRadius = 10
        //        nextButton.isHidden = false
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = false
        sceneView.debugOptions = [.showFeaturePoints]
        
        cardButtons = [card1,card2,card3]
        cubes = []
        for i in sceneView.scene.rootNode.childNodes{
            if i.name == "cube"{
                cubes.append(i)
            }
        }
        
        popLabel.numberOfLines = 0
        popLabel.textColor = .black
        popLabel.text = "Procure os cubos na cena para revelar as frases"
        popLabel.isHidden = false
        
        popButton.setTitle("OK", for: .normal)
        popButton.isHidden = false
        // Create a new scene
        //let scene = SCNScene(named: "art.scnassets/mainScene.scn")!
        
        // Set the scene to the view
        //sceneView.scene = scene
        
        popView.translatesAutoresizingMaskIntoConstraints = false
        popLabel.translatesAutoresizingMaskIntoConstraints = false
        popButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        popView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -30).isActive = true
        popView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        popView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4).isActive = true
        popView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        
        popButton.centerXAnchor.constraint(equalTo: popView.centerXAnchor).isActive = true
        popButton.bottomAnchor.constraint(equalTo: popView.bottomAnchor, constant: -30).isActive = true
        popButton.heightAnchor.constraint(equalTo: popView.heightAnchor, multiplier: 0.2).isActive = true
        popButton.widthAnchor.constraint(equalTo: popView.widthAnchor, multiplier: 0.4).isActive = true
        
        popLabel.centerYAnchor.constraint(equalTo: popView.centerYAnchor, constant: -30).isActive = true
        popLabel.centerXAnchor.constraint(equalTo: popView.centerXAnchor).isActive = true
        popLabel.widthAnchor.constraint(equalTo: popView.widthAnchor, multiplier: 0.9).isActive = true
        
        nextButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        nextButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        nextButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2).isActive = true
        nextButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        
//        getLanguages()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        numberOfTouches = numberOfTouches + 1
        if baseLoaded == false{
            addScenario(location: (touches.first?.location(in: sceneView))!)
        }else{
            //print("Scenario loaded")
            
            //Checking if cube was found
            let touch = touches.first!
            
            if(touch.view == self.sceneView){
                
                //print("touch working")
                let viewTouchLocation:CGPoint = touch.location(in: sceneView)
                guard let result = sceneView.hitTest(viewTouchLocation, options: nil).first else {
                    return
                }
                if result.node.name == "cube" {
                    loadFactWithNumber()
                    popView.isHidden = false
                    cardButtons[currentCard].setImage(UIImage(named: "CardActive"), for: .normal)
                    currentCard+=1
                    result.node.removeFromParentNode()
                    
                    if(currentCard==3){
                        nextButton.isHidden = false
                    }
                }
                //print(numbers)
            }
        }
        
    }
    
    func addScenario(location:CGPoint){
        let hitResult = sceneView.hitTest(location, types: [.existingPlaneUsingExtent])
        if hitResult.count > 0 {
            let result = hitResult.first!
            let newPosition = SCNVector3(result.worldTransform.columns.3.x, result.worldTransform.columns.3.y, result.worldTransform.columns.3.z)
            let scene = SCNScene(named: "art.scnassets/mainScene.scn")!
            let rootNode = scene.rootNode.childNode(withName: "BaseReference", recursively: false)
            rootNode?.position = newPosition
            sceneView.scene = scene
            Analytics.logEvent("loaded_scenario", parameters: nil)
            Analytics.logEvent("touches_until_load", parameters: ["number_of_touches":numberOfTouches])
            //print("Load scenario")
            baseLoaded = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if baseLoaded == false {
            Analytics.logEvent("did_not_load_ar", parameters: nil)
        }
        // Pause the view's session
        sceneView.session.pause()
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
        popView.isHidden = true
        popLabel.text = ""
        popButton.setTitle("Coletar", for: .normal)
    }
    
    
    func loadFactWithNumber() {
        //        como tava antes
        //        let urlStrin = "http://numbersapi.com/" + String(number)
        let urlStrin = "http://numbersapi.com/random?min=10&max=99/trivia?json"
        let url = URL(string: urlStrin)
        var request = URLRequest(url: url!)
        var portuguesePhrase = ""
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            //let decoder = JSONDecoder()
            let jsonData = String(data: data!, encoding: .utf8) as String?
            //self.fact = jsonData
//            print(jsonData!)
            let numberString = self.takeNumber(fact: jsonData!)
            //            let numberInt = Int(numberString) ?? 0
            if self.numbers.contains(numberString) {
                self.loadFactWithNumber()
            } else {
                self.numbers.append(numberString)
                self.getTranslation(textToTranslate: jsonData!, numberString: numberString)
            }
        }
        task.resume()
    }
    
//    func getLanguages() {
//
//        let sampleLangAddress = "https://dev.microsofttranslator.com/languages?api-version=3.0&scope=translation"
//
//        let url1 = URL(string: sampleLangAddress)
//        let jsonLangData = try! Data(contentsOf: url1!)
//
//        //*****
//        var languages: AllLanguages?
//        languages = try! JSONDecoder().decode(AllLanguages.self, from: jsonLangData)
//
//        for language in languages!.translation {
//            if language.key == "en" {
//                englishLanguage.code = language.key
//                englishLanguage.name = language.value.name
//                englishLanguage.nativeName = language.value.nativeName
//                englishLanguage.dir = language.value.dir
//            } else if language.key == "pt"{
//                portugueseBrLanguage.code = language.key
//                portugueseBrLanguage.name = language.value.name
//                portugueseBrLanguage.nativeName = language.value.nativeName
//                portugueseBrLanguage.dir = language.value.dir
//            }
//        }
//    }
    
    func getTranslation(textToTranslate: String, numberString: String) {
        //key genereted from azure (microsoft)
        let azureKey = "a2415d26b70e4b12b5a519ffa9558aa5"
        
        let contentType = "application/json"
        let traceID = "A14C9DB9-0DED-48D7-8BBE-C517A1A8DBB0"
        let host = "dev.microsofttranslator.com"
        let apiURL = "https://dev.microsofttranslator.com/translate?api-version=3.0&from=en&to=pt"
        
        //let text2Translate = textToTranslate
        var encodeTextToTranslate = encodeText()
        var toTranslate = [encodeText]()
        
        encodeTextToTranslate.text = textToTranslate
        toTranslate.append(encodeTextToTranslate)
//        print(toTranslate)
        let jsonToTranslate = try? JSONEncoder().encode(toTranslate)
//        print(jsonToTranslate)
        let url = URL(string: apiURL)
        var request = URLRequest(url: url!)

        request.httpMethod = "POST"
        request.addValue(azureKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        request.addValue(contentType, forHTTPHeaderField: "Content-Type")
        request.addValue(traceID, forHTTPHeaderField: "X-ClientTraceID")
        request.addValue(host, forHTTPHeaderField: "Host")
        request.addValue(String(describing: 1), forHTTPHeaderField: "Content-Length")
        request.httpBody = jsonToTranslate
        
        let config = URLSessionConfiguration.default
        let session =  URLSession(configuration: config)
//        var phraseTranslated: String = ""
        
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            
            if responseError != nil {
                print("this is the error ", responseError!)
                
                let alert = UIAlertController(title: "Could not connect to service", message: "Please check your network connection and try again", preferredStyle: .actionSheet)
                
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                
                self.present(alert, animated: true)
                
            }
            
            self.parseJson(jsonData: responseData!, numberString: numberString)
        }
        task.resume()
//        print(phraseTranslated)
//        return phraseTranslated
    }
    
    func parseJson(jsonData: Data, numberString: String) {
//        print(jsonData)
        //*****TRANSLATION RETURNED DATA*****
        
        //let jsonDecoder = JSONDecoder()
        let dataTranslation = try? JSONDecoder().decode(Array<TranslatedData>.self, from: jsonData)
        let numberOfTranslations = dataTranslation!.count - 1
        
//        var phraseTranslated = ""
        let encoded = self.hideNumbers(fact: dataTranslation![0].translations[numberOfTranslations].text)
        self.facts.append((numberString, dataTranslation![0].translations[numberOfTranslations].text))
        DispatchQueue.main.sync {
//            print(encoded)
            DispatchQueue.main.async {
                self.popLabel.text = encoded
//                print(self.popLabel.text)
            }
        }
//        print(phraseTranslated)
//
//        return phraseTranslated
    }
    
    override func prepare (for segue: UIStoryboardSegue, sender:Any?) {
        if segue.identifier == "EquationSegue" {
            let vcEquation = segue.destination as? EquationViewController
            vcEquation?.factsOfNumbers = facts
            vcEquation?.pickerNumbers = numbers.shuffled()
        }
    }
    
    func hideNumbers(fact:String)->String{
        let hidedString = Array(fact)
        var newString = String()
        var lastNumber = -1
        for indice in hidedString.indices{
            if hidedString[indice].isNumber {
                newString.append("X")
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
    
    func takeNumber(fact:String)->String{
        let numberString = Array(fact)
        var newString = String()
        for index in numberString.indices{
            
            if numberString[index].isNumber{
                newString.append(numberString[index])
            } else {
                return newString
            }
            
        }
        return newString
    }
    
}
