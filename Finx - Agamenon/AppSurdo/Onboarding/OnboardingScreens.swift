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
    
//    let currentPage = 0
    let textsArray = ["Inicie o jogo e aponte seu celular para uma superfície até que se formem vários pontos", "Toque na tela para carregar a cena", "Procure os três cubos escondidos no cenário e clique neles para capturá-los", "Cada cubo encontrado representa um valor numérico surpresa", "Utilizando seus conhecimentos ou sua sorte, relacione o fato aleatório a um número", "Ao acertar o número correto, pode voltar à cena e procurar outro cubo!"]
//    let iconsArray: [UIImage] = []
//    ["Group 21", "Group 24", "Group 25", "Group 23", "Frase1", "Frase2"]
//    let backgroundsArray = ["Rectangle1", "Rectangle2", "Rectangle3", "Rectangle4", "Rectangle5", "Rectangle6"]
    
    private var scrollView = UIScrollView(frame: .zero)
    private var stackView = UIStackView(frame: .zero)
    private var views:[UIView] = []
    var pageControl = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
                
//        let background = UIImage(named: backgroundsArray[1])
//        var bgImageView : UIImageView!
//        let labelText = UILabel()
//        let buttonBegin = UIButton()
        
    }
    
    private func setup() {
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
        self.view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalToSystemSpacingBelow: scrollView.bottomAnchor, multiplier: 0.1).isActive = true
        pageControl.numberOfPages = views.count
        pageControl.addTarget(self, action: #selector(pageControlTapped(sender:)), for: .valueChanged)
        
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension OnboardingScreens: UIScrollViewDelegate {
//  func scrollViewDidScroll(_ scrollView: UIScrollView) {
//    let pageWidth = scrollView.bounds.width
//    let pageFraction = scrollView.contentOffset.x/pageWidth
//
//    pageControl.currentPage = Int((round(pageFraction)))
//  }
//}
