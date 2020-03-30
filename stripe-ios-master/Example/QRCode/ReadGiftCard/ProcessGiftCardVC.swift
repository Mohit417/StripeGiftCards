//
//  ProcessGiftCardVC.swift
//  NewGiftCards
//
//  Created by Mohit Katyal on 3/25/20.
//  Copyright © 2020 Mohit Katyal. All rights reserved.
//

import UIKit

class ProcessGiftCardVC: UIViewController {
    
    let type = UIDevice().type
    var verificationLabel = UILabel()
    var enterBillLabel = UILabel()
    var amountTextField = CurrencyTextField()
    var processButton = UIButton()
    var validationLabel = UILabel()
    var success: Bool = true


    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.setupVerificationLabel()
        setupEnterBillLabel()
        self.setupAmountLabel()
        self.setupProcessAmountButton()
        self.setupFailureLabel()
    }
    
    override func viewDidLayoutSubviews() {
        setupLabelConstraint()
        setupEnterBillConstraint()
        setupAmountConstraint()
        setupProcessAmountConstraints()
        setupFailureConstraints()
    }
    
    
    func setupVerificationLabel(){
        self.verificationLabel.text = "Gift Card Verified"
        self.verificationLabel.font = self.verificationLabel.font.withSize(40)
        self.verificationLabel.textAlignment = .center
        self.view.addSubview(verificationLabel)
    }
    func setupLabelConstraint(){
        self.verificationLabel.translatesAutoresizingMaskIntoConstraints = false
        if type == Model.iPhone7 || type == Model.iPhone8 {
            self.verificationLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        } else {
            self.verificationLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 110).isActive = true
        }
        
        NSLayoutConstraint.activate([
            self.verificationLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.verificationLabel.heightAnchor.constraint(equalToConstant: 100),
            self.verificationLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
        

    }
    
    func setupEnterBillLabel(){
        self.enterBillLabel.text = "Enter Bill Amount"
        self.enterBillLabel.font = self.enterBillLabel.font.withSize(36)
        self.enterBillLabel.textAlignment = .center
        self.view.addSubview(enterBillLabel)
    }
    func setupEnterBillConstraint(){
        self.enterBillLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.enterBillLabel.topAnchor.constraint(equalTo: self.verificationLabel.bottomAnchor, constant: 30),
            self.enterBillLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.enterBillLabel.heightAnchor.constraint(equalToConstant: 50),
            self.enterBillLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
        
    }
    
    func setupAmountLabel(){
        self.amountTextField.font = self.verificationLabel.font.withSize(50)
        self.amountTextField.textAlignment = .center
        self.view.addSubview(amountTextField)
    }
    func setupAmountConstraint(){
        self.amountTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.amountTextField.topAnchor.constraint(equalTo: self.enterBillLabel.bottomAnchor, constant: 10),
            self.amountTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.amountTextField.heightAnchor.constraint(equalToConstant: 50),
            self.amountTextField.widthAnchor.constraint(equalToConstant: 300)
        ])
        
    }
    
    func setupProcessAmountButton(){
        
        if #available(iOS 12.0, *) {
            if traitCollection.userInterfaceStyle == .light {
                print("Light mode")
                self.processButton.setTitleColor(.black, for: .normal)
                self.processButton.layer.borderColor = UIColor.black.cgColor
                
            } else {
                print("Dark mode")
                self.processButton.setTitleColor(.white, for: .normal)
                self.processButton.layer.borderColor = UIColor.white.cgColor
            }
        } else {
            // Fallback on earlier versions
        }
        self.processButton.setTitle("Process Gift Card", for: .normal)
        self.processButton.titleLabel?.font = self.verificationLabel.font.withSize(24)
        self.processButton.layer.cornerRadius = 10
        self.processButton.layer.borderWidth = 3
        self.processButton.addTarget(self, action:#selector(processAmount), for: .touchUpInside)
        self.view.addSubview(processButton)
    }
    func setupProcessAmountConstraints(){
        self.processButton.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             self.processButton.topAnchor.constraint(equalTo: self.amountTextField.bottomAnchor, constant: 60),
             self.processButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
             self.processButton.heightAnchor.constraint(equalToConstant: 100),
             self.processButton.widthAnchor.constraint(equalToConstant: 300)
         ])
    }
    @objc func processAmount(){
        print(self.amountTextField.value/100)
        
        if self.amountTextField.value == 0 {
            print("Value Not Entered")
            return
        }
        
        
        if success {
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SuccessVC") as! SuccessVC
            self.navigationController?.pushViewController(secondViewController, animated: true)
        } else {
            self.validationLabel.isHidden = false
            self.processButton.isEnabled = false
            self.amountTextField.isEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) { // Change `2.0` to the desired
                self.validationLabel.isHidden = true
                self.processButton.isEnabled = true
                self.amountTextField.isEnabled = true
            }
        }
        
    }
    
    
    func setupFailureLabel(){
        if #available(iOS 12.0, *) {
            if traitCollection.userInterfaceStyle == .light {
                print("Light mode")
                self.validationLabel.backgroundColor = .black
                self.validationLabel.textColor = .white
            } else {
                print("Dark mode")
                self.validationLabel.backgroundColor = .white
                self.validationLabel.textColor = .black
            }
        } else {
            // Fallback on earlier versions
        }
        
        
        self.validationLabel.isHidden = true
        self.validationLabel.text = "Issue Processing Gift Card"
        self.validationLabel.font = self.verificationLabel.font.withSize(36)
        self.validationLabel.numberOfLines = 0
        self.validationLabel.textAlignment = .center
        self.validationLabel.layer.cornerRadius = 20
        self.validationLabel.clipsToBounds = true
        self.view.addSubview(validationLabel)
    }
    func setupFailureConstraints(){
        self.validationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.validationLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.validationLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.validationLabel.heightAnchor.constraint(equalToConstant: 200),
            self.validationLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    

}


