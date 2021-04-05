//
//  factsViewController.swift
//  AppSurdo
//
//  Created by Jéssica Amaral on 29/03/21.
//  Copyright © 2021 Luis Pereira. All rights reserved.
//

import Foundation
import UIKit

class FactsViewController : UIViewController {
    var factsOfNumbers: [(String, String)]!
    
    var colorTitle = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2)
    var colorCard1 = #colorLiteral(red: 1, green: 0.4549019608, blue: 0.4549019608, alpha: 0.8)
    var colorCard2 = #colorLiteral(red: 1, green: 0.4980392157, blue: 0.3882352941, alpha: 0.8)
    var colorCard3 = #colorLiteral(red: 1, green: 0.6117647059, blue: 0.3921568627, alpha: 0.8)
    var colorTextButton = UIColor(red: 237/255, green: 142/255, blue: 92/255, alpha: 1.0)
    
    let titleSpace = UILabel()
    let cardSpace1 = UILabel()
    let cardSpace2 = UILabel()
    let cardSpace3 = UILabel()
    
    let backgroundCard1 = UILabel()
    let backgroundCard2 = UILabel()
    let backgroundCard3 = UILabel()
    
    @IBOutlet weak var doneButton: UIButton!
    let closeButton = UIButton()
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        setupScrollView()
        
        titleSpace.text = "Aqui estão as frases que você encontrou!"
        titleSpace.textColor = .white
        titleSpace.textAlignment = .center
        titleSpace.backgroundColor = colorTitle
        titleSpace.layer.masksToBounds = true
        titleSpace.numberOfLines = 0
        titleSpace.font = UIFont(name: "Raleway-Bold", size:30)
        
        backgroundCard1.backgroundColor = colorCard1
        backgroundCard1.layer.cornerRadius = 20
        backgroundCard1.layer.masksToBounds = true
        backgroundCard1.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        backgroundCard1.layer.borderWidth = 1.0
        
        backgroundCard2.backgroundColor = colorCard2
        backgroundCard2.layer.cornerRadius = 20
        backgroundCard2.layer.masksToBounds = true
        backgroundCard2.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        backgroundCard2.layer.borderWidth = 1.0
        
        backgroundCard3.backgroundColor = colorCard3
        backgroundCard3.layer.cornerRadius = 20
        backgroundCard3.layer.masksToBounds = true
        backgroundCard3.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        backgroundCard3.layer.borderWidth = 1.0
        
        cardSpace1.text = factsOfNumbers[0].1
        cardSpace1.textColor = .white
        cardSpace1.textAlignment = .center
        cardSpace1.layer.masksToBounds = true
        cardSpace1.numberOfLines = 0
        cardSpace1.font = UIFont(name: "Raleway-Bold", size:23)
        cardSpace1.adjustsFontSizeToFitWidth = true
        
        cardSpace2.text = factsOfNumbers[1].1
        cardSpace2.textColor = .white
        cardSpace2.textAlignment = .center
        cardSpace2.layer.masksToBounds = true
        cardSpace2.numberOfLines = 0
        cardSpace2.font = UIFont(name: "Raleway-Bold", size:23)
        cardSpace2.adjustsFontSizeToFitWidth = true
        
        cardSpace3.text = factsOfNumbers[2].1
        cardSpace3.textColor = .white
        cardSpace3.textAlignment = .center
        cardSpace3.layer.masksToBounds = true
        cardSpace3.numberOfLines = 0
        cardSpace3.font = UIFont(name: "Raleway-Bold", size:23)
        cardSpace3.adjustsFontSizeToFitWidth = true
        
        doneButton.setTitle("OK", for: .normal)
        doneButton.titleLabel?.font = UIFont(name: "Raleway-SemiBold", size: 20)
        doneButton.titleLabel?.adjustsFontSizeToFitWidth = true
        doneButton.titleLabel?.adjustsFontForContentSizeCategory = true
        doneButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        closeButton.backgroundColor = .white
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .black
        closeButton.layer.cornerRadius = 10
        closeButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        setupSubviews()
    }
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -40).isActive = true
    }
    
    func setupSubviews() {
        scrollView.addSubview(doneButton)
        scrollView.addSubview(closeButton)
        
        contentView.addSubview(titleSpace)
        contentView.addSubview(backgroundCard1)
        contentView.addSubview(backgroundCard2)
        contentView.addSubview(backgroundCard3)
        contentView.addSubview(cardSpace1)
        contentView.addSubview(cardSpace2)
        contentView.addSubview(cardSpace3)
        
        titleSpace.translatesAutoresizingMaskIntoConstraints = false
        backgroundCard1.translatesAutoresizingMaskIntoConstraints = false
        backgroundCard2.translatesAutoresizingMaskIntoConstraints = false
        backgroundCard3.translatesAutoresizingMaskIntoConstraints = false
        cardSpace1.translatesAutoresizingMaskIntoConstraints = false
        cardSpace2.translatesAutoresizingMaskIntoConstraints = false
        cardSpace3.translatesAutoresizingMaskIntoConstraints = false
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        closeButton.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        closeButton.topAnchor.constraint(equalTo:scrollView.topAnchor, constant: 20).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        titleSpace.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 10).isActive = true
        titleSpace.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        titleSpace.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.15).isActive = true
        titleSpace.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1).isActive = true
        
        backgroundCard1.topAnchor.constraint(equalTo: titleSpace.bottomAnchor, constant: 35).isActive = true
        backgroundCard1.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        backgroundCard1.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25).isActive = true
        backgroundCard1.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
        
        cardSpace1.centerYAnchor.constraint(equalTo: backgroundCard1.centerYAnchor).isActive = true
        cardSpace1.centerXAnchor.constraint(equalTo: backgroundCard1.centerXAnchor).isActive = true
        cardSpace1.widthAnchor.constraint(equalTo: backgroundCard1.widthAnchor, multiplier: 0.9).isActive = true
//        cardSpace1.bottomAnchor.constraint(equalTo: backgroundCard1.bottomAnchor, constant: -5).isActive = true
        
        backgroundCard2.topAnchor.constraint(equalTo: backgroundCard1.bottomAnchor, constant: 20).isActive = true
        backgroundCard2.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        backgroundCard2.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25).isActive = true
        backgroundCard2.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
        
        cardSpace2.centerYAnchor.constraint(equalTo: backgroundCard2.centerYAnchor).isActive = true
        cardSpace2.centerXAnchor.constraint(equalTo: backgroundCard2.centerXAnchor).isActive = true
        cardSpace2.widthAnchor.constraint(equalTo: backgroundCard1.widthAnchor, multiplier: 0.9).isActive = true
        //cardSpace2.bottomAnchor.constraint(equalTo: backgroundCard2.bottomAnchor, constant: -5).isActive = true
        
        backgroundCard3.topAnchor.constraint(equalTo: backgroundCard2.bottomAnchor, constant: 20).isActive = true
        backgroundCard3.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        backgroundCard3.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25).isActive = true
        backgroundCard3.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
        
        cardSpace3.centerYAnchor.constraint(equalTo: backgroundCard3.centerYAnchor).isActive = true
        cardSpace3.centerXAnchor.constraint(equalTo: backgroundCard3.centerXAnchor).isActive = true
        cardSpace3.widthAnchor.constraint(equalTo: backgroundCard1.widthAnchor, multiplier: 0.9).isActive = true
//        cardSpace3.bottomAnchor.constraint(equalTo: backgroundCard3.bottomAnchor, constant: -5).isActive = true
        
        doneButton.topAnchor.constraint(equalTo: backgroundCard3.bottomAnchor, constant: 40).isActive = true
        doneButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        doneButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    @IBAction func dismissView(_ sender:UIButton) {
        self.dismiss(animated: true, completion:nil)
    }
}
