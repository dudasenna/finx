//
//  LevelsViewController.swift
//  AppSurdo
//
//  Created by Palloma Ramos on 06/04/21.
//  Copyright © 2021 Luis Pereira. All rights reserved.
//

import Foundation
import UIKit


var lifes = 3
var cubes_num = 3
let buttonEasy = UIButton()
let buttonMedium = UIButton()
let buttonHard = UIButton()
let labelNivel = UILabel()


class LevelsViewController: UIViewController {
    
    @IBOutlet weak var okLevelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        okLevelButton.isEnabled = false
        
        labelNivel.text = "Escolha um nível:"
        labelNivel.textColor = .white
        labelNivel.font = UIFont(name: "Raleway-Bold", size: 30)
        labelNivel.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2)
        labelNivel.textAlignment = .center
        
        
        buttonEasy.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3)
        buttonEasy.layer.cornerRadius = 10
        buttonEasy.setTitle("Fácil", for: .normal)
        buttonEasy.titleLabel?.font = UIFont(name: "Raleway-Bold" , size: 30)
        buttonEasy.setTitleColor(.white, for: .normal)
        buttonEasy.setTitleColor(.orange, for: .selected)
        buttonEasy.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        buttonEasy.layer.borderWidth = 1.0
        
        
        buttonMedium.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3)
        buttonMedium.layer.cornerRadius = 10
        buttonMedium.setTitle("Médio", for: .normal)
        buttonMedium.titleLabel?.font = UIFont(name: "Raleway-Bold" , size: 30)
        buttonMedium.setTitleColor(.white, for: .normal)
        buttonMedium.setTitleColor(.orange, for: .selected)
        buttonMedium.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        buttonMedium.layer.borderWidth = 1.0
        
        
        buttonHard.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3)
        buttonHard.layer.cornerRadius = 10
        buttonHard.setTitle("Dificil", for: .normal)
        buttonHard.titleLabel?.font = UIFont(name: "Raleway-Bold" , size: 30)
        buttonHard.setTitleColor(.white, for: .normal)
        buttonHard.setTitleColor(.orange, for: .selected)
        buttonHard.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        buttonHard.layer.borderWidth = 1.0
        //        buttonHard.frame = CGRect(x: 300, y: 100, width: 100, height: 100)
        
        buttonEasy.addTarget(self, action: #selector(buttonEasyAction), for: .touchUpInside)
        buttonMedium.addTarget(self, action: #selector(buttonMediumAction), for: .touchUpInside)
        buttonHard.addTarget(self, action: #selector(buttonHardAction), for: .touchUpInside)
        
        
        self.view.addSubview(labelNivel)
        self.view.addSubview(buttonEasy)
        self.view.addSubview(buttonMedium)
        self.view.addSubview(buttonHard)
        self.view.addSubview(okLevelButton)
        
        labelNivel.translatesAutoresizingMaskIntoConstraints = false
        buttonEasy.translatesAutoresizingMaskIntoConstraints = false
        buttonMedium.translatesAutoresizingMaskIntoConstraints = false
        buttonHard.translatesAutoresizingMaskIntoConstraints = false
        okLevelButton.translatesAutoresizingMaskIntoConstraints = false
        
        buttonMedium.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        buttonMedium.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        buttonMedium.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.35).isActive = true
        buttonMedium.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.12).isActive = true
        
       labelNivel.bottomAnchor.constraint(equalTo: buttonEasy.topAnchor, constant: -100).isActive = true
        labelNivel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        labelNivel.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 1).isActive = true
        labelNivel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        
        
        buttonEasy.bottomAnchor.constraint(equalTo: buttonMedium.bottomAnchor, constant: -120).isActive = true
        buttonEasy.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        buttonEasy.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.35).isActive = true
        buttonEasy.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.12).isActive = true
        
        
        buttonHard.topAnchor.constraint(equalTo: buttonMedium.topAnchor, constant: 120).isActive = true
        buttonHard.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        buttonHard.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.35).isActive = true
        buttonHard.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.12).isActive = true
        
        okLevelButton.topAnchor.constraint(equalTo: buttonHard.bottomAnchor, constant: 80).isActive = true
        okLevelButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        okLevelButton.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3).isActive = true
        okLevelButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
        
    }
    @objc func buttonEasyAction(sender: UIButton!) {
        lifes = 3
        cubes_num = 3
        
        if buttonEasy.isSelected {
                    // set deselected
            buttonEasy.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3)
            okLevelButton.isEnabled = false
            buttonEasy.isSelected = false
                } else {
                    // set selected
                    okLevelButton.isEnabled = true
                    buttonEasy.backgroundColor = .white
                    buttonMedium.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3)
                    buttonHard.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3)
                    buttonEasy.isSelected = true
                    buttonMedium.isSelected = false
                    buttonHard.isSelected = false
                }
        
    }
    @objc func buttonMediumAction(sender: UIButton!) {
        lifes = 3
        cubes_num = 5
        
        if buttonMedium.isSelected {
                    // set deselected
            buttonMedium.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3)
            okLevelButton.isEnabled = false
            buttonMedium.isSelected = false
                } else {
                    // set selected
                    okLevelButton.isEnabled = true
                    buttonMedium.backgroundColor = .white
                    buttonEasy.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3)
                    buttonHard.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3)
                    buttonEasy.isSelected = false
                    buttonMedium.isSelected = true
                    buttonHard.isSelected = false
                }
        
    }
    @objc func buttonHardAction(sender: UIButton!) {
        lifes = 3
        cubes_num = 7
        
        if buttonHard.isSelected {
                    // set deselected
            buttonHard.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3)
            okLevelButton.isEnabled = false
            buttonHard.isSelected = false
                } else {
                    // set selected
                    okLevelButton.isEnabled = true
                    buttonHard.backgroundColor = .white
                    buttonEasy.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3)
                    buttonMedium.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3)
                    buttonEasy.isSelected = false
                    buttonMedium.isSelected = false
                    buttonHard.isSelected = true
                }
    }
    
    
}

