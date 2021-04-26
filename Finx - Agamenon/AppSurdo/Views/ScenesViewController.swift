//
//  SceneViewController.swift
//  AppSurdo
//
//  Created by Jéssica Amaral on 21/04/21.
//  Copyright © 2021 Luis Pereira. All rights reserved.
//

import Foundation
import UIKit

class PageControlScenesViewController:  UIPageViewController {
    var pageDots = UIPageControl()
    var pageControl = UIPageViewController()
    var pageViews: [UIViewController] = []
    
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
        
        pageControl = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageControl.dataSource = self
        pageControl.delegate = self
        pageControl.view.backgroundColor = .clear
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let pageOne = storyBoard.instantiateViewController(identifier: "PageOneViewController")
        
        let pageTwo = storyBoard.instantiateViewController(identifier: "PageTwoViewController")
        
        let pageThree = storyBoard.instantiateViewController(identifier: "PageThreeViewController")
        
        pageViews = [pageOne, pageTwo, pageThree]
        
        pageDots.numberOfPages = pageViews.count
        pageDots.hidesForSinglePage = true
        pageDots.currentPageIndicatorTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        pageDots.pageIndicatorTintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        self.addChild(pageControl)
        
        setupSubviews()
        
        if let initialView = pageViews.first {
            self.pageControl.setViewControllers([initialView], direction: .forward, animated: true, completion: nil)
            
        }
        self.pageControl.didMove(toParent: self)
    }
    
    private func setupSubviews() {
        view.addSubview(pageControl.view)
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        view.addSubview(pageDots)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        pageDots.translatesAutoresizingMaskIntoConstraints = false
        
        closeButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        closeButton.topAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        
        pageControl.view.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        pageControl.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        pageControl.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        pageControl.view.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        pageDots.centerXAnchor.constraint (equalTo: pageControl.view.centerXAnchor).isActive = true
        pageDots.bottomAnchor.constraint(equalTo: pageControl.view.bottomAnchor, constant: -30).isActive = true
        pageDots.topAnchor.constraint(equalTo: pageControl.view.bottomAnchor, constant: -60).isActive = true
        pageDots.widthAnchor.constraint(equalTo: pageControl.view.widthAnchor).isActive = true
    }
    
    @IBAction func dismissView(_ sender:UIButton) {
        self.dismiss(animated: true, completion:nil)
    }
}

class FirstScenesViewController: UIViewController {
    @IBOutlet weak var underwaterButton: UIButton!
    @IBOutlet weak var ufoButton: UIButton!
    override func viewWillLayoutSubviews() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleHeight = (self.view.frame.height * 0.1) + 60
        
        underwaterButton.contentMode = .scaleToFill
        
        self.view.addSubview(underwaterButton)
        self.view.addSubview(ufoButton)
        
        underwaterButton.translatesAutoresizingMaskIntoConstraints = false
        ufoButton.translatesAutoresizingMaskIntoConstraints = false
        
        underwaterButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        underwaterButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (titleHeight+30)).isActive = true
        underwaterButton.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        underwaterButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3).isActive = true
        
        ufoButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        ufoButton.topAnchor.constraint(equalTo: underwaterButton.bottomAnchor, constant: 20).isActive = true
        ufoButton.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        ufoButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    override func prepare (for segue: UIStoryboardSegue, sender:Any?) {
        let vc = segue.destination as? LoadViewController
        if segue.identifier == "underwaterSegue" {
            vc?.scene = "underwater"
        }
        
        if segue.identifier == "ufoSegue" {
            vc?.scene = "ufo"
        }
    }
    
}

class SecondScenesViewController: UIViewController {
    @IBOutlet weak var pirateButton: UIButton!
    @IBOutlet weak var forestButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleHeight = (self.view.frame.height * 0.1) + 60
        
        pirateButton.translatesAutoresizingMaskIntoConstraints = false
        forestButton.translatesAutoresizingMaskIntoConstraints = false
        
        pirateButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        pirateButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (titleHeight+30)).isActive = true
        pirateButton.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        pirateButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3).isActive = true
        
        forestButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        forestButton.topAnchor.constraint(equalTo: pirateButton.bottomAnchor, constant: 20).isActive = true
        forestButton.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        forestButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    override func prepare (for segue: UIStoryboardSegue, sender:Any?) {
        let vc = segue.destination as? LoadViewController
        
        if segue.identifier == "pirateSegue" {
            vc?.scene = "pirate"
        }
        
        if segue.identifier == "forestSegue" {
            vc?.scene = "forest"
        }
    }
}

class ThirdScenesViewController: UIViewController {
    @IBOutlet weak var kitchenButton: UIButton!
    @IBOutlet weak var tabernButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleHeight = (self.view.frame.height * 0.1) + 60
        
        kitchenButton.translatesAutoresizingMaskIntoConstraints = false
        tabernButton.translatesAutoresizingMaskIntoConstraints = false
        
        kitchenButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        kitchenButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (titleHeight+30)).isActive = true
        kitchenButton.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        kitchenButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3).isActive = true
        
        tabernButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        tabernButton.topAnchor.constraint(equalTo: kitchenButton.bottomAnchor, constant: 20).isActive = true
        tabernButton.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        tabernButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    override func prepare (for segue: UIStoryboardSegue, sender:Any?) {
        let vc = segue.destination as? LoadViewController
        
        if segue.identifier == "kitchenSegue" {
            vc?.scene = "kitchen"
        }
        
        if segue.identifier == "tabernSegue" {
            vc?.scene = "tabern"
        }
    }
}
