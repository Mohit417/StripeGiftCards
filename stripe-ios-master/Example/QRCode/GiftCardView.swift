//
//  GiftCardView.swift
//  NewGiftCards
//
//  Created by Mohit Katyal on 3/28/20.
//  Copyright © 2020 Mohit Katyal. All rights reserved.
//

import Foundation
import UIKit

class GiftCardView: UIView {
    
    //MARK: INITIALIZE
    var restaurantName = ""
    var QRCode = UIImage()
    var giftcardID = ""
    var width: CGFloat = 0
    
    init(frame: CGRect, restName: String, qrCode: UIImage, giftID: String, width: CGFloat) {
        super.init(frame: frame)
        self.restaurantName = restName
        self.QRCode = qrCode
        self.giftcardID = giftID
        self.width = width
        self.backgroundColor = .white
        
        setupRestaurantName()
        setupQRCode()
        setupGiftCardID()
        setupBorder()
        
        setupRestaurantNameConstraints()
        setupQRCodeConstraints()
        setupGiftCardIDConstraints()
    }
    
    convenience init() {
        self.init(frame: .zero, restName: "", qrCode: UIImage(), giftID: "", width: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: UI
    var restLabel = UILabel()
    var QRCodeImageView = UIImageView()
    var giftcardIDLabel = UILabel()
    
    //MARK:RESTAURANT NAME
    func setupRestaurantName(){
        restLabel.textAlignment = .center
        restLabel.textColor = .black
        restLabel.text = self.restaurantName
        restLabel.font = restLabel.font.withSize(24)
        restLabel.numberOfLines = 1
        restLabel.sizeToFit()
        self.addSubview(restLabel)
    }
    func setupRestaurantNameConstraints(){
        self.restLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.restLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.restLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.restLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
        ])
    }
    
    //MARK: QR CODE
    func setupQRCode(){
        QRCodeImageView.image = QRCode
        self.addSubview(QRCodeImageView)
    }
    func setupQRCodeConstraints(){
        self.QRCodeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.QRCodeImageView.topAnchor.constraint(equalTo: self.restLabel.bottomAnchor, constant: 10),
            self.QRCodeImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.QRCodeImageView.heightAnchor.constraint(equalToConstant: self.width),
            self.QRCodeImageView.widthAnchor.constraint(equalToConstant: self.width)
        ])
    }
    
    
    //MARK: GIFTCARD ID
    func setupGiftCardID(){
        giftcardIDLabel.textColor = .black
        giftcardIDLabel.text = "Gift Card ID#: " + self.giftcardID
        giftcardIDLabel.numberOfLines = 1
        giftcardIDLabel.sizeToFit()
        self.addSubview(giftcardIDLabel)
    }
    func setupGiftCardIDConstraints(){
        self.giftcardIDLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.giftcardIDLabel.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            self.giftcardIDLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.giftcardIDLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
        ])
    }
    
    //MARK: BORDER
    func setupBorder(){
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    
    
}
