//
//  OnboardingScreens.swift
//  AppSurdo
//
//  Created by Eduarda Senna on 17/03/21.
//  Copyright © 2021 Luis Pereira. All rights reserved.
//

import Foundation
import UIKit

class OnboardingScreens: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var jumpButtonSB: UIButton!
    let textsArray = ["Inicie o jogo e aponte seu celular para uma superfície até que se formem vários pontos", "Toque na tela para carregar a cena", "Procure os três cubos escondidos no cenário e clique neles para capturá-los", "Cada cubo encontrado representa um valor numérico surpresa", "Utilizando seus conhecimentos ou sua sorte, relacione o fato aleatório a um número", "Ao acertar o número correto, pode voltar à cena e procurar outro cubo!"]
    
    private var scrollView = UIScrollView(frame: .zero)
    private var stackView = UIStackView(frame: .zero)
    private var views:[UIView] = []
    var pageControl = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        
        jumpButtonSB.backgroundColor = .init(white: 1.0, alpha: 0.8)
        jumpButtonSB.setTitle("Pular", for: .normal)
        jumpButtonSB.titleLabel?.font = UIFont(name: "Raleway-SemiBold", size: 18)
        jumpButtonSB.titleLabel?.adjustsFontSizeToFitWidth = true
        jumpButtonSB.setTitleColor(UIColor(red: 237/257, green: 142/256, blue: 92/256, alpha: 1.0) , for: .normal)
        jumpButtonSB.layer.cornerRadius = 10
        
        // *** SETUP SCROLLVIEW *** //
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
//        stackView.spacing = 20
        
        scrollView.addSubview(stackView)
        
        // *** SETUP STACKVIEW AND ADD SUBVIEWS *** //
        self.view.addSubview(scrollView)
        self.view.addSubview(jumpButtonSB)
        NSLayoutConstraint.activate([
          scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
          scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
          scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
          scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
          stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
          stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
          stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
          stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])
        
        jumpButtonSB.translatesAutoresizingMaskIntoConstraints = false
        
        jumpButtonSB.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        jumpButtonSB.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
//        jumpButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        jumpButtonSB.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.2).isActive = true
        jumpButtonSB.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.05).isActive = true

        // Initializing the views we'll put in the scrollView and adding them to an array for convenience
        let pageView1 = PageView(textLabelText: textsArray[0], backgroundImageName: UIImage(named: "Rectangle1")!, iconImageName: UIImage(named: "Group 21")!)
        views.append(pageView1)
        let pageView2 = PageView(textLabelText: textsArray[1], backgroundImageName: UIImage(named: "Rectangle2")!, iconImageName: UIImage(named: "Group 24")!)
        views.append(pageView2)
        let pageView3 = PageView(textLabelText: textsArray[2], backgroundImageName: UIImage(named: "Rectangle3")!, iconImageName: UIImage(named: "Group 25")!)
        views.append(pageView3)
        let pageView4 = PageView(textLabelText: textsArray[3], backgroundImageName: UIImage(named: "Rectangle4")!, iconImageName: UIImage(named: "Group 23")!)
        views.append(pageView4)
        let pageView5 = PageView(textLabelText: textsArray[4], backgroundImageName: UIImage(named: "Rectangle5")!, iconImageName: UIImage(named: "Frase1")!)
        views.append(pageView5)
        let pageView6 = PageView(textLabelText: textsArray[5], backgroundImageName: UIImage(named: "Rectangle6")!, iconImageName: UIImage(named: "Frase2")!)
        views.append(pageView6)
        
        views.forEach { (view) in
            stackView.addArrangedSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
            view.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        }

        // *** ADD PAGECONTROLL *** //
        pageControl.numberOfPages = views.count
//        pageControl.colo = UIColor(red: 237/257, green: 142/256, blue: 92/256, alpha: 1.0)
        pageControl.addTarget(self, action: #selector(pageControlTapped(sender:)), for: .valueChanged)
        pageControl.pageIndicatorTintColor = UIColor(red: 237/257, green: 142/256, blue: 92/256, alpha: 0.5)
        pageControl.currentPageIndicatorTintColor = UIColor(red: 237/257, green: 142/256, blue: 92/256, alpha: 1.0)
        
        self.view.addSubview(pageControl)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        
    }
    
    @objc func pageControlTapped(sender: UIPageControl) {
        let pageWidth = scrollView.bounds.width
        let offset = sender.currentPage * Int(pageWidth)
        UIView.animate(withDuration: 0.33, animations: { [weak self] in
          self?.scrollView.contentOffset.x = CGFloat(offset)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      let pageWidth = scrollView.bounds.width
      let pageFraction = scrollView.contentOffset.x/pageWidth

      pageControl.currentPage = Int((round(pageFraction)))
    }

}
