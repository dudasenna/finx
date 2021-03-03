//
//  EquationViewController.swift
//  AppSurdo
//
//  Created by Luis Pereira on 31/08/20.
//  Copyright © 2020 Luis Pereira. All rights reserved.
//

import Foundation
import  UIKit

class EquationViewController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var colorTitle = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 0.75)
    var colorCard1 = #colorLiteral(red: 0.9960784314, green: 0.831372549, blue: 0.7921568627, alpha: 0.9)
    var colorCard2 = #colorLiteral(red: 1, green: 0.9803921569, blue: 0.8823529412, alpha: 0.9)
    var colorCard3 = #colorLiteral(red: 0.8274509804, green: 0.9176470588, blue: 1, alpha: 0.9)
    var colorButton = #colorLiteral(red: 0.5529411765, green: 0.9098039216, blue: 0.8039215686, alpha: 1)
    
    var correct = false
    var factsOfNumbers: [String]!
    @IBOutlet weak var popImageview: UIImageView!
    @IBOutlet weak var popLabel: UILabel!
    @IBOutlet weak var popBtm: UIButton!
    //    var cardSpace1,cardSpace2, cardSpace3: UILabel!
    var selectedCard1: String?
    var selectedCard2: String?
    var selectedCard3: String?
    var countryList = ["42", "626", "1362310155"]
    
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
    
    @IBOutlet weak var restartButton: UIButton!
    
    var pickerView1, pickerView2, pickerView3: UIPickerView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        scrollView.isScrollEnabled = true
       // scrollView.alwaysBounceVertical = true
        
        setupScrollView()
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20)
        restartButton.setImage(UIImage(systemName: "arrow.counterclockwise", withConfiguration: imageConfig), for: .normal)
        restartButton.tintColor = .black
        restartButton.isHidden = true
        
        pickerView1 = createPickerView1()
        dismissPickerView1()
        pickerView2 = createPickerView2()
        dismissPickerView2()
        pickerView3 = createPickerView3()
        dismissPickerView3()
        
        titleSpace.text = "Associe os números às frases corretas!"
        titleSpace.textColor = .black
        titleSpace.textAlignment = .center
        titleSpace.backgroundColor = colorTitle
        titleSpace.layer.masksToBounds = true
        titleSpace.numberOfLines = 0
        titleSpace.font = UIFont(name: "Superfruit", size:35)
        
        backgroundCard1.backgroundColor = colorCard1
        backgroundCard1.layer.cornerRadius = 20
        backgroundCard1.layer.masksToBounds = true

        backgroundCard2.backgroundColor = colorCard2
        backgroundCard2.layer.cornerRadius = 20
        backgroundCard2.layer.masksToBounds = true

        backgroundCard3.backgroundColor = colorCard3
        backgroundCard3.layer.cornerRadius = 20
        backgroundCard3.layer.masksToBounds = true

        cardSpace1.text = hideNumbers(fact: factsOfNumbers[0])
        cardSpace1.textColor = .black
        cardSpace1.textAlignment = .center
        cardSpace1.layer.masksToBounds = true
        cardSpace1.numberOfLines = 0
        cardSpace1.font = UIFont(name: "Superfruit", size:23)
        
        cardSpace2.text = hideNumbers(fact: factsOfNumbers[1])
        cardSpace2.textColor = .black
        cardSpace2.textAlignment = .center
        cardSpace2.layer.masksToBounds = true
        cardSpace2.numberOfLines = 0
        cardSpace2.font = UIFont(name: "Superfruit", size:23)
        
        
        cardSpace3.text = hideNumbers(fact: factsOfNumbers[2])
        cardSpace3.textColor = .black
        cardSpace3.textAlignment = .center
        cardSpace3.layer.masksToBounds = true
        cardSpace3.numberOfLines = 0
        cardSpace3.font = UIFont(name: "Superfruit", size:23)
        
        doneButton.layer.borderWidth = 1
        doneButton.layer.borderColor = colorButton.cgColor
        doneButton.layer.shadowColor = UIColor.black.cgColor
        doneButton.layer.shadowOpacity = 0.5
        doneButton.layer.shadowOffset = .zero
        doneButton.layer.shadowRadius = 10
        doneButton.backgroundColor = colorButton
        doneButton.layer.cornerRadius = 10
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(.black, for: .normal)
        doneButton.titleLabel?.font = UIFont(name: "Superfruit", size:30)
        
        answerSpace1.textColor = .black
        answerSpace1.textAlignment = .center
        answerSpace1.layer.borderColor = CGColor(srgbRed: 100/255, green: 100/255, blue: 100/255, alpha: 1)
        answerSpace1.layer.borderWidth = 2
        answerSpace1.layer.cornerRadius = 10
        answerSpace1.layer.masksToBounds = true
        answerSpace1.font = UIFont(name: "Superfruit", size:20 )
        
        answerSpace2.textColor = .black
        answerSpace2.textAlignment = .center
        answerSpace2.layer.borderColor = CGColor(srgbRed: 100/255, green: 100/255, blue: 100/255, alpha: 1)
        answerSpace2.layer.borderWidth = 2
        answerSpace2.layer.cornerRadius = 10
        answerSpace2.layer.masksToBounds = true
        answerSpace2.font = UIFont(name: "Superfruit", size:20 )
        
        answerSpace3.textColor = .black
        answerSpace3.textAlignment = .center
        answerSpace3.layer.borderColor = CGColor(srgbRed: 100/255, green: 100/255, blue: 100/255, alpha: 1)
        answerSpace3.layer.borderWidth = 2
        answerSpace3.layer.cornerRadius = 10
        answerSpace3.layer.masksToBounds = true
        answerSpace3.font = UIFont(name: "Superfruit", size:20 )
        
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
        
        contentView.addSubview(titleSpace)
        contentView.addSubview(backgroundCard1)
        contentView.addSubview(backgroundCard2)
        contentView.addSubview(backgroundCard3)
        contentView.addSubview(cardSpace1)
        contentView.addSubview(cardSpace2)
        contentView.addSubview(cardSpace3)
        contentView.addSubview(doneButton)
        contentView.addSubview(popImageview)
        contentView.addSubview(popLabel)
        contentView.addSubview(popBtm)
        contentView.addSubview(restartButton)
        
        titleSpace.translatesAutoresizingMaskIntoConstraints = false
        backgroundCard1.translatesAutoresizingMaskIntoConstraints = false
        backgroundCard2.translatesAutoresizingMaskIntoConstraints = false
        backgroundCard3.translatesAutoresizingMaskIntoConstraints = false
        cardSpace1.translatesAutoresizingMaskIntoConstraints = false
        cardSpace2.translatesAutoresizingMaskIntoConstraints = false
        cardSpace3.translatesAutoresizingMaskIntoConstraints = false
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        pickerView1.translatesAutoresizingMaskIntoConstraints = false
        answerSpace1.translatesAutoresizingMaskIntoConstraints = false
        answerSpace2.translatesAutoresizingMaskIntoConstraints = false
        answerSpace3.translatesAutoresizingMaskIntoConstraints = false
        
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
        
//        contentView.addConstraint(NSLayoutConstraint(item: answerSpace2, attribute: .top, relatedBy: .equal, toItem: backgroundCard2, attribute: .top, multiplier: 1.0, constant: 5))
        answerSpace2.topAnchor.constraint(equalTo: backgroundCard2.topAnchor, constant: 5).isActive = true
        answerSpace2.centerXAnchor.constraint(equalTo: backgroundCard2.centerXAnchor).isActive = true
        answerSpace2.heightAnchor.constraint(equalToConstant: 40).isActive = true
        answerSpace2.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
//        contentView.addConstraint(NSLayoutConstraint(item: cardSpace2, attribute: .top, relatedBy: .equal, toItem: answerSpace2, attribute: .bottom, multiplier: 1.0, constant: 10))
        cardSpace2.topAnchor.constraint(equalTo: answerSpace2.bottomAnchor, constant: 10).isActive = true
        cardSpace2.centerXAnchor.constraint(equalTo: backgroundCard2.centerXAnchor).isActive = true
        cardSpace2.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.75).isActive = true
        
//        contentView.addConstraint(NSLayoutConstraint(item: answerSpace3, attribute: .top, relatedBy: .equal, toItem: backgroundCard3, attribute: .top, multiplier: 1.0, constant: 5))
        answerSpace3.topAnchor.constraint(equalTo: backgroundCard3.topAnchor, constant: 5).isActive = true
        answerSpace3.centerXAnchor.constraint(equalTo: backgroundCard3.centerXAnchor).isActive = true
        answerSpace3.heightAnchor.constraint(equalToConstant: 40).isActive = true
        answerSpace3.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
//        contentView.addConstraint(NSLayoutConstraint(item: cardSpace3, attribute: .top, relatedBy: .equal, toItem: answerSpace3, attribute: .bottom, multiplier: 1.0, constant: 10))
        cardSpace3.topAnchor.constraint(equalTo: answerSpace3.bottomAnchor, constant: 10).isActive = true
        cardSpace3.centerXAnchor.constraint(equalTo: backgroundCard3.centerXAnchor).isActive = true
        cardSpace3.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.75).isActive = true
        
//        contentView.addConstraint(NSLayoutConstraint(item: doneButton, attribute: .top, relatedBy: .equal, toItem: backgroundCard3, attribute: .bottom, multiplier: 1.0, constant: 40))
        doneButton.topAnchor.constraint(equalTo: backgroundCard3.bottomAnchor, constant: 40).isActive = true
        doneButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        doneButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 1 {
            
            return numbers.count
            
        }
        
        else if pickerView.tag == 2 {
            
            return numbers.count
            
        }
        
        else if pickerView.tag == 3 {
            
            return numbers.count
            
        }
        
        else {
            
            return 1
            
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1 {
            
            return numbers[row]
            
        }
        
        else if pickerView.tag == 2 {
            
            return numbers[row]
            
        }
        
        else if pickerView.tag == 3 {
            
            return numbers[row]
            
        }
        
        else {
            
            return "1"
            
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 1 {
            
            selectedCard1 = numbers[row]
            answerSpace1.text = selectedCard1
            
        }
        
        else if pickerView.tag == 2 {
            
            selectedCard2 = numbers[row]
            answerSpace2.text = selectedCard2
            
        }
        
        else if pickerView.tag == 3 {
            
            selectedCard3 = numbers[row]
            answerSpace3.text = selectedCard3
            
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
        
        let button1 = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar1.setItems([button1], animated: true)
        toolBar1.isUserInteractionEnabled = true
        answerSpace1.inputAccessoryView = toolBar1
    }
    
    func createPickerView2() -> UIPickerView {
        
        let pickerView2 = UIPickerView()
        pickerView2.delegate = self
        answerSpace2.inputView = pickerView2
        pickerView2.tag = 2
        print("create")
        
        return pickerView2
        
    }
    
    func dismissPickerView2() {
        
        let toolBar2 = UIToolbar()
        toolBar2.sizeToFit()
        
        let button2 = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
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
        print("create")
        
        return pickerView3
        
    }
    
    func dismissPickerView3() {
        
        let toolBar3 = UIToolbar()
        toolBar3.sizeToFit()
        
        let button3 = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar3.setItems([button3], animated: true)
        toolBar3.isUserInteractionEnabled = true
        answerSpace3.inputAccessoryView = toolBar3
        
        //        if (answerSpace1.text != nil && answerSpace2.text != nil && answerSpace3.text != nil){
        //            checkAnswer()
        //        }
    }

    @objc func action() {
        
        view.endEditing(true)
        if (answerSpace1.text != "" && answerSpace2.text != "" && answerSpace3.text != ""){
            print(answerSpace3)
            checkAnswer()
        }
        
    }
    
    
    func hideNumbers(fact:String)->String{
        
        let hidedString = Array(fact)
        var newString = String()
        for index in hidedString.indices{
            
            if hidedString[index].isNumber{
                newString.append("?")
            }else{
                newString.append(hidedString[index])
            }
            
        }
        return newString
    }
    
    func checkAnswer(){
        
        // Fazer checagem do picker e muda valor de variavel "correct"
        if (answerSpace1.text == "A" && answerSpace2.text == "B" && answerSpace3.text == "C") {
            
            correct = true
            showPop(correct: true)
            
        }
        
        else {
            
            correct = false
            showPop(correct: false)
        }
        
    }
    
    func showPop(correct: Bool){
        
        if (correct) {
            popImageview.image = UIImage(named: "RectangleCorrect")
            popLabel.text = "Parabéns"
            popLabel.textColor = .black
            popBtm.isHidden = true
//            popBtm.titleLabel?.text = "Revelar números"
            restartButton.isHidden = false
            
        } else {
            popImageview.image = UIImage(named: "RectangleWrong")
            popLabel.text = "Tente novamente"
            popLabel.textColor = .black
            popBtm.titleLabel?.text = "OK"
            
        }
        
        popLabel.font = UIFont(name: "Superfruit", size: 27)
        //popBtm.setImage(UIImage(named: "PinkRectangle"), for: .normal)
        popBtm.titleLabel?.font = UIFont(name: "Superfruit", size: 15)
        popImageview.isHidden = false
        popBtm.isHidden = false
        popLabel.isHidden = false
    }
    
    @IBAction func revealNumbers(_ sender: Any) {
        popImageview.isHidden = true
        popBtm.isHidden = true
        popLabel.isHidden = true
        
        if (correct){
            cardSpace1.text = factsOfNumbers[0]
            cardSpace2.text = factsOfNumbers[1]
            cardSpace3.text = factsOfNumbers[2]
        }
        
    }
    
}
