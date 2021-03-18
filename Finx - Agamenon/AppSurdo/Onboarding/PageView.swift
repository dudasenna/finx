//
//  PageView.swift
//  AppSurdo
//
//  Created by Eduarda Senna on 17/03/21.
//  Copyright © 2021 Luis Pereira. All rights reserved.
//

import Foundation
import UIKit

class PageView: UIView {
  
    // Private so that it can only be modified from within the class
    private var textLabel = UILabel()
    // When this property is set it will update the headerTextField text
    var textLabelText: String = "" {
        didSet {
            textLabel.text = textLabelText
        }
    }
    
    private var backgroundImage = UIImageView()
    // When this property is set it will update the headerTextField text
    var backgroundImageName: UIImage = UIImage(named: "Rectangle1")! {
        didSet {
            backgroundImage.image = backgroundImageName
        }
    }
    
    private var iconImage = UIImageView()
    // When this property is set it will update the headerTextField text
    var iconImageName: UIImage  = UIImage(named: "Group 21")! {
        didSet {
            iconImage.image = iconImageName
        }
    }

    // Designated Init method
    init(textLabelText: String, backgroundImageName: UIImage, iconImageName: UIImage) {
        self.textLabel.text = textLabelText
        self.backgroundImage.image = backgroundImageName
        self.iconImage.image = iconImageName
        super.init(frame: .zero)
        self.backgroundColor = .white
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        
        if UserDefaults.standard.bool(forKey: "isOnboardingDone") == true {
             //Skip onboarding
        } else {
             //Show onboarding screens
             UserDefaults.standard.set(true, forKey: "isOnboardingDone")
        }
        
        //define label do texto de introdução
        textLabel.isUserInteractionEnabled = false
        backgroundImage.isUserInteractionEnabled = false
        iconImage.isUserInteractionEnabled = false
        
        textLabel.textColor = .black
        textLabel.textAlignment = .center
        textLabel.font = UIFont(name: "Raleway-SemiBold", size: 18)
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.numberOfLines = 0
//        textLabel.sizeToFit()
        
        //define background
        backgroundImage.center = center
        backgroundImage.clipsToBounds = true
        
        //adiciona subviews
        self.addSubview(backgroundImage)
        self.addSubview(textLabel)
        self.addSubview(iconImage)
        
        //define constraints
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        backgroundImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        backgroundImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6).isActive = true
        
        textLabel.topAnchor.constraint(equalToSystemSpacingBelow: backgroundImage.bottomAnchor, multiplier: 0.5).isActive = true
        textLabel.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor).isActive = true
        textLabel.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7).isActive = true
        textLabel.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
        
        iconImage.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor).isActive = true
        iconImage.centerYAnchor.constraint(equalTo: backgroundImage.centerYAnchor).isActive = true
        
    }
    
    @objc func buttonBeginAction(sender: UIButton!) {
      print("Button tapped")
    }
  
}
