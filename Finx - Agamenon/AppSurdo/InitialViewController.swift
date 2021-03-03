//
//  InitialViewController.swift
//  ChallengeDoisUnidos
//
//  Created by Elaine  Cruz on 31/08/20.
//  Copyright © 2020 Elaine  Cruz. All rights reserved.
//

import Foundation
import UIKit

class InitialViewController: UIViewController {
    var colorButton = #colorLiteral(red: 0.9067924023, green: 0.6966804862, blue: 0.7795810103, alpha: 1)

    @IBOutlet weak var camButton: UIButton!
    var cores: [UIColor] = []
    let test:APIHandler = APIHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        test.loadFactWithNumber(number: 18)
        //let logo = UIImageView(image: UIImage(named: "Rectangle"))
//        for family in UIFont.familyNames {
//
//            let sName: String = family as String
//            print("family: \(sName)")
//                    
//            for name in UIFont.fontNames(forFamilyName: sName) {
//                print("name: \(name as String)")
//           }
//        }
        
        let rectangle = UIImageView(image: UIImage(named: "WhiteRectangle"))
        rectangle.alpha = 1
        
//        let factOfSeries = UILabel()
//        factOfSeries.font = UIFont(name: "Superfruit", size: 25)
//        factOfSeries.text = "A frase 'We were on a break' foi dita 18 vezes na série Friends."
//        factOfSeries.numberOfLines = 0
//        factOfSeries.textColor = .black
//        factOfSeries.textAlignment = .centerw
        
//        let command = UILabel()
//        command.numberOfLines = 0
//        command.text = "Procure os cubos na cena para revelar as frases."
//        command.textColor = .black
//        command.font = UIFont(name: "Superfruit", size: 40)
//        command.textAlignment = .center
        
        let title = UIImageView(image: UIImage(named: "Finx"))
        title.layer.opacity = 1
        
       let imageConfig = UIImage.SymbolConfiguration(pointSize: 60)
        //camButton.setBackgroundImage(UIImage(named: "PinkRectangle"), for: .normal)
        //camButton.tintColor = .black
        
        camButton.layer.borderWidth = 1
        camButton.layer.borderColor = UIColor.white.cgColor
        camButton.layer.shadowColor = UIColor.black.cgColor
        camButton.layer.shadowOpacity = 0.5
        camButton.layer.shadowOffset = .zero
        camButton.layer.shadowRadius = 2
        camButton.backgroundColor = colorButton
        camButton.layer.cornerRadius = 10
        camButton.setTitle("Começar", for: .normal)
        camButton.setTitleColor(.black, for: .normal)
        camButton.titleLabel?.font = UIFont(name: "Superfruit", size:30)
        
        let instructionsButton = UIButton()
//        instructionsButton.backgroundColor = .clear
////        instructionsButton.setTitle("Instruções", for: .normal)
       // instructionsButton.setBackgroundImage(UIImage(named: "PinkRectangle"), for: .normal)
        //instructionsButton.tintColor = .white
////        instructionsButton.setTitleColor(.black, for: .normal)
////        instructionsButton.titleLabel?.font = .systemFont(ofSize: 13)
        instructionsButton.layer.cornerRadius = 10
        instructionsButton.layer.borderWidth = 1
        instructionsButton.layer.borderColor = UIColor.white.cgColor
        instructionsButton.layer.shadowColor = UIColor.black.cgColor
        instructionsButton.layer.shadowOpacity = 0.5
        instructionsButton.layer.shadowOffset = .zero
        instructionsButton.layer.shadowRadius = 2
        instructionsButton.backgroundColor = colorButton
        instructionsButton.layer.cornerRadius = 10
        instructionsButton.setTitle("Instruções", for: .normal)
        instructionsButton.setTitleColor(.black, for: .normal)
        instructionsButton.titleLabel?.font = UIFont(name: "Superfruit", size:30)
        instructionsButton.addTarget(self, action: #selector(instructionsButtonAction), for: .touchUpInside)
        
//        rectangle.addSubview(command)
        rectangle.addSubview(title)
//        rectangle.addSubview(factOfSeries)
        //rectangle.addSubview(camButton)
        
        
        self.view.addSubview(rectangle)
        self.view.addSubview(camButton)
        self.view.addSubview(instructionsButton)
        
        //logo.translatesAutoresizingMaskIntoConstraints = false
//        factOfSeries.translatesAutoresizingMaskIntoConstraints = false
//        command.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        rectangle.translatesAutoresizingMaskIntoConstraints = false
        camButton.translatesAutoresizingMaskIntoConstraints  = false
        instructionsButton.translatesAutoresizingMaskIntoConstraints = false
        
        
//        self.view.addConstraint(NSLayoutConstraint(item: logo, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 70))
//        logo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        logo.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        logo.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
//        self.view.addConstraint(NSLayoutConstraint(item: rectangle, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 200))
        rectangle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        rectangle.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        rectangle.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
        rectangle.heightAnchor.constraint(equalToConstant: 370).isActive = true
        
        
//        self.view.addConstraint(NSLayoutConstraint(item: factOfSeries, attribute: .top, relatedBy: .equal, toItem: rectangle, attribute: .top, multiplier: 1.0, constant: 20))
//        factOfSeries.centerXAnchor.constraint(equalTo: rectangle.centerXAnchor).isActive = true
//        factOfSeries.widthAnchor.constraint(equalToConstant: 250).isActive = true
//        factOfSeries.heightAnchor.constraint(equalToConstant: 100).isActive = true

//        command.topAnchor.constraint(equalTo: rectangle.topAnchor, constant: 30).isActive = true
//        command.centerXAnchor.constraint(equalTo: rectangle.centerXAnchor).isActive = true
//        command.widthAnchor.constraint(equalTo: rectangle.widthAnchor, multiplier: 0.9).isActive = true
//        command.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
//        camButton.topAnchor.constraint(equalTo: command.bottomAnchor, constant: 20).isActive = true
        
        title.topAnchor.constraint(equalTo: rectangle.topAnchor, constant: 30).isActive = true
       title.centerXAnchor.constraint(equalTo: rectangle.centerXAnchor).isActive = true
        title.widthAnchor.constraint(equalTo: rectangle.widthAnchor, multiplier: 0.9).isActive = true
        title.heightAnchor.constraint(equalToConstant: 90).isActive = true
                
                camButton.topAnchor.constraint(equalTo:title.bottomAnchor, constant: 20).isActive = true
        camButton.centerXAnchor.constraint(equalTo: rectangle.centerXAnchor).isActive = true
        camButton.widthAnchor.constraint(equalTo: rectangle.widthAnchor, multiplier: 0.8).isActive = true
        camButton.heightAnchor.constraint(equalToConstant: 69).isActive = true
        
        instructionsButton.topAnchor.constraint(equalTo: camButton.bottomAnchor, constant: 20).isActive = true
        instructionsButton.centerXAnchor.constraint(equalTo: rectangle.centerXAnchor).isActive = true
        instructionsButton.widthAnchor.constraint(equalTo: rectangle.widthAnchor, multiplier: 0.8).isActive = true
        instructionsButton.heightAnchor.constraint(equalToConstant: 69).isActive = true
        
    }
    
    @objc func instructionsButtonAction(sender: UIButton!) {
        
        print("Button tapped")
        performSegue(withIdentifier: "instructionsSegue", sender: self)

    }
}
