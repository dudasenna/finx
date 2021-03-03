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
        
        let closeButton = UIButton()
        closeButton.backgroundColor = .white
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
//        closeButton.setTitle("Fechar", for: .normal)
//        closeButton.setTitleColor(.black, for: .normal)
//        closeButton.titleLabel?.font = .systemFont(ofSize: 13)
        closeButton.tintColor = .black
        closeButton.layer.cornerRadius = 10
        closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        
        let rectangle = UIImageView(image: UIImage(named: "WhiteRectangle"))
        rectangle.alpha = 0.9
        
        let instructionsLabel = UILabel()
        instructionsLabel.font = UIFont(name: "Superfruit", size: 25)
        instructionsLabel.text = "Para carregar esse mapa, inicie o jogo e aponte seu celular para uma superfície, até que se formem vários pontos, então dê um toque na tela. Ao terminar o carregamento, estarão escondidos três cubos que você deve procurar no cenário do jogo e clicar para captura-los. Os cubos que você acabou de achar representam um valor numérico surpresa! Na próxima fase, estarão escritos alguns fatos aleatórios, e cada um precisa de um número para ser completado. Relacione os números encontrados aos fatos, utilizando seus conhecimentos aleatórios e sua sorte!"
        instructionsLabel.numberOfLines = 0
        instructionsLabel.textColor = .black
        instructionsLabel.textAlignment = .center
        instructionsLabel.adjustsFontSizeToFitWidth = true
        
        rectangle.addSubview(instructionsLabel)
        
        self.view.addSubview(rectangle)
        self.view.addSubview(closeButton)
        
        instructionsLabel.translatesAutoresizingMaskIntoConstraints  = false
        rectangle.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        rectangle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        rectangle.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        rectangle.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
        rectangle.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.7).isActive = true
        
        instructionsLabel.centerXAnchor.constraint(equalTo: rectangle.centerXAnchor).isActive = true
        instructionsLabel.centerYAnchor.constraint(equalTo: rectangle.centerYAnchor).isActive = true
        instructionsLabel.widthAnchor.constraint(equalTo: rectangle.widthAnchor, multiplier: 0.9).isActive = true
        instructionsLabel.heightAnchor.constraint(equalTo: rectangle.heightAnchor, multiplier: 0.9).isActive = true
        
        closeButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        closeButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
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
