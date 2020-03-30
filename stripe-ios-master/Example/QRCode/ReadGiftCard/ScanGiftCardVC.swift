//
//  ScanGiftCardVC.swift
//  NewGiftCards
//
//  Created by Mohit Katyal on 3/25/20.
//  Copyright © 2020 Mohit Katyal. All rights reserved.
//

import AVFoundation
import UIKit

class ScanGiftCardVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    //MARK: MY INFO AND FUNCTIONS
    let customerID = "123"
    let restID = "789"
    let cardID = "456"
    
    
    var verificationLabel = UILabel()
    func setupFailureLabel(){
        self.verificationLabel.isHidden = true
        self.verificationLabel.text = "Giftcard Not Recognized For This Restaurant"
        self.verificationLabel.textColor = .black
        self.verificationLabel.font = self.verificationLabel.font.withSize(36)
        self.verificationLabel.numberOfLines = 0
        self.verificationLabel.backgroundColor = .white
        self.verificationLabel.textAlignment = .center
        self.verificationLabel.layer.cornerRadius = 20
        self.verificationLabel.clipsToBounds = true
        self.view.addSubview(verificationLabel)
        setupLabelConstraint()
    }
    func setupLabelConstraint(){
        self.verificationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.verificationLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.verificationLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.verificationLabel.heightAnchor.constraint(equalToConstant: 200),
            self.verificationLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
        
    }
    
    
    func verifyCode(code: String) {
        if let data = code.data(using: .utf8) {
            do {
                if let code = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String] {
                    
//                    if code["custID"] == self.customerID && code["restID"] == self.restID && code["cardID"] == self.cardID {
                    if true {
                        //TODO: GO TO NEXT SCREEN
                        print("Success")
//                        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProcessGiftCard") as! ProcessGiftCardVC
//                        self.navigationController?.pushViewController(secondViewController, animated: true)
                        
                        let secondViewController = ProcessGiftCardVC()
                        navigationController?.pushViewController(secondViewController, animated: true)
                    } else {
                        print(code)
                        //TODO: GIFT CARD NOT RECOGNIZED FOR THIS RESTAURANT
                        print("fail")
                        verificationLabel.isHidden = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // Change `2.0` to the desired
                            self.captureSession.startRunning()
                            self.verificationLabel.isHidden = true
                        }
                    }
                }
            } catch {
                //TODO: QR CODE NOT RECOGNIZED ERROR
                print(error.localizedDescription)
            }
        }
    }
    
    func setupNavigationBar(){
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "Scan Gift Card"
    }


    //MARK: SCANNER CONTROLLER
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        captureSession.startRunning()
        
        setupNavigationBar()
        setupFailureLabel()
    }

    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            verifyCode(code: stringValue)
        }

    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}


