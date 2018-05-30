//
//  SpecificTherapyViewController.swift
//  Tesi
//
//  Created by TonySellitto on 25/05/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit
import FirebaseStorage
import NotificationCenter

extension Date {
    func isBetween(date date1: Date, andDate date2: Date) -> Bool {
        return date1.compare(self).rawValue * self.compare(date2).rawValue >= 0
    }
}

extension UITextField {
    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))
        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()
        
        self.inputAccessoryView = toolbar
    }
    // Default actions:
    @objc func doneButtonTapped() { self.resignFirstResponder() }
    @objc func cancelButtonTapped() { self.resignFirstResponder() }
}

class SpecificTherapyViewController: UIViewController, UITextFieldDelegate, FBManagerDelegate{
    func onSuccess() {
//        let alert = UIAlertController(title: "Success", message: "Your forwarding was successful", preferredStyle: UIAlertControllerStyle.alert)
//        let bottoneOk = UIAlertAction ( title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
//        alert.addAction(bottoneOk)
//        self.present(alert, animated: true, completion: nil)
//        let coder =
        let sweetAlert = SweetAlert.init()
        sweetAlert.showAlert("Success",subTitle: "Your forwarding was successful", style: .success)
        sweetAlert.animateAlert()
//        sweetAlert.animatedView?.animate()
//        sweetAlert.buttons = UIButton(frame: CGRect()
    }
    
    func onFailure() {
        let alert = UIAlertController(title: "Error", message: "Internet is not available", preferredStyle: UIAlertControllerStyle.alert)
        let bottoneOk = UIAlertAction ( title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(bottoneOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    var medicineWithTime = MedicinaleWithTime()
    var terapiaNonFarmacologicaWithTime = TerapiaNonFarmacologicaWithTime()
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    let fbManager = FBManager()

    @IBOutlet weak var activityIndicatorForImage: UIActivityIndicatorView!
    @IBOutlet weak var valueTherapy: UILabel!
    @IBOutlet weak var nameTherapy: UILabel!
    @IBOutlet weak var sosButton: UIButton!
    
    @IBOutlet weak var textField: UITextField!{
        didSet {
        textField.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTappedForMyNumericTextField)))
        }
    }
    
    @objc func doneButtonTappedForMyNumericTextField() {
        print("Done");
        self.textField.resignFirstResponder()
    }
    
    @IBOutlet weak var dateTherapy: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y == 0{
                
                self.view.frame.origin.y -= 175
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += 175
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fbManager.delegate = self
        self.textField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(SpecificTherapyViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SpecificTherapyViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    
        self.doneButton.layer.cornerRadius = 8
        self.doneButton.layer.borderWidth = 1
        self.doneButton.layer.borderColor = UIColor.white.cgColor
        
        self.sosButton.layer.cornerRadius = 8
        self.sosButton.layer.borderWidth = 1
        self.sosButton.layer.borderColor = UIColor.white.cgColor
        
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        self.imageView.clipsToBounds = false
        self.imageView.layer.shadowColor = UIColor.black.cgColor
        self.imageView.layer.shadowOpacity = 1
        
        self.activityIndicatorForImage.isHidden = false
        self.activityIndicatorForImage.startAnimating()
        
        if medicineWithTime.getMedicinale().getNome() != ""{
            self.textField.isHidden = true
            self.nameTherapy.text! = medicineWithTime.getMedicinale().getNome()
            
            self.valueTherapy.text! = "\(medicineWithTime.getDosaggio()!) \(medicineWithTime.getMedicinale().getMisuraDosaggio())"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat! = "yyyy-MM-dd HH:mm"
            
            self.dateTherapy.text! = dateFormatter.string(from: medicineWithTime.getTime()!)
            
            if CoreDataController.shared.existsImageFromName(nameImage: nameTherapy.text!){
                
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: CoreDataController.shared.loadImageFromName(nameImage: self.nameTherapy.text!))
                    self.activityIndicatorForImage.isHidden = true
                    self.activityIndicatorForImage.stopAnimating()
                }
                
            }
                
            else{
                
                //download image
                let imageRef: StorageReference = Storage.storage().reference()
                let child = imageRef.child("\(medicineWithTime.getMedicinale().getNome()).png")
                child.getData(maxSize: INT64_MAX, completion: {data, error in
                    if error != nil {
                        print(error?.localizedDescription as Any)
                    }
                    
                    if data == nil{
                        
                        DispatchQueue.main.async {
                            self.imageView.image = UIImage(named: "genericDrug")
                            self.activityIndicatorForImage.isHidden = true
                            self.activityIndicatorForImage.stopAnimating()
                        }
                        
                    }
                    else{
                        let image = UIImage(data: data!)
                        DispatchQueue.main.async {
                            self.imageView.image = image
                            self.activityIndicatorForImage.isHidden = true
                            self.activityIndicatorForImage.stopAnimating()
                            CoreDataController.shared.aggiungiImage(image: data! as NSData, name: self.nameTherapy.text!)
                        }
                    }
                })
            }
            // Do any additional setup after loading the view.
        }
        else{
            self.textField.isHidden = false
            self.valueTherapy.isHidden = true
            self.nameTherapy.text! = terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getNome()
            
            self.valueTherapy.text! = "Put on it"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat! = "yyyy-MM-dd HH:mm"
            
            self.dateTherapy.text! = dateFormatter.string(from: terapiaNonFarmacologicaWithTime.getTime()!)
        
            if terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getNome() == "Controllo glicemia"{
                DispatchQueue.main.async {
                    self.imageView.image = #imageLiteral(resourceName: "syringe")
                    self.activityIndicatorForImage.isHidden = true
                    self.activityIndicatorForImage.stopAnimating()
                    self.textField.placeholder = "mg/dL"
                }
            }
            else if terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getNome() == "Controllo peso"{
                DispatchQueue.main.async {
                    self.imageView.image = #imageLiteral(resourceName: "scale")
                    self.activityIndicatorForImage.isHidden = true
                    self.activityIndicatorForImage.stopAnimating()
                    self.textField.placeholder = "Kg"
                }
            }
            else{
                DispatchQueue.main.async {
                    self.textField.isHidden = true
                    self.imageView.image = #imageLiteral(resourceName: "water")
                    self.activityIndicatorForImage.isHidden = true
                    self.activityIndicatorForImage.stopAnimating()
                }
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {

        //ho passato dal segue un medicinale
        if medicineWithTime.getMedicinale().getNome() != ""{
            if !CoreDataController.shared.existsMedicinaleWithTimeFromId(id: medicineWithTime.getId()!){
                
                CoreDataController.shared.aggiungiMedicinaleWithTime(medicineWithTime: medicineWithTime)
//                let alert = UIAlertController(title: "Success", message: "Success", preferredStyle: UIAlertControllerStyle.alert)
//                let bottoneOk = UIAlertAction ( title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
//                alert.addAction(bottoneOk)
//                self.present(alert, animated: true, completion: nil)
                
                let sweetAlert = SweetAlert.init()
                sweetAlert.showAlert("Success",subTitle: "The therapy has been successfully completed", style: .success)
                sweetAlert.animateAlert()
                
            }
            else{
                if medicineWithTime.getTipoOrario() == "orario_libero"{
                    if CoreDataController.shared.loadMedicinaleWithOrarioLiberoFromId(id: medicineWithTime.getId()!).ripetizioni < medicineWithTime.getRipetizioni()! && CoreDataController.shared.loadMedicinaleWithOrarioLiberoFromId(id: medicineWithTime.getId()!).ripetizioni >= 1{
                        CoreDataController.shared.aggiungiRipetizioneMedicinaleWithTimeWithOrarioLibero(medicineWithTime: medicineWithTime)
                    }
                    else{
                        let alert = UIAlertController(title: "Error", message: "Hai superato il numero di ripetizioni per questo medicinale", preferredStyle: UIAlertControllerStyle.alert)
                        let bottoneOk = UIAlertAction ( title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
                        alert.addAction(bottoneOk)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                else{
//                    let alert = UIAlertController(title: "Error", message: "This therapy is registered already", preferredStyle: UIAlertControllerStyle.alert)
//                    let bottoneOk = UIAlertAction ( title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
//                    alert.addAction(bottoneOk)
//                    self.present(alert, animated: true, completion: nil)
                    let sweetAlert = SweetAlert.init()
                    sweetAlert.showAlert("Error",subTitle: "This therapy is registered already", style: .error)
                    sweetAlert.animateAlert()
                    
                }
            }
        }
        //ho passato dal segue una terapia non farmacologica
        else{
            if self.textField.text != "" {
                if !CoreDataController.shared.existsTerapiaNonFarmacologicaWithTimeFromId(id: terapiaNonFarmacologicaWithTime.getId()!){
                
                    let formatter = NumberFormatter()
                    formatter.decimalSeparator = ","
                    let grade = formatter.number(from: self.textField.text!)
                    if let doubleGrade = grade?.doubleValue{
                        terapiaNonFarmacologicaWithTime.aggiungiValue(value: doubleGrade)
                        CoreDataController.shared.aggiungiTerapiaNonFarmacologicaWithTime(terapiaNonFarmacologicaWithTime: terapiaNonFarmacologicaWithTime)
                        self.fbManager.aggiungiDiarioTerapieNonFarmacologiche(nomeTerapia: self.terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getNome(), risultato: doubleGrade, qrCode: (self.appDelegate?.qrCode)!)
                    }
                    else{
                        print("not parseable value in text field")
                    }
                    
                }
                else{
//                    let alert = UIAlertController(title: "Error", message: "This therapy is registered already", preferredStyle: UIAlertControllerStyle.alert)
//                    let bottoneOk = UIAlertAction ( title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
//                    alert.addAction(bottoneOk)
//                    self.present(alert, animated: true, completion: nil)
                    
                    let sweetAlert = SweetAlert.init()
                    sweetAlert.showAlert("Error",subTitle: "This therapy is registered already", style: .error)
                    sweetAlert.animateAlert()
                }
            }
            else{
                let alert = UIAlertController(title: "Error", message: "Text field has to be full", preferredStyle: UIAlertControllerStyle.alert)
                let bottoneOk = UIAlertAction ( title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(bottoneOk)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    
    @IBAction func sosButtonPressed(_ sender: UIButton) {
        fbManager.aggiungiRichiestaAiuto(medico: (appDelegate?.paziente!.getMedicoControllo())!, codice: (appDelegate?.qrCode!)!, nota: "Sos")
    }
    
    @IBAction func unwindToViewController(segue: UIStoryboardSegue){
        print("Torno indietro al ViewController verde")
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
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
