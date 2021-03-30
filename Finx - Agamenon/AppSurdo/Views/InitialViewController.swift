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
    //    var colorButton = #colorLiteral(red: 0.9067924023, green: 0.6966804862, blue: 0.7795810103, alpha: 1)
    
    @IBOutlet weak var camButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var tittle: UILabel!
    var cores: [UIColor] = []
    
//    /*structs e vars para o translator*/
//    //*****used after parsing to create variables with language information
//    struct TranslatorLanguageDetails: Codable {
//        var code = String()
//        var name = String()
//        var nativeName = String()
//        var dir = String()
//    }
//    
//    //Recebe values do json decoded
//    struct AzureLanguageDetails: Codable {
//        var name: String
//        var nativeName: String
//        var dir: String
//    }
//    
//    //*****used in the parsing of request Json
//    struct AllLanguages: Codable {
//        var translation: [String: AzureLanguageDetails]
//    }
//    
//    struct encodeText: Codable {
//        var text = String()
//    }
//    
//    //*****Format JSON for body of translation request
//    struct TranslatedString: Codable {
//        var text: String
//        var to: String
//    }
//    
//    struct TranslatedData: Codable {
//        var translations: [TranslatedString]
//    }
//    
//    var portugueseBrLanguage = TranslatorLanguageDetails(code: " ", name: " ", nativeName: " ", dir: " ")
//    var englishLanguage = TranslatorLanguageDetails(code: " ", name: " ", nativeName: " ", dir: " ")
    
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
//        test.loadFactWithNumber(number: 18)
        camButton.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
        
        helpButton.addTarget(self, action: #selector(instructionsButtonAction), for: .touchUpInside)

        self.view.addSubview(helpButton)
        self.view.addSubview(camButton)

        tittle.translatesAutoresizingMaskIntoConstraints = false
        camButton.translatesAutoresizingMaskIntoConstraints  = false
        helpButton.translatesAutoresizingMaskIntoConstraints = false
  
        //camButton.topAnchor.constraint(equalTo: tittle.bottomAnchor, constant: 80).isActive = true
        camButton.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        camButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        camButton.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3).isActive = true
        camButton.heightAnchor.constraint(equalTo: camButton.widthAnchor).isActive = true
        
//       tittle.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive=true
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
    
//    func loadFactWithNumber(numberOfFacts: Int) {
//        var i = 0
//
//        while i < numberOfFacts {
//            let urlStrin = "http://numbersapi.com/random?min=10&max=99/trivia?json"
//            let url = URL(string: urlStrin)
//            var request = URLRequest(url: url!)
//
//            request.httpMethod = "GET"
//            let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
//                //let decoder = JSONDecoder()
//                let jsonData = String(data: data!, encoding: .utf8) as String?
//                //self.fact = jsonData
//                //            print(jsonData!)
//                let numberString = self.takeNumber(fact: jsonData!)
//                //            let numberInt = Int(numberString) ?? 0
//                if self.numbers.contains(numberString) {
//                    self.loadFactWithNumber(numberOfFacts: i)
//                } else {
//                    self.numbers.append(numberString)
//                    self.getTranslation(textToTranslate: jsonData!, numberString: numberString)
//                }
//            }
//            task.resume()
//            i+=1
//        }
//    }
//
//    func getTranslation(textToTranslate: String, numberString: String) {
//        //key genereted from azure (microsoft)
//        let azureKey = "a877d5a784f341eaab11789221a68916"
//
//        let contentType = "application/json"
//        let traceID = "A14C9DB9-0DED-48D7-8BBE-C517A1A8DBB0"
//        let host = "dev.microsofttranslator.com"
//        let apiURL = "https://dev.microsofttranslator.com/translate?api-version=3.0&from=en&to=pt"
//
//        //let text2Translate = textToTranslate
//        var encodeTextToTranslate = encodeText()
//        var toTranslate = [encodeText]()
//
//        encodeTextToTranslate.text = textToTranslate
//        toTranslate.append(encodeTextToTranslate)
//        //        print(toTranslate)
//        let jsonToTranslate = try? JSONEncoder().encode(toTranslate)
//        //        print(jsonToTranslate)
//        let url = URL(string: apiURL)
//        var request = URLRequest(url: url!)
//
//        request.httpMethod = "POST"
//        request.addValue(azureKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
//        request.addValue(contentType, forHTTPHeaderField: "Content-Type")
//        request.addValue(traceID, forHTTPHeaderField: "X-ClientTraceID")
//        request.addValue(host, forHTTPHeaderField: "Host")
//        request.addValue(String(describing: 1), forHTTPHeaderField: "Content-Length")
//        request.httpBody = jsonToTranslate
//
//        let config = URLSessionConfiguration.default
//        let session =  URLSession(configuration: config)
////        var phraseTranslated: String = ""
//
//        let task = session.dataTask(with: request) { (responseData, response, responseError) in
//
//            if responseError != nil {
//                print("this is the error ", responseError!)
//
//                let alert = UIAlertController(title: "Could not connect to service", message: "Please check your network connection and try again", preferredStyle: .actionSheet)
//
//                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//
//                self.present(alert, animated: true)
//
//            } else {
//                let dataTranslation = try? JSONDecoder().decode(Array<TranslatedData>.self, from: responseData!)
//                let numberOfTranslations = dataTranslation!.count - 1
//
//                let phraseTranslated = dataTranslation![0].translations[numberOfTranslations].text
//
//                self.facts.append((numberString, phraseTranslated))
//                
//            }
//            print(responseData!)
//            //self.parseJson(jsonData: responseData!, numberString: numberString)
//        }
//        task.resume()
//        //        print(phraseTranslated)
//        //        return phraseTranslated
//    }
//
//    func parseJson(jsonData: Data, numberString: String) {
//        //        print(jsonData)
//        //*****TRANSLATION RETURNED DATA*****
//
//        //let jsonDecoder = JSONDecoder()
//      
//    }
//
//    func takeNumber(fact:String)->String{
//        let numberString = Array(fact)
//        var newString = String()
//        for index in numberString.indices{
//
//            if numberString[index].isNumber{
//                newString.append(numberString[index])
//            } else {
//                return newString
//            }
//
//        }
//        return newString
//    }
//    
//    override func prepare (for segue: UIStoryboardSegue, sender:Any?) {
//        if segue.identifier == "ARSegue" {
//            let vcEquation = segue.destination as? ARViewController
//            print(facts)
//            vcEquation?.facts = facts.shuffled()
//            vcEquation?.numbers = numbers
//            
//        }
//    }
    
    @IBAction func instructionsButtonAction(sender: UIButton!) {
        Analytics.logEvent(AnalyticsEventTutorialBegin, parameters: nil)
        print("Button tapped")
    }
}
