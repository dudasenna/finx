//
//  LoadView.swift
//  AppSurdo
//
//  Created by Jéssica Amaral on 25/03/21.
//  Copyright © 2021 Luis Pereira. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class LoadViewController: UIViewController {
    /*structs e vars para o translator*/
    //*****used after parsing to create variables with language information
    @IBOutlet var animationView: AnimationView!
    @IBOutlet weak var animationLabel: UILabel!
    
    var facts: [(String, String)]! = []
    var numbers: [String]! = []
    
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        animationLabel.font = UIFont(name: "Raleway-Bold", size: 30)
        animationLabel.adjustsFontSizeToFitWidth = true
        animationLabel.adjustsFontForContentSizeCategory = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationView = .init(name: "loadAnimation")
        animationView?.contentMode = .scaleAspectFill
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 3.0
        animationView?.backgroundColor = .clear
        
        animationLabel.text = "Escondendo frases..."
        animationLabel.textColor = .white
        
        self.view.addSubview(animationView!)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        animationView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        animationView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor).isActive = true
        animationView.heightAnchor.constraint(equalTo: animationView.widthAnchor).isActive = true
        
        animationLabel.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 30).isActive = true
        animationLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        animationLabel.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.55).isActive = true
        
        animationView?.play()
        
        loadFactWithNumber(numberOfFacts: 3)
    }
    
    var countFetched = 0
    var countTranslated = 0
    func loadFactWithNumber(numberOfFacts: Int) {
        var i = 0

        while i < numberOfFacts {
            let urlStrin = "http://numbersapi.com/random?min=10&max=99/trivia?json"
            let url = URL(string: urlStrin)
            var request = URLRequest(url: url!)

            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                if let jsonData = String(data: data!, encoding: .utf8) as String? {
                    let numberString = self.takeNumber(fact: jsonData)
                    if self.numbers.contains(numberString) {
                        self.loadFactWithNumber(numberOfFacts: i)
                    } else {
                        self.numbers.append(numberString)
                        self.countFetched = self.countFetched + 1
                        self.getTranslation(textToTranslate: jsonData, numberString: numberString)
                    }
                } else {
                    self.loadFactWithNumber(numberOfFacts: 1)
                }
                print(self.countFetched)
                
            }
            task.resume()
            i+=1
        }
    }
    
    func getTranslation(textToTranslate: String, numberString: String) {
        //key genereted from azure (microsoft)
        let azureKey = "a877d5a784f341eaab11789221a68916"

        let contentType = "application/json"
        let traceID = "A14C9DB9-0DED-48D7-8BBE-C517A1A8DBB0"
        let host = "dev.microsofttranslator.com"
        let apiURL = "https://dev.microsofttranslator.com/translate?api-version=3.0&from=en&to=pt"

        var encodeTextToTranslate = encodeText()
        var toTranslate = [encodeText]()

        encodeTextToTranslate.text = textToTranslate
        toTranslate.append(encodeTextToTranslate)
        let jsonToTranslate = try? JSONEncoder().encode(toTranslate)
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

        let task = session.dataTask(with: request) { (responseData, response, responseError) in

            if responseError != nil {
                print("this is the error ", responseError!)

                let alert = UIAlertController(title: "Could not connect to service", message: "Please check your network connection and try again", preferredStyle: .actionSheet)

                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

                self.present(alert, animated: true)

            } else {
                
                if let dataTranslation = try? JSONDecoder().decode(Array<TranslatedData>.self, from: responseData!) {
                    let numberOfTranslations = dataTranslation.count - 1

                    let phraseTranslated = dataTranslation[0].translations[numberOfTranslations].text
        
                    self.facts.append((numberString, phraseTranslated))
                    self.countTranslated = self.countTranslated + 1
                } else {
                    self.loadFactWithNumber(numberOfFacts: 1)
                }
            }
            if self.facts.count == 3 {
                DispatchQueue.main.async {
                    self.animationView.pause()
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let vcAR = storyBoard.instantiateViewController(withIdentifier: "ARViewController") as! ARViewController
                    vcAR.facts = self.facts.shuffled()
                    vcAR.numbers = self.numbers
                    self.present(vcAR, animated:true, completion:nil)
                }
            }
        }
        print(task.resume())
        task.resume()
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
