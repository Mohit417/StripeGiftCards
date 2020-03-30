//
//  QRCodeVC.swift
//  NewGiftCards
//
//  Created by Mohit Katyal on 3/25/20.
//  Copyright © 2020 Mohit Katyal. All rights reserved.
//

import UIKit

class QRCodeVC: UIViewController {
    
    //MARK: Infomation For the debit card
    let customerID = "123"
    let restID = "789"
    let cardID = "456"
    var sCardKey = "" //one time pad
    
    //MARK: UI COMPONENTS

    let imageView = UIImageView()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setSCardKey()
        setupImageView()
    }
    
    override func viewDidLayoutSubviews() {
        setupImageViewConstraints()
    }
    
    //MARK: SETUP UI COMPONENTS
    
    func setupImageView(){
        self.imageView.image = QRCodeVC.generateQRImage(restID: self.restID, cardID: self.cardID)
        self.view.addSubview(self.imageView)
    }
    func setupImageViewConstraints(){
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.imageView.heightAnchor.constraint(equalToConstant: 300),
            self.imageView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    
    //MARK: GENERATE QR CODE
    
    func setSCardKey() {
        self.sCardKey = QRCodeVC.convertByteArrayToString(bytes: QRCodeVC.generate32ByteKey())
    }
    
    static func generate32ByteKey() -> [Int8] {
        var bytes = [Int8](repeating: 0, count: 32)
        let status = SecRandomCopyBytes(kSecRandomDefault, bytes.count, &bytes)

        if status == errSecSuccess {
            print(bytes)
            return bytes
        }
            
        //TODO: Failure
        return []
    }
    
    static func convertByteArrayToString(bytes: [Int8]) -> String{
        
        var string = ""
        for byte in bytes {
            string += String(byte)
        }
        return string
    }

    //TODO: Can I change my rate of error correction?
    static func generateQRImage(restID: String, cardID: String) -> UIImage? {
        let information: [String:String] = ["custID": "123", "restID": restID, "cardID": cardID, "sCardKey": convertByteArrayToString(bytes: generate32ByteKey())]
                
        var json = Data()
        
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: information,
            options: []) {
            
            json = theJSONData
        }
        
       // let data = theJSONData.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
                        
            filter.setValue("H", forKey: "inputCorrectionLevel")
            filter.setValue(json, forKey: "inputMessage")
            
            
            print(filter.attributes)
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
    


}
