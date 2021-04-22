//
//  SceneViewController.swift
//  AppSurdo
//
//  Created by Jéssica Amaral on 21/04/21.
//  Copyright © 2021 Luis Pereira. All rights reserved.
//

import Foundation
import UIKit

class PageControlScenesViewController:  UIViewController {
    private var pageControl: UIPageViewController?
    
    let titleLabel = UILabel()
    
    let closeButton = UIButton()
    
    var colorTitle = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "Escolha um cenário!"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = colorTitle
        titleLabel.layer.masksToBounds = true
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: "Raleway-Bold", size:30)
        
        closeButton.backgroundColor = .white
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .black
        closeButton.layer.cornerRadius = 10
        closeButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        pageControl = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
        pageControl?.dataSource = self
        pageControl?.delegate = self
        pageControl?.view.backgroundColor = .clear
        
        self.addChild(pageControl!)
        
        setupSubviews()
        
        pageControl?.setViewControllers([FirstScenesViewController()], direction: .forward, animated: true, completion: nil)
        pageControl?.didMove(toParent: self)
    }
    
    private func setupSubviews() {
        view.addSubview(pageControl!.view)
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        closeButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        closeButton.topAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        
        pageControl?.view.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        pageControl?.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        pageControl?.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        pageControl?.view.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    
    @IBAction func dismissView(_ sender:UIButton) {
        self.dismiss(animated: true, completion:nil)
    }
}

class FirstScenesViewController: UIViewController {
    let underwaterButton = UIButton()
    let ufoButton = UIButton()
    let pirateButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class SecondScenesViewController: UIViewController {
    let forestButton = UIButton()
    let kitchenButton = UIButton()
    let tabernButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
