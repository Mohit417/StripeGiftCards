//
//  ProcessGiftCardVC.swift
//  NewGiftCards
//
//  Created by Mohit Katyal on 3/25/20.
//  Copyright © 2020 Mohit Katyal. All rights reserved.
//

import UIKit

class GiftCardAmountVC: UIViewController {
    
    var shoppingCart: [Product]
    let settings: Settings
    
    let type = UIDevice().type
    var verificationLabel = UILabel()
    var enterBillLabel = UILabel()
    var amountTextField = CurrencyTextField()
    var processButton = UIButton()
    var validationLabel = UILabel()
    var success: Bool = true

    init(products: [Product], settings: Settings){
        self.shoppingCart = products
        self.settings = settings
        super.init(nibName: nil, bundle: nil)
        print(self.shoppingCart)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupEnterBillLabel()
        self.setupAmountLabel()
        self.setupProcessAmountButton()
        self.setupFailureLabel()
    }
    
    override func viewDidLayoutSubviews() {
        setupEnterBillConstraint()
        setupAmountConstraint()
        setupProcessAmountConstraints()
        setupFailureConstraints()
    }
    
    
    func setupEnterBillLabel(){
        self.enterBillLabel.text = "Enter Gift Card Amount"
        self.enterBillLabel.font = self.enterBillLabel.font.withSize(30)
        self.enterBillLabel.textAlignment = .center
        self.view.addSubview(enterBillLabel)
    }
    func setupEnterBillConstraint(){
        self.enterBillLabel.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                self.enterBillLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50),
                self.enterBillLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.enterBillLabel.heightAnchor.constraint(equalToConstant: 50),
                self.enterBillLabel.widthAnchor.constraint(equalToConstant: 300)
            ])
        } else {
            // Fallback on earlier versions
            NSLayoutConstraint.activate([
                self.enterBillLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
                self.enterBillLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.enterBillLabel.heightAnchor.constraint(equalToConstant: 50),
                self.enterBillLabel.widthAnchor.constraint(equalToConstant: 300)
            ])
        }
        
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
            
            shoppingCart = [Product(emoji: shoppingCart[0].emoji, price: Int(amountTextField.value))]
            print(shoppingCart)
            let checkoutViewController = CheckoutViewController(products: shoppingCart,
                                                                settings: self.settings)
            self.navigationController?.pushViewController(checkoutViewController, animated: true)
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


