//
//  Onboarding1.swift
//  AppSurdo
//
//  Created by Eduarda Senna on 16/03/21.
//  Copyright © 2021 Luis Pereira. All rights reserved.
//

import Foundation
import UIKit

class OnboardingInitial: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let background = UIImage(named: "NewBackground")
        var imageView : UIImageView!
        let labelWelcome = UILabel()
        let labelFinx = UILabel()
        let labelIntroText = UILabel()
        let buttonBegin = UIButton()
        
        //define background
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        
        //define label inicial
        labelWelcome.text = "Bem-vindo(a) ao"
        labelWelcome.textColor = .white
        labelWelcome.textAlignment = .center
        labelWelcome.font = UIFont(name: "Raleway-SemiBold", size: 35)
        labelWelcome.adjustsFontSizeToFitWidth = true
        
        //define label do nome finx
        labelFinx.text = "F i n x"
        labelFinx.textColor = .white
        labelFinx.textAlignment = .center
        labelFinx.font = UIFont(name: "RalewayDots-Regular", size: 105)
        labelFinx.adjustsFontSizeToFitWidth = true
        
        //define label do texto de introdução
        labelIntroText.text = "Vamos olhar algumas instruções para melhor aproveitamento do jogo"
        labelIntroText.textColor = .white
        labelIntroText.textAlignment = .center
        labelIntroText.font = UIFont(name: "Raleway-SemiBold", size: 20)
        labelIntroText.adjustsFontSizeToFitWidth = true
        labelIntroText.numberOfLines = 0
        
        //define botão de começar
        buttonBegin.backgroundColor = .white
        buttonBegin.setTitle("Começar", for: .normal)
        buttonBegin.titleLabel?.font = UIFont(name: "Raleway-SemiBold", size: 24)
        buttonBegin.titleLabel?.adjustsFontSizeToFitWidth = true
        buttonBegin.setTitleColor(UIColor(red: 237/257, green: 142/256, blue: 92/256, alpha: 1.0) , for: .normal)
        buttonBegin.layer.cornerRadius = 10
        buttonBegin.addTarget(self, action: #selector(buttonBeginAction), for: .touchUpInside)

        //adiciona subviews
        view.addSubview(imageView)
        self.view.addSubview(labelWelcome)
        self.view.addSubview(labelFinx)
        self.view.addSubview(labelIntroText)
        self.view.addSubview(buttonBegin)
        
        //define constraints
        labelWelcome.translatesAutoresizingMaskIntoConstraints = false
        labelFinx.translatesAutoresizingMaskIntoConstraints = false
        labelIntroText.translatesAutoresizingMaskIntoConstraints = false
        buttonBegin.translatesAutoresizingMaskIntoConstraints = false
        
        labelWelcome.topAnchor.constraint(equalToSystemSpacingBelow: self.view.safeAreaLayoutGuide.topAnchor, multiplier: 0.5).isActive = true
        labelWelcome.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        labelWelcome.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        labelWelcome.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7).isActive = true
        labelWelcome.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
        
        labelFinx.topAnchor.constraint(equalToSystemSpacingBelow: labelWelcome.topAnchor, multiplier: 12).isActive = true
        labelFinx.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        labelFinx.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7).isActive = true
        labelFinx.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
        
        buttonBegin.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -70).isActive = true
        buttonBegin.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        labelWelcome.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        buttonBegin.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5).isActive = true
        buttonBegin.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.07).isActive = true
        
        labelIntroText.bottomAnchor.constraint(equalToSystemSpacingBelow: buttonBegin.topAnchor, multiplier: 2).isActive = true
        labelIntroText.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        labelIntroText.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7).isActive = true
        labelIntroText.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
        
        
    }
    
    @objc func buttonBeginAction(sender: UIButton!) {
      print("Button tapped")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
