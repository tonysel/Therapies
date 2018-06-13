//
//  CreateSOSViewController.swift
//  Tesi
//
//  Created by TonySellitto on 03/06/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit
import NotificationCenter

class CreateSOSViewController: UIViewController, FBManagerDelegate{
    func onSuccess() {
        let sweetAlert = SweetAlert.init()
        sweetAlert.showAlert("Success",subTitle: "La tua risposta è stata inoltrata con successo", style: .success)
        sweetAlert.animateAlert()
    }
    
    func onFailure() {
        let alert = UIAlertController(title: "Error", message: "Internet is not available", preferredStyle: UIAlertControllerStyle.alert)
        let bottoneOk = UIAlertAction ( title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(bottoneOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 48.0/255.0, green: 210.0/255.0, blue: 190.0/255.0, alpha: 0.2).cgColor
        let colorBottom = UIColor(red: 52.0/255.0, green: 147.0/255.0, blue: 196.0/255.0, alpha: 0.2).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorTop, colorBottom]
        gradientLayer.locations = [ 0.0, 0.83]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    let fbManager = FBManager()
    
    var placeHolder : String?
    
    @IBOutlet weak var textField : UITextField?{
        didSet {
            textField?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTappedForMyNumericTextField)))
        }
//        willSet{
//            textField?.placeholder
//        }
    }
    
    @objc func doneButtonTappedForMyNumericTextField() {
        print("Done");
        self.textField?.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y -= 155
                
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += 155
  
            }
        }
    }


    @IBOutlet weak var sosWithTestoButton: UIButton!
    @IBOutlet weak var sosVeloceButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fbManager.delegate = self
        
        self.textField?.placeholder = self.placeHolder
        
        NotificationCenter.default.addObserver(self, selector: #selector(SpecificTherapyViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SpecificTherapyViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.sosVeloceButton.layer.cornerRadius = 8
        self.sosWithTestoButton.layer.cornerRadius = 8
        self.sosVeloceButton.layer.borderWidth = 1
        self.sosVeloceButton.layer.borderColor = UIColor.white.cgColor
        self.sosWithTestoButton.layer.borderWidth = 1
        self.sosWithTestoButton.layer.borderColor = UIColor.white.cgColor
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sosVelocePressed(_ sender: UIButton) {
        self.fbManager.aggiungiRichiestaAiuto(medico: (appDelegate?.paziente!.getMedicoControllo())!, codice: (appDelegate?.qrCode!)!, nota: "Sos")
    }
    
    
    @IBAction func sosWithTextPressed(_ sender: UIButton)
    {
        if self.textField?.text != ""{
            self.fbManager.aggiungiRichiestaAiuto(medico: (appDelegate?.paziente!.getMedicoControllo())!, codice: (appDelegate?.qrCode!)!, nota: (self.textField?.text!)!)}
        else{ self.fbManager.aggiungiRichiestaAiuto(medico: (appDelegate?.paziente!.getMedicoControllo())!, codice: (appDelegate?.qrCode!)!, nota: self.placeHolder!)}
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
