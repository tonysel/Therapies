//
//  ViewController.swift
//  Tesi
//
//  Created by TonySellitto on 14/04/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit
import AVFoundation

class QRViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    
    var previewLayer: AVCaptureVideoPreviewLayer!

    var qrCodeFrameView: UIView?
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBAction func pressedBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    //@IBOutlet weak var bottomLabel: UILabel!
     @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var topView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bottomView.backgroundColor = .clear
        self.topView.backgroundColor = .clear

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
            metadataOutput.metadataObjectTypes = [.qr, .upce,.code39,
                                                  .code39Mod43,
                                                  AVMetadataObject.ObjectType.code93,
                                                  AVMetadataObject.ObjectType.code128,
                                                  AVMetadataObject.ObjectType.ean8,
                                                  AVMetadataObject.ObjectType.ean13,
                                                  AVMetadataObject.ObjectType.aztec,
                                                  AVMetadataObject.ObjectType.pdf417,
                                                  AVMetadataObject.ObjectType.itf14,
                                                  AVMetadataObject.ObjectType.dataMatrix,
                                                  AVMetadataObject.ObjectType.interleaved2of5]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        
        previewLayer.videoGravity = .resizeAspectFill
        
        view.layer.addSublayer(previewLayer)
        
        view.layer.addSublayer(bottomView.layer)
        
        view.layer.addSublayer(topView.layer)
        
        captureSession.startRunning()
        
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView)
            view.bringSubview(toFront: qrCodeFrameView)
        }
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
        
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
       //     messageLabel.text = "No QR code is detected"
            return
        }
        
        
        // If the found metadata is equal to the QR code metadata (or barcode) then update the status label's text and set the bounds
        
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
        
        //dismiss(animated: true)
    }
    
    func found(code: String) {
        
        if (appDelegate.isInternetAvailable()){
        
        PazientiDAO.existsQRCodeOnDB(qrCode: code){(founded) in
            
            if (founded == true){
                
                self.appDelegate.qrCode = code
               
                PazientiDAO.readCodiceFiscaleFromQRCode(qrCode: code){(codiceFiscale) in
               
                    let ac = UIAlertController(title: "Scanning Done", message: "CF paziente:" + codiceFiscale, preferredStyle: .alert)
                    
                    // add the actions (buttons)
                    ac.addAction(UIAlertAction(title: "Continue", style:.default, handler: { action in
                        switch action.style{
                        case .default:
                        
                            UserDefaults.standard.set(code, forKey: "qrCode")  //String
                            
                            //va alla main view dove si trovano tutte le features
                            self.performSegue(withIdentifier: "mainSegue", sender: nil)

                            
                        case .cancel:
                            print("cancel")
                            
                            self.viewDidLoad()
                            
                            
                        case .destructive:
                            print("destructive")
                        }
                    }))
                    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                        switch action.style{
                        case .default:

                            self.performSegue(withIdentifier: "mainSegue", sender: nil)
                            
                        case .cancel:
                            print("cancel")
                           
                            self.viewDidLoad()
                            
                        case .destructive:
                            print("destructive")
                        }
                    }))
                
                // show the alert
                self.present(ac, animated: true, completion: nil)
                }
             }
            else{
                let ac = UIAlertController(title: "Attention", message: "QRCode non valido", preferredStyle: .alert)
                
                // add the actions (buttons)
                ac.addAction(UIAlertAction(title: "Continue", style:.default, handler: { action in
                    switch action.style{
                    case .default:
                        self.viewDidLoad()
                    case .cancel:
                        print("cancel")
                    case .destructive:
                        print("destructive")
                    }
                }))
              
                // show the alert
                self.present(ac, animated: true, completion: nil)
            }
            }
        }
        else{
            
            appDelegate.showInternetAlert(view: self)
            
        }
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        switch UIDevice.current.orientation{
        case .portrait:
            return .portrait
        case .landscapeLeft:
            return .landscapeLeft
        case .landscapeRight:
            return .landscapeRight
        default:
            return .portrait
        }
    }
}

