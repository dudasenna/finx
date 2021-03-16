//  EquationViewController.swift
//  AppSurdo
//
//  Created by Luis Pereira on 31/08/20.
//  Copyright © 2020 Luis Pereira. All rights reserved.
//

import Foundation
import  UIKit

class EquationViewController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var colorTitle = #colorLiteral(red: 0.9089190364, green: 0.9262141585, blue: 0.9122079015, alpha: 0.3)
    var colorCard1 = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 0.8)
    var colorCard2 = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 0.8)
    var colorCard3 = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 0.8)
    var colorButton = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 0.8)
    var colorTextButton = UIColor(red: 237/255, green: 142/255, blue: 92/255, alpha: 1.0)
    
    var correct = false
    var factsOfNumbers: [(String, String)]!
//        = [("42","42 é o resultado dado pelos mecanismos de busca da web Google, Wolfram Alpha e Bing quando a consulta 'a resposta à vida do universo e tudo' é inserida como uma pesquisa."),("50", "50 é o limite de velocidade, em quilômetros por hora, de estradas australianas com limites não especificados."),("58", "58 é o número de condados na Califórnia.")]
    @IBOutlet weak var popImageview: UIImageView!
    @IBOutlet weak var popLabel: UILabel!
    @IBOutlet weak var popBtm: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    //    var cardSpace1,cardSpace2, cardSpace3: UILabel!
    var selectedCard1: String?
    var selectedCard2: String?
    var selectedCard3: String?
    var pickerNumbers: [String]!
//        = ["42","50","58"].shuffled()
    
    let titleSpace = UILabel()
    let cardSpace1 = UILabel()
    let cardSpace2 = UILabel()
    let cardSpace3 = UILabel()
    
    let backgroundCard1 = UILabel()
    let backgroundCard2 = UILabel()
    let backgroundCard3 = UILabel()
    
    let doneButton = UIButton()
    
    let answerSpace1 = UITextField()
    //let equationSignal1 = UILabel(frame: CGRect(x: 105, y: 630, width: 50, height: 50))
    let answerSpace2 = UITextField()
    //let equationSignal2 = UILabel(frame: CGRect(x: 250, y: 630, width: 50, height: 50))
    let answerSpace3 = UITextField()
    //let answer = UILabel(frame: CGRect(x: 165, y: 740, width: 80, height: 60))
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    //    @IBOutlet weak var restartButton: UIButton!
    
    var pickerView1, pickerView2, pickerView3: UIPickerView!
    
    var chances = 3
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        scrollView.isScrollEnabled = true
        // scrollView.alwaysBounceVertical = true
        
        setupScrollView()
        
//        let imageConfig = UIImage.SymbolConfiguration(pointSize: 40)
//        restartButton.setImage(UIImage(systemName: "arrow.counterclockwise", withConfiguration: imageConfig), for: .normal)
//        restartButton.tintColor = .black
        restartButton.layer.borderWidth = 1
        restartButton.layer.borderColor = colorButton.cgColor
        restartButton.layer.shadowColor = UIColor.white.cgColor
        restartButton.layer.shadowOpacity = 0.4
        restartButton.layer.shadowOffset = .zero
        restartButton.layer.shadowRadius = 10
        restartButton.backgroundColor = colorButton
        restartButton.layer.cornerRadius = 10
        restartButton.setTitle("Jogar Novamente", for: .normal)
        restartButton.setTitleColor(.white, for: .normal)
        restartButton.titleLabel?.font = UIFont(name: "Raleway-Bold", size:27)
        restartButton.titleLabel?.adjustsFontSizeToFitWidth = true
        restartButton.isHidden = false
        restartButton.isEnabled = true
        
        pickerView1 = createPickerView1()
        dismissPickerView1()
        pickerView2 = createPickerView2()
        dismissPickerView2()
        pickerView3 = createPickerView3()
        dismissPickerView3()
        
        titleSpace.text = "Associe os números às frases corretas!"
        titleSpace.textColor = .white
        titleSpace.textAlignment = .center
        titleSpace.backgroundColor = colorTitle
        titleSpace.layer.masksToBounds = true
        titleSpace.numberOfLines = 0
        titleSpace.font = UIFont(name: "Raleway-Bold", size:30)
        
        backgroundCard1.backgroundColor = colorCard1
        backgroundCard1.layer.cornerRadius = 20
        backgroundCard1.layer.masksToBounds = true
        
        backgroundCard2.backgroundColor = colorCard2
        backgroundCard2.layer.cornerRadius = 20
        backgroundCard2.layer.masksToBounds = true
        
        backgroundCard3.backgroundColor = colorCard3
        backgroundCard3.layer.cornerRadius = 20
        backgroundCard3.layer.masksToBounds = true
        
        cardSpace1.text = hideNumbers(fact: factsOfNumbers[0].1)
        cardSpace1.textColor = .white
        cardSpace1.textAlignment = .center
        cardSpace1.layer.masksToBounds = true
        cardSpace1.numberOfLines = 0
        cardSpace1.font = UIFont(name: "Raleway-Bold", size:23)
        cardSpace1.adjustsFontSizeToFitWidth = true
        
        cardSpace2.text = hideNumbers(fact: factsOfNumbers[1].1)
        cardSpace2.textColor = .white
        cardSpace2.textAlignment = .center
        cardSpace2.layer.masksToBounds = true
        cardSpace2.numberOfLines = 0
        cardSpace2.font = UIFont(name: "Raleway-Bold", size:23)
        cardSpace2.adjustsFontSizeToFitWidth = true
        
        cardSpace3.text = hideNumbers(fact: factsOfNumbers[2].1)
        cardSpace3.textColor = .white
        cardSpace3.textAlignment = .center
        cardSpace3.layer.masksToBounds = true
        cardSpace3.numberOfLines = 0
        cardSpace3.font = UIFont(name: "Raleway-Bold", size:23)
        cardSpace3.adjustsFontSizeToFitWidth = true
        
        doneButton.layer.borderWidth = 1
        doneButton.layer.borderColor = colorButton.cgColor
        doneButton.layer.shadowColor = UIColor.white.cgColor
        doneButton.layer.shadowOpacity = 0.4
        doneButton.layer.shadowOffset = .zero
        doneButton.layer.shadowRadius = 10
        doneButton.backgroundColor = colorButton
        doneButton.layer.cornerRadius = 10
        doneButton.setTitle("Pronto!", for: .normal)
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.titleLabel?.font = UIFont(name: "Raleway-Bold", size:24)
        doneButton.addTarget(self, action: #selector(finish), for: .touchUpInside)
        doneButton.isEnabled = false
        
        answerSpace1.textColor = .white
        answerSpace1.textAlignment = .center
        answerSpace1.layer.borderColor = UIColor.white.cgColor
        answerSpace1.layer.borderWidth = 2
        answerSpace1.layer.cornerRadius = 10
        answerSpace1.layer.masksToBounds = true
        answerSpace1.font = UIFont(name: "Raleway-Bold", size:20 )
        
        answerSpace2.textColor = .white
        answerSpace2.textAlignment = .center
        answerSpace2.layer.borderColor = UIColor.white.cgColor
        answerSpace2.layer.borderWidth = 2
        answerSpace2.layer.cornerRadius = 10
        answerSpace2.layer.masksToBounds = true
        answerSpace2.font = UIFont(name: "Raleway-Bold", size:20 )
        
        answerSpace3.textColor = .white
        answerSpace3.textAlignment = .center
        answerSpace3.layer.borderColor = UIColor.white.cgColor
        answerSpace3.layer.borderWidth = 2
        answerSpace3.layer.cornerRadius = 10
        answerSpace3.layer.masksToBounds = true
        answerSpace3.font = UIFont(name: "Raleway-Bold", size:20 )
        
        popLabel.adjustsFontSizeToFitWidth = true
        popLabel.numberOfLines = 0
        
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
        scrollView.addSubview(answerSpace1)
        scrollView.addSubview(answerSpace2)
        scrollView.addSubview(answerSpace3)
        scrollView.addSubview(popImageview)
        scrollView.addSubview(popLabel)
        scrollView.addSubview(popBtm)
        
        scrollView.addSubview(doneButton)
        scrollView.addSubview(restartButton)
        
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
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        pickerView1.translatesAutoresizingMaskIntoConstraints = false
        answerSpace1.translatesAutoresizingMaskIntoConstraints = false
        answerSpace2.translatesAutoresizingMaskIntoConstraints = false
        answerSpace3.translatesAutoresizingMaskIntoConstraints = false
        popImageview.translatesAutoresizingMaskIntoConstraints = false
        popBtm.translatesAutoresizingMaskIntoConstraints = false
        popLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        //        contentView.addConstraint(NSLayoutConstraint(item: titleSpace, attribute: .top, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 10))
        titleSpace.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        titleSpace.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        titleSpace.heightAnchor.constraint(equalToConstant: 100).isActive = true
        titleSpace.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1).isActive = true
        
        //        contentView.addConstraint(NSLayoutConstraint(item: backgroundCard1, attribute: .top, relatedBy: .equal, toItem: titleSpace, attribute: .bottom, multiplier: 1.0, constant: 35))
        backgroundCard1.topAnchor.constraint(equalTo: titleSpace.bottomAnchor, constant: 35).isActive = true
        backgroundCard1.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        backgroundCard1.heightAnchor.constraint(equalToConstant: 160).isActive = true
        backgroundCard1.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
        
        //        contentView.addConstraint(NSLayoutConstraint(item: backgroundCard2, attribute: .top, relatedBy: .equal, toItem: backgroundCard1, attribute: .bottom, multiplier: 1.0, constant: 20))
        backgroundCard2.topAnchor.constraint(equalTo: backgroundCard1.bottomAnchor, constant: 20).isActive = true
        backgroundCard2.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        backgroundCard2.heightAnchor.constraint(equalToConstant: 160).isActive = true
        backgroundCard2.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
        
        //        contentView.addConstraint(NSLayoutConstraint(item: backgroundCard3, attribute: .top, relatedBy: .equal, toItem: backgroundCard2, attribute: .bottom, multiplier: 1.0, constant: 20))
        backgroundCard3.topAnchor.constraint(equalTo: backgroundCard2.bottomAnchor, constant: 20).isActive = true
        backgroundCard3.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        backgroundCard3.heightAnchor.constraint(equalToConstant: 160).isActive = true
        backgroundCard3.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
        
        //        contentView.addConstraint(NSLayoutConstraint(item: answerSpace1, attribute: .top, relatedBy: .equal, toItem: backgroundCard1, attribute: .top, multiplier: 1.0, constant: 5))
        answerSpace1.topAnchor.constraint(equalTo: backgroundCard1.topAnchor, constant: 5).isActive = true
        answerSpace1.centerXAnchor.constraint(equalTo: backgroundCard1.centerXAnchor).isActive = true
        answerSpace1.heightAnchor.constraint(equalToConstant: 40).isActive = true
        answerSpace1.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        //        contentView.addConstraint(NSLayoutConstraint(item: cardSpace1, attribute: .top, relatedBy: .equal, toItem: answerSpace1, attribute: .bottom, multiplier: 1.0, constant: 10))
        cardSpace1.topAnchor.constraint(equalTo: answerSpace1.bottomAnchor, constant: 10).isActive = true
        cardSpace1.centerXAnchor.constraint(equalTo: backgroundCard1.centerXAnchor).isActive = true
        cardSpace1.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.75).isActive = true
        cardSpace1.bottomAnchor.constraint(equalTo: backgroundCard1.bottomAnchor, constant: -5).isActive = true
        
        //        contentView.addConstraint(NSLayoutConstraint(item: answerSpace2, attribute: .top, relatedBy: .equal, toItem: backgroundCard2, attribute: .top, multiplier: 1.0, constant: 5))
        answerSpace2.topAnchor.constraint(equalTo: backgroundCard2.topAnchor, constant: 5).isActive = true
        answerSpace2.centerXAnchor.constraint(equalTo: backgroundCard2.centerXAnchor).isActive = true
        answerSpace2.heightAnchor.constraint(equalToConstant: 40).isActive = true
        answerSpace2.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        //        contentView.addConstraint(NSLayoutConstraint(item: cardSpace2, attribute: .top, relatedBy: .equal, toItem: answerSpace2, attribute: .bottom, multiplier: 1.0, constant: 10))
        cardSpace2.topAnchor.constraint(equalTo: answerSpace2.bottomAnchor, constant: 10).isActive = true
        cardSpace2.centerXAnchor.constraint(equalTo: backgroundCard2.centerXAnchor).isActive = true
        cardSpace2.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.75).isActive = true
        cardSpace2.bottomAnchor.constraint(equalTo: backgroundCard2.bottomAnchor, constant: -5).isActive = true
        
        //        contentView.addConstraint(NSLayoutConstraint(item: answerSpace3, attribute: .top, relatedBy: .equal, toItem: backgroundCard3, attribute: .top, multiplier: 1.0, constant: 5))
        answerSpace3.topAnchor.constraint(equalTo: backgroundCard3.topAnchor, constant: 5).isActive = true
        answerSpace3.centerXAnchor.constraint(equalTo: backgroundCard3.centerXAnchor).isActive = true
        answerSpace3.heightAnchor.constraint(equalToConstant: 40).isActive = true
        answerSpace3.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        //        contentView.addConstraint(NSLayoutConstraint(item: cardSpace3, attribute: .top, relatedBy: .equal, toItem: answerSpace3, attribute: .bottom, multiplier: 1.0, constant: 10))
        cardSpace3.topAnchor.constraint(equalTo: answerSpace3.bottomAnchor, constant: 10).isActive = true
        cardSpace3.centerXAnchor.constraint(equalTo: backgroundCard3.centerXAnchor).isActive = true
        cardSpace3.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.75).isActive = true
        cardSpace3.bottomAnchor.constraint(equalTo: backgroundCard3.bottomAnchor, constant: -5).isActive = true
        
        //        contentView.addConstraint(NSLayoutConstraint(item: doneButton, attribute: .top, relatedBy: .equal, toItem: backgroundCard3, attribute: .bottom, multiplier: 1.0, constant: 40))
        doneButton.topAnchor.constraint(equalTo: backgroundCard3.bottomAnchor, constant: 40).isActive = true
//        doneButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        doneButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        doneButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        restartButton.topAnchor.constraint(equalTo: doneButton.topAnchor).isActive = true
        restartButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        restartButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        restartButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4).isActive = true
        restartButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        popImageview.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        popImageview.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        popImageview.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2).isActive = true
        popImageview.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7).isActive = true
        
        popBtm.centerXAnchor.constraint(equalTo: popImageview.centerXAnchor).isActive = true
        popBtm.bottomAnchor.constraint(equalTo: popImageview.bottomAnchor, constant: -30).isActive = true
        popBtm.heightAnchor.constraint(equalTo: popImageview.heightAnchor, multiplier: 0.25).isActive = true
        popBtm.widthAnchor.constraint(equalTo: popImageview.widthAnchor, multiplier: 0.4).isActive = true
        
        popLabel.centerYAnchor.constraint(equalTo: popImageview.centerYAnchor, constant: -30).isActive = true
        popLabel.centerXAnchor.constraint(equalTo: popImageview.centerXAnchor).isActive = true
        popLabel.widthAnchor.constraint(equalTo: popImageview.widthAnchor, multiplier: 0.9).isActive = true
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 1 {
            
            return pickerNumbers.count+1
            
        }
        
        else if pickerView.tag == 2 {
            
            return pickerNumbers.count+1
            
        }
        
        else if pickerView.tag == 3 {
            
            return pickerNumbers.count+1
            
        }
        
        else {
            
            return 1
            
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1 {
            if row == 0 {
                return ""
            } else {
                return pickerNumbers[row-1]
            }
        }
        
        else if pickerView.tag == 2 {
            if row == 0 {
                return ""
            } else {
                return pickerNumbers[row-1]
            }
        }
        
        else if pickerView.tag == 3 {
            if row == 0 {
                return ""
            } else {
                return pickerNumbers[row-1]
            }
        }
        
        else {
            
            return "1"
            
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 1 {
            if row == 0 {
                answerSpace1.text = ""
            } else {
                selectedCard1 = pickerNumbers[row-1]
                answerSpace1.text = selectedCard1
                
//                if answerSpace2.text == pickerNumbers[row-1] {
//                    answerSpace2.text = ""
//                    pickerView2.selectRow(0, inComponent: 0, animated: true)
//                }
//
//                if answerSpace3.text == pickerNumbers[row-1] {
//                    answerSpace3.text = ""
//                    pickerView3.selectRow(0, inComponent: 0, animated: true)
//                }
            }
            
        }
        
        else if pickerView.tag == 2 {
            if row == 0 {
                answerSpace2.text = ""
            } else {
                selectedCard2 = pickerNumbers[row-1]
                answerSpace2.text = selectedCard2
                
//                if answerSpace1.text == pickerNumbers[row-1] {
//                    answerSpace1.text = ""
//                    pickerView1.selectRow(0, inComponent: 0, animated: true)
//                }
//
//                if answerSpace3.text == pickerNumbers[row-1] {
//                    answerSpace3.text = ""
//                    pickerView3.selectRow(0, inComponent: 0, animated: true)
//                }
            }
        }
        
        else if pickerView.tag == 3 {
            if row == 0 {
                answerSpace1.text = ""
            } else {
                selectedCard3 = pickerNumbers[row-1]
                answerSpace3.text = selectedCard3
                
//                if answerSpace2.text == pickerNumbers[row-1] {
//                    answerSpace2.text = ""
//                    pickerView2.selectRow(0, inComponent: 0, animated: true)
//                }
//
//                if answerSpace1.text == pickerNumbers[row-1] {
//                    answerSpace1.text = ""
//                    pickerView1.selectRow(0, inComponent: 0, animated: true)
//                }
            }
        }
        
    }
    
    func createPickerView1() -> UIPickerView {
        
        let pickerView1 = UIPickerView()
        pickerView1.delegate = self
        answerSpace1.inputView = pickerView1
        pickerView1.tag = 1
        
        return pickerView1
        
    }
    
    func dismissPickerView1() {
        
        let toolBar1 = UIToolbar()
        toolBar1.sizeToFit()
        
        let button1 = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissPicker))
        toolBar1.setItems([button1], animated: true)
        toolBar1.isUserInteractionEnabled = true
        answerSpace1.inputAccessoryView = toolBar1
    }
    
    func createPickerView2() -> UIPickerView {
        
        let pickerView2 = UIPickerView()
        pickerView2.delegate = self
        answerSpace2.inputView = pickerView2
        pickerView2.tag = 2
        //        print("create")
        
        return pickerView2
        
    }
    
    func dismissPickerView2() {
        
        let toolBar2 = UIToolbar()
        toolBar2.sizeToFit()
        
        let button2 = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissPicker))
        toolBar2.setItems([button2], animated: true)
        toolBar2.isUserInteractionEnabled = true
        answerSpace2.inputAccessoryView = toolBar2
        
        //        if (answerSpace1.text != nil && answerSpace2.text != nil && answerSpace3.text != nil){
        //            checkAnswer()
        //        }
        
    }
    
    func createPickerView3() -> UIPickerView{
        
        let pickerView3 = UIPickerView()
        pickerView3.delegate = self
        answerSpace3.inputView = pickerView3
        pickerView3.tag = 3
        //        print("create")
        
        return pickerView3
        
    }
    
    func dismissPickerView3() {
        
        let toolBar3 = UIToolbar()
        toolBar3.sizeToFit()
        
        let button3 = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissPicker))
        toolBar3.setItems([button3], animated: true)
        toolBar3.isUserInteractionEnabled = true
        answerSpace3.inputAccessoryView = toolBar3
        
        //        if (answerSpace1.text != nil && answerSpace2.text != nil && answerSpace3.text != nil){
        //            checkAnswer()
        //        }
    }
    
    @objc func dismissPicker() {
        view.endEditing(true)
        if (answerSpace1.text != "" && answerSpace2.text != "" && answerSpace3.text != ""){
            doneButton.isEnabled = true
            //            print(answerSpace3)
            //            checkAnswer()
        }
    }
    
    @objc func finish(sender: UIButton) {
        self.checkAnswer()
    }
    
    func hideNumbers(fact:String)->String{
        
        let hidedString = Array(fact)
        var newString = String()
        var lastNumber = -1
        
        for indice in hidedString.indices {
            
            if hidedString[indice].isNumber {
                newString.append("X")
                lastNumber = indice
            } else {
                if lastNumber >= 0 {
                    let index = fact.index(fact.startIndex, offsetBy: lastNumber+1)
                    let substring = fact.suffix(from: index)
                    newString.append(contentsOf: substring)
                    break
                } else {
                    newString.append(hidedString[indice])
                }
            }
        }
        
        return newString
    }
    
    func checkAnswer(){
        
        // Fazer checagem do picker e muda valor de variavel "correct"
        if (answerSpace1.text == factsOfNumbers[0].0 && answerSpace2.text == factsOfNumbers[1].0 && answerSpace3.text == factsOfNumbers[2].0) {
            print("resposta certa")
            correct = true
            showPop(correct: true)
        }
        
        else {
            correct = false
            showPop(correct: false)
            chances = chances - 1
        }
        
    }
    
    func showPop(correct: Bool){
        
        if (correct) {
            popImageview.image = UIImage(named: "RectangleRight")
            popLabel.text = "Você acertou! 🥳"
            popLabel.textColor = .orange
            popBtm.isHidden = false
            popBtm.addTarget(self, action: #selector(revealNumbers), for: .touchUpInside)
            popBtm.setTitle("Revelar números", for: .normal)
            //            restartButton.isHidden = false
            
        } else {
            popImageview.image = UIImage(named: "RectangleWrong")
            popLabel.textColor = UIColor.orange
            if chances == 0 {
                popBtm.setTitle("Revelar números", for: .normal)

            } else {
                popBtm.setTitle("Tentar Novamente", for: .normal)
            }
            popLabel.text = "Pense mais um pouco! 🤔\n(\(chances) chances restantes)"
        }
        
        popLabel.font = UIFont(name: "Raleway", size: 22)
        popLabel.textColor = .white
        //popBtm.setImage(UIImage(named: "PinkRectangle"), for: .normal)
        popBtm.titleLabel?.font = UIFont(name: "Raleway", size: 15)
        popImageview.isHidden = false
        popBtm.isHidden = false
        popLabel.isHidden = false
    }
    
    @IBAction func revealNumbers(_ sender: Any) {
        popImageview.isHidden = true
        popBtm.isHidden = true
        popLabel.isHidden = true
        
        if (correct) || chances == 0{
            answerSpace1.isHidden = true
            answerSpace2.isHidden = true
            answerSpace3.isHidden = true
            doneButton.isHidden = true
            
            cardSpace1.text = factsOfNumbers[0].1
            cardSpace2.text = factsOfNumbers[1].1
            cardSpace3.text = factsOfNumbers[2].1
        }
    }
    
}
