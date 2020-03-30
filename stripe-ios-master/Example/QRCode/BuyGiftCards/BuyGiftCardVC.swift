//
//  BuyGiftCardVC.swift
//  NewGiftCards
//
//  Created by Mohit Katyal on 3/27/20.
//  Copyright © 2020 Mohit Katyal. All rights reserved.
//

import Foundation
import UIKit

class BuyGiftCardVC: UIViewController {
    
    let restID = "123456789"
    let giftID = "987654321"
    
    //MARK: UI Components
    var giftcard = GiftCardView()
    let button = KGRadioButton(frame: CGRect(x: 20, y: 170, width: 50, height: 50))
    let label = UILabel()
    var email = UITextField()
    var message = UITextView()
    let messagePlaceholder = "Happy Birthday! Here's a gift card to the restaurant you love!"
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGiftCard()
        sendToMyself()
        setupSendToMyselfLabel()
        setupEmail()
        setupMessage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupGiftCardConstraints()
        sendToMyselfConstraints()
        sendToMyselfLabelConstraints()
        setupEmailConstraints()
        setupMessageConstraints()
    }
    
    func setupGiftCard(){
        giftcard = GiftCardView(frame: .zero, restName: "Anzio's Pizza Place For Pizza", qrCode: QRCodeVC.generateQRImage(restID: restID, cardID: giftID)!, giftID: giftID, width: 200)
        giftcard.backgroundColor = .white
        view.addSubview(giftcard)
    }
    func setupGiftCardConstraints(){
        let guide = view.layoutMarginsGuide
        self.giftcard.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
            self.giftcard.topAnchor.constraint(equalTo: guide.topAnchor, constant: 10),
            self.giftcard.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 10),
            self.giftcard.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -10),
            self.giftcard.bottomAnchor.constraint(equalTo: guide.topAnchor, constant: 450),
         ])
    }
    
    
    func sendToMyself(){
        button.outerCircleColor = .black
        button.innerCircleCircleColor = .black
        button.addTarget(self, action: #selector(manualAction(sender:)), for: .touchUpInside)
        self.view.addSubview(button)
    }
    func sendToMyselfConstraints(){
        let guide = view.layoutMarginsGuide
        self.button.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
            self.button.topAnchor.constraint(equalTo: giftcard.bottomAnchor, constant: 10),
            self.button.leadingAnchor.constraint(equalTo: giftcard.leadingAnchor, constant: 0),

         ])
    }
    @objc func manualAction (sender: KGRadioButton) {
       sender.isSelected = !sender.isSelected
       if sender.isSelected {
           print("Selected")
        } else{
           print("Not Selected")
        }
     }
    
    
    func setupSendToMyselfLabel(){
        label.text = "Send this gift card to my email"
        self.view.addSubview(label)
    }
    func sendToMyselfLabelConstraints(){
        let guide = view.layoutMarginsGuide
        self.label.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: button.topAnchor, constant: 8),
            self.label.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 5),

         ])
    }
    
    
    func setupEmail(){
        email.placeholder = "Add the email you'd like to send this to; e/g johnsmith@email.com"
        email.layer.borderColor = UIColor.black.cgColor
        email.layer.borderWidth = 1
        email.layer.cornerRadius = 5
        email.clipsToBounds = true
        self.view.addSubview(email)
    }
    func setupEmailConstraints(){
        let guide = view.layoutMarginsGuide
        self.email.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
            self.email.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 5),
            self.email.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 0),
            self.email.trailingAnchor.constraint(equalTo: giftcard.trailingAnchor, constant: 0),
            self.email.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant:40),
         ])
    }
    
    
    func setupMessage(){
        message.text = messagePlaceholder
        message.textColor = .lightGray
        message.delegate = self
        self.view.addSubview(message)
    }
    func setupMessageConstraints(){
        let guide = view.layoutMarginsGuide
        self.message.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
            self.message.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 5),
            self.message.leadingAnchor.constraint(equalTo: email.leadingAnchor, constant: 0),
            self.message.trailingAnchor.constraint(equalTo: giftcard.trailingAnchor),
            self.message.bottomAnchor.constraint(equalTo: email.bottomAnchor, constant: 205),
         ])
    }
    
    
}


extension BuyGiftCardVC: UITextViewDelegate {
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = messagePlaceholder
            textView.textColor = .lightGray
        }
    }
}
