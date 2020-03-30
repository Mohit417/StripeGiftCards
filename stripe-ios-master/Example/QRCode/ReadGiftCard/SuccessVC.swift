//
//  EnterBillVC.swift
//  NewGiftCards
//
//  Created by Mohit Katyal on 3/25/20.
//  Copyright © 2020 Mohit Katyal. All rights reserved.
//

import UIKit

class SuccessVC: UIViewController {
    
    var amountRemoved = 15.00
    var billRemaining = 5.00
    var amountRemaining = 0.00
    
    let type = UIDevice().type
    var verificationLabel = UILabel()
    var amountRemovedLabel = UILabel()
    var amountRemainingLabel = UILabel()
    var billRemainingLabel = UILabel()
    var emailLabel = UILabel()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupVerificationLabel()
        self.setupAmountRemovedLabel()
        self.setupAmountRemainingLabel()
        self.setupBillRemaining()
        self.setupEmailLabel()
    }
    
    override func viewDidLayoutSubviews() {
        
        setupLabelConstraint()
        setupAmountRemovedConstraint()
        setupBillRemainingConstraint()
        setupAmountRemainingConstraint()
        setupEmailLabelConstraint()
    }
    
    
    func setupVerificationLabel(){
        self.verificationLabel.text = "Gift Card Processed"
        self.verificationLabel.font = self.verificationLabel.font.withSize(34)
        self.verificationLabel.textAlignment = .center
        self.view.addSubview(verificationLabel)
    }
    func setupLabelConstraint(){
        self.verificationLabel.translatesAutoresizingMaskIntoConstraints = false
        if type == Model.iPhone7 || type == Model.iPhone8 {
            self.verificationLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        } else {
            self.verificationLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        }
        
        NSLayoutConstraint.activate([
            self.verificationLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.verificationLabel.heightAnchor.constraint(equalToConstant: 100),
            self.verificationLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
        
    }
    
    
    func setupAmountRemovedLabel(){
        self.amountRemovedLabel.text = "Amount Removed\n$\(amountRemoved)"
        self.amountRemovedLabel.font = self.amountRemovedLabel.font.withSize(30)
        self.amountRemovedLabel.numberOfLines = 2
        self.amountRemovedLabel.textAlignment = .center
        self.view.addSubview(amountRemovedLabel)
    }
    func setupAmountRemovedConstraint(){
        self.amountRemovedLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.amountRemovedLabel.topAnchor.constraint(equalTo: self.verificationLabel.bottomAnchor, constant: 0),
            self.amountRemovedLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.amountRemovedLabel.heightAnchor.constraint(equalToConstant: 100),
            self.amountRemovedLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
        
    }
    
    func setupBillRemaining(){
        self.billRemainingLabel.text = "Bill Remaining\n$\(billRemaining)"
        self.billRemainingLabel.font = self.billRemainingLabel.font.withSize(30)
        self.billRemainingLabel.numberOfLines = 2
        self.billRemainingLabel.textAlignment = .center
        self.view.addSubview(billRemainingLabel)
    }
    func setupBillRemainingConstraint(){
        self.billRemainingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.billRemainingLabel.topAnchor.constraint(equalTo: self.amountRemovedLabel.bottomAnchor, constant: 50),
            self.billRemainingLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.billRemainingLabel.heightAnchor.constraint(equalToConstant: 100),
            self.billRemainingLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
        
    }
    
    func setupAmountRemainingLabel(){
        self.amountRemainingLabel.text = "Gift Card Balance\n$\(amountRemaining)"
        self.amountRemainingLabel.font = self.amountRemainingLabel.font.withSize(30)
        self.amountRemainingLabel.numberOfLines = 2
        self.amountRemainingLabel.textAlignment = .center
        self.view.addSubview(amountRemainingLabel)
    }
    func setupAmountRemainingConstraint(){
        self.amountRemainingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.amountRemainingLabel.topAnchor.constraint(equalTo: self.billRemainingLabel.bottomAnchor, constant: 50),
            self.amountRemainingLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.amountRemainingLabel.heightAnchor.constraint(equalToConstant: 100),
            self.amountRemainingLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
        
    }
    
    func setupEmailLabel(){
        self.emailLabel.text = "An email notification has been sent to the customer"
        self.emailLabel.font = self.emailLabel.font.withSize(24)
        self.emailLabel.numberOfLines = 0
        self.emailLabel.textAlignment = .center
        self.view.addSubview(emailLabel)
    }
    func setupEmailLabelConstraint(){
        self.emailLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.emailLabel.topAnchor.constraint(equalTo: self.amountRemainingLabel.bottomAnchor, constant: 20),
            self.emailLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.emailLabel.heightAnchor.constraint(equalToConstant: 100),
            self.emailLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
        
    }
    

}





