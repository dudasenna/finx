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
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "NewBackground.png")!)
        let background = UIImage(named: "NewBackground")
        let labelWelcome = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        
        //define background
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        
        //define label inicial
//        labelWelcome.center = CGPoint(x: 160, y: 285)
        labelWelcome.text = "Bem-vindo(a) ao"
        labelWelcome.textColor = .white
        labelWelcome.textAlignment = .center
        labelWelcome.font = UIFont(name: "Raleway", size:50)
        labelWelcome.adjustsFontSizeToFitWidth = true

        //adiciona subviews
        view.addSubview(imageView)
        self.view.addSubview(labelWelcome)
        
        //define constraints
        labelWelcome.translatesAutoresizingMaskIntoConstraints = false
        
        labelWelcome.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        labelWelcome.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        labelWelcome.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        labelWelcome.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
        labelWelcome.heightAnchor.constraint(equalToConstant: 200).isActive = true
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
