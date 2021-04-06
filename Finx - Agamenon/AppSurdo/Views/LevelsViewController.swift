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


class LevelsViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let buttonEasy = UIButton()
        
        buttonEasy.backgroundColor = .white
        buttonEasy.layer.cornerRadius = 10
        buttonEasy.setTitle("Fácil", for: .normal)
        buttonEasy.titleLabel?.font = UIFont(name: "Raleway-Bold" , size: 25)
        buttonEasy.setTitleColor(.black, for: .normal)
        buttonEasy.setTitleColor(.blue, for: .selected)
        
        //        buttonEasy.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        
//        let buttonMedium = UIButton()
        
        buttonMedium.backgroundColor = .white
        buttonMedium.layer.cornerRadius = 10
        buttonMedium.setTitle("Médio", for: .normal)
        buttonMedium.titleLabel?.font = UIFont(name: "Raleway-Bold" , size: 25)
        buttonMedium.setTitleColor(.black, for: .normal)
        buttonMedium.setTitleColor(.blue, for: .selected)
        
        //        buttonMedium.frame = CGRect(x: 200, y: 100, width: 100, height: 100)
        
//        let buttonHard = UIButton()
        
        buttonHard.backgroundColor = .white
        buttonHard.layer.cornerRadius = 10
        buttonHard.setTitle("Dificil", for: .normal)
        buttonHard.titleLabel?.font = UIFont(name: "Raleway-Bold" , size: 25)
        buttonHard.setTitleColor(.black, for: .normal)
        buttonHard.setTitleColor(.blue, for: .selected)
        //        buttonHard.frame = CGRect(x: 300, y: 100, width: 100, height: 100)
        
        buttonEasy.addTarget(self, action: #selector(buttonEasyAction), for: .touchUpInside)
        buttonMedium.addTarget(self, action: #selector(buttonMediumAction), for: .touchUpInside)
        buttonHard.addTarget(self, action: #selector(buttonHardAction), for: .touchUpInside)
        
        
        self.view.addSubview(buttonEasy)
        self.view.addSubview(buttonMedium)
        self.view.addSubview(buttonHard)
        
        buttonEasy.translatesAutoresizingMaskIntoConstraints = false
        buttonMedium.translatesAutoresizingMaskIntoConstraints = false
        buttonHard.translatesAutoresizingMaskIntoConstraints = false
        
        buttonMedium.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        buttonMedium.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        buttonMedium.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3).isActive = true
        buttonMedium.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        
        
        buttonEasy.bottomAnchor.constraint(equalTo: buttonMedium.bottomAnchor, constant: -100).isActive = true
        buttonEasy.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        buttonEasy.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3).isActive = true
        buttonEasy.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        
        
        buttonHard.topAnchor.constraint(equalTo: buttonMedium.topAnchor, constant: 100).isActive = true
        buttonHard.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        buttonHard.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3).isActive = true
        buttonHard.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        
    }
    @objc func buttonEasyAction(sender: UIButton!) {
        lifes = 3
        cubes_num = 3
        
        if buttonEasy.isSelected {
                    // set deselected
            buttonEasy.isSelected = false
                } else {
                    // set selected
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
            buttonMedium.isSelected = false
                } else {
                    // set selected
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
            buttonHard.isSelected = false
                } else {
                    // set selected
                    buttonEasy.isSelected = false
                    buttonMedium.isSelected = false
                    buttonHard.isSelected = true
                }
    }
    
    
}

