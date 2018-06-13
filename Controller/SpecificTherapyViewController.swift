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

class SpecificTherapyViewController: UIViewController, UITextFieldDelegate, FBManagerDelegate, CoreDataControllerDelegate{
    func onSuccessCore() {

    }
    
    func onSuccess() {

        let sweetAlert = SweetAlert.init()
        sweetAlert.showAlert("Success",subTitle: "La tua richiesta è stata inoltrata con successo", style: .success)
        sweetAlert.animateAlert()

    }
    
    func onFailure() {
        let alert = UIAlertController(title: "Error", message: "Internet is not available", preferredStyle: UIAlertControllerStyle.alert)
        let bottoneOk = UIAlertAction ( title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(bottoneOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 48.0/255.0, green: 210.0/255.0, blue: 190.0/255.0, alpha: 0.8).cgColor
        let colorBottom = UIColor(red: 52.0/255.0, green: 147.0/255.0, blue: 196.0/255.0, alpha: 0.8).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorTop, colorBottom]
        //gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        //gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.locations = [ 0.0, 0.83]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @IBOutlet weak var backgroundView: UIView!
    
    
    @IBAction func infoButtonPressed(_ sender: UIButton) {
        let sweetAlert = SweetAlert.init()
        if medicineWithTime.getMedicinale().getNome() != ""{
            
            sweetAlert.showAlert("Codice Terapia: \(medicineWithTime.getCodiceTerapia()!)",subTitle: medicineWithTime.getRaccomandazioni(), style: .success)
        }
        if terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getNome() != ""{
            sweetAlert.showAlert("Codice Terapia: \(terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getCodice())",subTitle: terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getRaccomandazioni(), style: .success)
        }
    }
    
    var medicineWithTime = MedicinaleWithTime()
    var terapiaNonFarmacologicaWithTime = TerapiaNonFarmacologicaWithTime()
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    let fbManager = FBManager()
    let coreDataController = CoreDataController()

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
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y -= 175
//                self.backgroundView.frame.origin.y -= 175
                
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y != 0{
                 self.view.frame.origin.y += 175
//                 self.backgroundView.frame.origin.y += 175
            }
        }
    }
//
    override func viewWillAppear(_ animated: Bool) {
        
        self.definesPresentationContext = true
//
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.prefersLargeTitles = false

    }
//
//    override func viewDidAppear(_ animated: Bool) {
//
//        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
//        self.navigationController?.navigationBar.barTintColor = .white
//
//        self.navigationController?.navigationBar.prefersLargeTitles = false
//
//    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fbManager.delegate = self
        self.coreDataController.delegate = self
        
        self.textField.delegate = self
        
        self.setGradientBackground()
        
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
        
        self.backgroundView.layer.cornerRadius = 15
        self.backgroundView.layer.shadowColor = UIColor.darkGray.cgColor
        self.backgroundView.layer.shadowOpacity = 0.6
        self.backgroundView.layer.shadowOffset = CGSize(width: backgroundView.frame.width + 20, height: backgroundView.frame.height + 20)
        
        self.activityIndicatorForImage.isHidden = false
        self.activityIndicatorForImage.startAnimating()
        
        if medicineWithTime.getMedicinale().getNome() != ""{
            self.textField.isHidden = true
            self.nameTherapy.text! = medicineWithTime.getMedicinale().getNome()
            
            self.valueTherapy.text! = "\(medicineWithTime.getDosaggio()!) \(medicineWithTime.getMedicinale().getMisuraDosaggio())"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat! = "yyyy-MM-dd HH:mm"
            
            if medicineWithTime.getTipoOrario() == "orario_approssimato"{
                self.dateTherapy.text! = "\(TraslationManager.loadDayName(forDate: medicineWithTime.getTime()!)) - Orario Approssimato"}
            else if medicineWithTime.getTipoOrario() == "orario_libero"{
                self.dateTherapy.text! = "\(TraslationManager.loadDayName(forDate: medicineWithTime.getTime()!)) - Orario Libero"}
            else{self.dateTherapy.text! = "\(TraslationManager.loadDayName(forDate: medicineWithTime.getTime()!)) \(dateFormatter.string(from: medicineWithTime.getTime()!))"}
            
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
            
//            self.dateTherapy.text! = dateFormatter.string(from: terapiaNonFarmacologicaWithTime.getTime()!)
            if terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getTipoOrario() == "orario_approssimato"{
                self.dateTherapy.text! = "\(TraslationManager.loadDayName(forDate: terapiaNonFarmacologicaWithTime.getTime()!)) - Orario Approssimato"}
            else if terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getTipoOrario() == "orario_libero"{
                self.dateTherapy.text! = "\(TraslationManager.loadDayName(forDate: terapiaNonFarmacologicaWithTime.getTime()!)) - Orario Libero"}
            else{
                self.dateTherapy.text! = "\(TraslationManager.loadDayName(forDate: terapiaNonFarmacologicaWithTime.getTime()!)) \(dateFormatter.string(from: terapiaNonFarmacologicaWithTime.getTime()!))"}
        
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
    
//    override func viewDidDisappear(_ animated: Bool) {
//        self.textField.text = ""
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        
//        self.keyboardWillHide(notification: NSNotification.)


        //ho passato dal segue un medicinale
        if medicineWithTime.getMedicinale().getNome() != ""{
            
            if !CoreDataController.shared.existsMedicinaleWithTimeFromId(id: medicineWithTime.getId()!){
                
                CoreDataController.shared.aggiungiMedicinaleWithTime(medicineWithTime: medicineWithTime)
                
                let sweetAlert = SweetAlert.init()
                sweetAlert.showAlert("Success",subTitle: "Questo medicinale è stato assunto con successo", style: .success)
                sweetAlert.animateAlert()
                
            }
            else{
                if medicineWithTime.getTipoOrario() == "orario_libero"{
                    if CoreDataController.shared.loadMedicinaleWithOrarioLiberoFromId(id: medicineWithTime.getId()!).ripetizioni < medicineWithTime.getRipetizioni()! - 1 && CoreDataController.shared.loadMedicinaleWithOrarioLiberoFromId(id: medicineWithTime.getId()!).ripetizioni >= 1{

                        CoreDataController.shared.aggiungiRipetizioneMedicinaleWithTimeWithOrarioLibero(medicineWithTime: self.medicineWithTime)
                        
                        let sweetAlert = SweetAlert.init()
                        sweetAlert.showAlert("Success",subTitle: "Devi assumerlo ancora \(medicineWithTime.getRipetizioni()! - Int(CoreDataController.shared.loadMedicinaleWithOrarioLiberoFromId(id: medicineWithTime.getId()!).ripetizioni)) volte", style: .success)
                        sweetAlert.animateAlert()

                    }
                    else if CoreDataController.shared.loadMedicinaleWithOrarioLiberoFromId(id: medicineWithTime.getId()!).ripetizioni == medicineWithTime.getRipetizioni()! - 1 && CoreDataController.shared.loadMedicinaleWithOrarioLiberoFromId(id: medicineWithTime.getId()!).ripetizioni >= 1{
                        CoreDataController.shared.aggiungiRipetizioneMedicinaleWithTimeWithOrarioLibero(medicineWithTime: self.medicineWithTime)
                        
                        let sweetAlert = SweetAlert.init()
                        sweetAlert.showAlert("Success",subTitle: "Hai finito con l'assunzione di questo medicinale", style: .success)
                        sweetAlert.animateAlert()
                    }
                    else{

                        let sweetAlert = SweetAlert.init()
                        sweetAlert.showAlert("Attenzione",subTitle: "Hai superato il numero di ripetizioni per questo medicinale", style: .warning)
                        sweetAlert.animateAlert()
                    }
                }
                else{

                    let sweetAlert = SweetAlert.init()
                    sweetAlert.showAlert("Attenzione",subTitle: "Questo medicinale è già stato\nassunto", style: .warning)
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
                    
                    
                    if terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getTipoOrario() == "orario_libero"{
                        if CoreDataController.shared.loadTerNonFarmWithOrarioLiberoFromId(id: terapiaNonFarmacologicaWithTime.getId()!).ripetizioni < terapiaNonFarmacologicaWithTime.getRipetizioni()! - 1 && CoreDataController.shared.loadTerNonFarmWithOrarioLiberoFromId(id: terapiaNonFarmacologicaWithTime.getId()!).ripetizioni >= 1{
                            
                            CoreDataController.shared.aggiungiRipetizioneMedicinaleWithTimeWithOrarioLibero(medicineWithTime: self.medicineWithTime)
                            
                            let sweetAlert = SweetAlert.init()
                            sweetAlert.showAlert("Success",subTitle: "Devi farlo ancora \(terapiaNonFarmacologicaWithTime.getRipetizioni()! - Int(CoreDataController.shared.loadTerNonFarmWithOrarioLiberoFromId(id: terapiaNonFarmacologicaWithTime.getId()!).ripetizioni)) volte", style: .success)
                            sweetAlert.animateAlert()
                            
                        }
                        else if CoreDataController.shared.loadTerNonFarmWithOrarioLiberoFromId(id: terapiaNonFarmacologicaWithTime.getId()!).ripetizioni == terapiaNonFarmacologicaWithTime.getRipetizioni()! - 1 && CoreDataController.shared.loadTerNonFarmWithOrarioLiberoFromId(id: terapiaNonFarmacologicaWithTime.getId()!).ripetizioni >= 1{

                            CoreDataController.shared.aggiungiRipetizioneTerapiaNonFarmacologicaWithTimeWithOrarioLibero(terapiaNonFarmacologicaWithTime: self.terapiaNonFarmacologicaWithTime)
                            let sweetAlert = SweetAlert.init()
                            sweetAlert.showAlert("Success",subTitle: "Hai finito con con questa terapia non farmacologica", style: .success)
                            sweetAlert.animateAlert()
                        }
                        else{
//                            let alert = UIAlertController(title: "Attenzione", message: "Hai superato il numero di ripetizioni per questa terapia non farmacologica", preferredStyle: UIAlertControllerStyle.alert)
//                            let bottoneOk = UIAlertAction ( title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
//                            alert.addAction(bottoneOk)
//                            self.present(alert, animated: true, completion: nil)
                            let sweetAlert = SweetAlert.init()
                            sweetAlert.showAlert("Attenzione",subTitle: "Hai superato il numero di ripetizioni per questa terapia non farmacologica", style: .warning)
                            sweetAlert.animateAlert()
                        }
                    }
                    else{
                        
                        let sweetAlert = SweetAlert.init()
                        sweetAlert.showAlert("Attenzione",subTitle: "Questa terapia è già stata assunta", style: .warning)
                        sweetAlert.animateAlert()
                        
                    }
                
                }
            }
            else{
                
                if (terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getNome().contains("Bere") || terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getNome().contains("Utilizzo")) && !CoreDataController.shared.existsTerapiaNonFarmacologicaWithTimeFromId(id: terapiaNonFarmacologicaWithTime.getId()!){
                    terapiaNonFarmacologicaWithTime.aggiungiValue(value: 0)
                    CoreDataController.shared.aggiungiTerapiaNonFarmacologicaWithTime(terapiaNonFarmacologicaWithTime: terapiaNonFarmacologicaWithTime)
                    let sweetAlert = SweetAlert.init()
                    sweetAlert.showAlert("Success",subTitle: "Questa terapia è stata eseguita\ncon successo", style: .success)
                    sweetAlert.animateAlert()
                }
                else if (terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getNome().contains("Bere") || terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getNome().contains("Utilizzo")) && CoreDataController.shared.existsTerapiaNonFarmacologicaWithTimeFromId(id: terapiaNonFarmacologicaWithTime.getId()!){
                    let sweetAlert = SweetAlert.init()
                    sweetAlert.showAlert("Attenzione",subTitle: "Questa terapia è già stata assunta", style: .warning)
                    sweetAlert.animateAlert()
                }
                else{
                    let alert = UIAlertController(title: "Error", message: "Text field has to be full", preferredStyle: UIAlertControllerStyle.alert)
                    let bottoneOk = UIAlertAction ( title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(bottoneOk)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sosSegue"{
            let vcDestination = segue.destination as! CreateSOSViewController
            let dateFormatter = DateFormatter.init()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            //ho passato dal segue un medicinale
            
            if medicineWithTime.getMedicinale().getNome() != ""{
                let stringDate = dateFormatter.string(from: medicineWithTime.getTime()!)
                vcDestination.placeHolder = "\(medicineWithTime.getMedicinale().getNome()) \(stringDate)"
                print("\(medicineWithTime.getMedicinale().getNome()) \(medicineWithTime.getTime() ?? Date())")
            }
            else{
                let stringDate = dateFormatter.string(from: terapiaNonFarmacologicaWithTime.getTime()!)
                vcDestination.placeHolder = "\(terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getNome()) \(stringDate)"
            }
        }
    }

    
    
//    @IBAction func sosButtonPressed(_ sender: UIButton) {
//        fbManager.aggiungiRichiestaAiuto(medico: (appDelegate?.paziente!.getMedicoControllo())!, codice: (appDelegate?.qrCode!)!, nota: "Sos")
//    }
    
//    @IBAction func unwindToViewController(segue: UIStoryboardSegue){
//        print("Torno indietro al ViewController verde")
//        
//        navigationController?.navigationBar.prefersLargeTitles = true
//        
//    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
