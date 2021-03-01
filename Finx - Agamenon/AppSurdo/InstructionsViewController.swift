//
//  InstructionsViewController.swift
//  AppSurdo
//
//  Created by Eduarda Senna on 01/03/21.
//  Copyright © 2021 Luis Pereira. All rights reserved.
//

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
        closeButton.layer.cornerRadius = 10
        closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
                
        view.addSubview(closeButton)
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
