//
//  InstructionsViewController.swift
//  AppSurdo
//
//  Created by Eduarda Senna on 01/03/21.
//  Copyright © 2021 Luis Pereira. All rights reserved.
//

import Foundation
import UIKit

class InstructionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let closeButton = UIButton(frame: CGRect(x: 350, y: 40, width: 30, height: 30))
        closeButton.backgroundColor = .white
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
//        closeButton.setTitle("Fechar", for: .normal)
//        closeButton.setTitleColor(.black, for: .normal)
//        closeButton.titleLabel?.font = .systemFont(ofSize: 13)
        closeButton.tintColor = .black
        closeButton.layer.cornerRadius = 10
        closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        
        var rectangle = UIImageView(image: UIImage(named: "WhiteRectangle"))
        
        let instructionsLabel = UILabel(frame: CGRect(x: 15, y: 10, width: 300, height: 500))
        instructionsLabel.font = UIFont(name: "Superfruit", size: 25)
        instructionsLabel.text = "Para carregar esse mapa, inicie o jogo e aponte seu celular para uma superfície, até que se formem vários pontos, então dê um toque na tela. Ao terminar o carregamento, estarão escondidos três cubos que você deve procurar no cenário do jogo e clicar para captura-los. Os cubos que você acabou de achar representam um valor numérico surpresa! Na próxima fase, estarão escritos alguns fatos aleatórios, e cada um precisa de um número para ser completado. Relacione os números encontrados aos fatos, utilizando seus conhecimentos aleatórios e sua sorte!"
        instructionsLabel.numberOfLines = 0
        instructionsLabel.textColor = .black
        instructionsLabel.textAlignment = .center
        
//        instructionsLabel.translatesAutoresizingMaskIntoConstraints  = false
//        rectangle.translatesAutoresizingMaskIntoConstraints = false
        
//        self.view.addConstraint(NSLayoutConstraint(item: rectangle, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 200))
//        rectangle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
////         rectangle.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
//        //rectangle.widthAnchor.constraint(equalToConstant: self.view.frame.width*0.8).isActive = true
//        rectangle.heightAnchor.constraint(equalToConstant: 370).isActive = true
        
//        self.view.addConstraint(NSLayoutConstraint(item: instructionsLabel, attribute: .top, relatedBy: .equal, toItem: rectangle, attribute: .top, multiplier: 1.0, constant: 20))
//        instructionsLabel.centerXAnchor.constraint(equalTo: rectangle.centerXAnchor).isActive = true
//        instructionsLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
//        instructionsLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        rectangle.addSubview(instructionsLabel)
        
        self.view.addSubview(rectangle)
        self.view.addSubview(closeButton)
    }
    
    @objc func closeButtonAction(sender: UIButton!) {
        
        dismiss(animated: true, completion: nil)

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
