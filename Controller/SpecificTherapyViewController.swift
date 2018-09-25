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

//extension Date {
//    func isBetween(date date1: Date, andDate date2: Date) -> Bool {
//        return date1.compare(self).rawValue * self.compare(date2).rawValue >= 0
//    }
//}

extension Date{
    func days(from_date: Date) -> Int {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let dateFormatter3 = DateFormatter.init()
        dateFormatter3.dateFormat = "yyyy-MM-dd HH:mm"
        
        let finalTime = dateFormatter3.date(from: "\(dateFormatter.string(from: self)) 00:00")
        
        return Calendar.current.dateComponents([.day], from: from_date, to: finalTime!).day ?? 0
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

class SpecificTherapyViewController: UIViewController, UITextFieldDelegate, FBManagerDelegate, CoreDataControllerDelegate, PopUpViewControllerDelegate{
   
    func onCancel() {

        UIView.animate(withDuration: 0.5, animations: {
            self.contentView.frame.origin.y = self.contentView.frame.origin.y - self.view.frame.height - self.contentView.frame.height/3
            self.blurView.alpha = 0
        }, completion: {(_) in

            self.popUp?.imageView.removeFromSuperview()
            self.popUp?.textLabel.removeFromSuperview()
            self.popUp?.cancelButton.removeFromSuperview()
            self.popUp?.view.removeFromSuperview()
            self.blurView.removeFromSuperview()
            self.contentView.removeFromSuperview()
            self.enableContentView = false
            self.view.isUserInteractionEnabled = true
//            NotificationCenter.default.removeObserver(self, name: NSNotification.Name("sposta"), object: nil)
        })
    }
    
    func onSuccessCore() {

    }
    
    func onSuccess() {

        let sweetAlert = SweetAlert.init()
        debugPrint(sweetAlert.showAlert("Success",subTitle: "La tua richiesta è stata inoltrata con successo", style: .success))
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
    @IBOutlet weak var infoButton: UIButton!
    
    var popUp : PopUpViewController?
    
    var enableContentView = false
    
    @IBOutlet weak var backgroundView: UIView!
    
    var panGesture = UIPanGestureRecognizer()
    
    @objc func draggedView(_ sender: UIPanGestureRecognizer){
        
//        if contentView.center.y < (self.view.frame.height - self.contentView.frame.height/2) && self.contentView.center.y > self.contentView.frame.height/2 && contentView.center.x < (self.view.frame.width - self.contentView.frame.width/2) && self.contentView.center.x > self.contentView.frame.width/2{
//
            self.view.bringSubview(toFront: contentView)
            let translation = sender.translation(in: self.view)
            contentView.center = CGPoint(x: contentView.center.x + translation.x, y: contentView.center.y + translation.y)

            sender.setTranslation(CGPoint.zero, in: self.view)
//
//        }
        
//        else if contentView.center.y >= (self.view.frame.height - self.contentView.frame.height/2) || self.contentView.center.y >= self.contentView.frame.height/2 || self.contentView.center.x >= (self.view.frame.width - self.contentView.frame.width/2) || self.contentView.center.x == self.contentView.frame.width/2{
//            if contentView.center.y == (self.view.frame.height - self.contentView.frame.height/2){
//                contentView.center = CGPoint(x: contentView.center.x, y: contentView.center.y - 0.001)
//            }
//            else if contentView.center.y == self.contentView.frame.height/2{
//                contentView.center = CGPoint(x: contentView.center.x, y: contentView.center.y + 0.001)
//            }
//            else if contentView.center.x == (self.view.frame.width - self.contentView.frame.height/2){
//                contentView.center = CGPoint(x: contentView.center.x - 0.001, y: contentView.center.y)
//            }
//            else{
//                contentView.center = CGPoint(x: contentView.center.x + 0.001, y: contentView.center.y)
//            }
//
//        }

        
//        if sender.state == UIGestureRecognizerState.ended{
//
//                  contentView.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY/2)
//
//        }

//        var rect = contentView.frame.intersection(self.view.frame)
//        if rect.height == contentView.frame.height || rect.width == contentView.frame.width{
//            self.view.bringSubview(toFront: contentView)
//            let translation = sender.translation(in: self.view)
//            contentView.center = CGPoint(x: contentView.center.x + translation.x, y: contentView.center.y + translation.y)
//            //
//            sender.setTranslation(CGPoint.zero, in: self.view)
//        }
        
    }

    @IBAction func infoButtonPressed(_ sender: UIButton){

        self.view.isUserInteractionEnabled = false
        
        self.blurView = UIVisualEffectView()
        
        self.blurView.effect = UIBlurEffect(style: .light)
        
        self.blurView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        self.blurView.bounds = UIScreen.main.bounds
        
        self.blurView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        self.view.layer.insertSublayer((self.blurView.layer), at: 2)
        
        self.contentView = UIView()
        
//        self.contentView.frame = CGRect(x: 0, y: 0, width: 272, height: 314)
        
        self.contentView.frame.size = CGSize(width: 275, height: 331)
        
        self.contentView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        self.view.layer.insertSublayer(self.contentView.layer, at: 3)
        
        self.view.addSubview(self.contentView)
        
//        self.contentView.isUserInteractionEnabled = true
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        self.enableContentView = true
        
        let horizontalConstraint = NSLayoutConstraint(item: self.contentView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: self.contentView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: -40)
        let widthConstraint = NSLayoutConstraint(item: self.contentView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 275)
        let heightConstraint = NSLayoutConstraint(item: self.contentView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 380)

        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        self.panGesture = UIPanGestureRecognizer(target: self, action: #selector(SpecificTherapyViewController.draggedView(_:)))
//        self.contentView.isUserInteractionEnabled = true
        self.contentView.addGestureRecognizer(panGesture)
        
        self.blurView.alpha = 0
    
        let popUp = storyboard?.instantiateViewController(withIdentifier: "popUpViewController") as! PopUpViewController
    
        
        self.popUp = popUp
        
        self.popUp?.delegate = self
    
//        self.popUp?.modalPresentationStyle = .formSheet
        
        self.popUp?.image = imageView.image!
        
        self.addChildViewController(popUp)
//
        if terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getNome() != ""{
            self.popUp?.textLabel.text = "\(terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getNome())\n\nCodice Terapia: \(terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getCodice())"
        }
            //quindi nel view controller ho un medicinale
        else{
            self.popUp?.textLabel.text = "\(medicineWithTime.getMedicinale().getNome())\n\nCodice Medicinale: \(medicineWithTime.getMedicinale().getCodice())\n\nCodice Terapia: \(medicineWithTime.getCodiceTerapia()!)\n\nDosaggio: \(medicineWithTime.getDosaggio()!) \(medicineWithTime.getMedicinale().getMisuraDosaggio())"
        }
         self.contentView.addSubview((popUp.view)!)
        //make sure that the child view controller's view is the right size
        self.popUp?.view.frame = self.contentView.bounds
        
        self.view.isUserInteractionEnabled = true
        
        UIView.animate(withDuration: 0.4, animations: {
            self.blurView.alpha = 1
        }, completion: {(_) in
            
        })
        
        UIView.animate(withDuration: 0.5, animations: {
            self.contentView.frame.origin.y = self.contentView.frame.origin.y + self.view.frame.height/2 + self.contentView.frame.height/3
        }, completion: {(_) in
            //you must call this at the end per Apple's documentation
            popUp.didMove(toParentViewController: self)
            
        })
        
    }
    
    var contentView : UIView!
    var blurView : UIVisualEffectView!
    
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
    
    var showed : Bool = false
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil{
            
            if self.view.frame.origin.y >= 0 {
                self.view.frame.origin.y -= 175
//                self.backgroundView.frame.origin.y -= 175
                
            }
        }
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y <= 0{
                 self.view.frame.origin.y += 175
//                 self.backgroundView.frame.origin.y += 175
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.definesPresentationContext = true

        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.backgroundView.layer.shadowColor = UIColor.black.cgColor
        self.backgroundView.layer.shadowOpacity = 0.35
        self.view.layer.insertSublayer(backgroundView.layer, at: 1)
    }
    
    @objc func backToMenu(){}

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fbManager.delegate = self
        self.coreDataController.delegate = self
        
        self.textField.delegate = self
       
        self.infoButton.isUserInteractionEnabled = false
        
//        let horizontalConstraint = NSLayoutConstraint(item: self.contentView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
//        let verticalConstraint = NSLayoutConstraint(item: self.contentView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: -114)
//        let widthConstraint = NSLayoutConstraint(item: self.contentView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 272)
//        let heightConstraint = NSLayoutConstraint(item: self.contentView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 314)

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
        self.imageView.layer.shadowOpacity = 0.6
        
        self.backgroundView.layer.cornerRadius = 15
        
//        self.backgroundView.layer.shadowColor = UIColor.darkGray.cgColor
//        self.backgroundView.layer.shadowOpacity = 0.6
//        self.backgroundView.layer.shadowOffset = CGSize(width: backgroundView.frame.width + 20, height: backgroundView.frame.height + 20)
        
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
                    self.infoButton.isUserInteractionEnabled = true
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
                            self.infoButton.isUserInteractionEnabled = true
                        }
                        
                    }
                    else{
                        let image = UIImage(data: data!)
                        DispatchQueue.main.async {
                            self.imageView.image = image
                            self.activityIndicatorForImage.isHidden = true
                            self.activityIndicatorForImage.stopAnimating()
                            CoreDataController.shared.aggiungiImage(image: data! as NSData, name: self.nameTherapy.text!)
                            self.infoButton.isUserInteractionEnabled = true
                        }
                    }
                })
            }
            // Do any additional setup after loading the view.
        }
        else{
            self.infoButton.isUserInteractionEnabled = true
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        
        let currentDate = Date()
        
        //pass medicinale
        if medicineWithTime.getMedicinale().getNome() != ""{
            
            if (medicineWithTime.getTipoOrario() == "orario_libero"  && !CoreDataController.shared.existsMedicinaleWithTimeFromId(id: medicineWithTime.getId()!) && currentDate.days(from_date: medicineWithTime.getTime()!) == 0) || ((medicineWithTime.getTipoOrario() == "orario_esatto")  && !CoreDataController.shared.existsMedicinaleWithTimeFromId(id: medicineWithTime.getId()!) && (currentDate >= medicineWithTime.getTime()!.addingTimeInterval(-1200) && medicineWithTime.getTime()!.addingTimeInterval(1200) >= currentDate))
            || ((medicineWithTime.getTipoOrario() == "orario_approssimato")  && !CoreDataController.shared.existsMedicinaleWithTimeFromId(id: medicineWithTime.getId()!) && (currentDate >= medicineWithTime.getTime()!.addingTimeInterval(-5400) && medicineWithTime.getTime()!.addingTimeInterval(5400) >= currentDate)){
            
                CoreDataController.shared.aggiungiMedicinaleWithTime(medicineWithTime: medicineWithTime)
                
                let sweetAlert = SweetAlert.init()
                debugPrint(sweetAlert.showAlert("Success",subTitle: "Questo medicinale è stato assunto con successo", style: .success))
                sweetAlert.animateAlert()
                
            }
            else{
                if medicineWithTime.getTipoOrario() == "orario_libero" && currentDate.days(from_date: medicineWithTime.getTime()!) == 0{
                    if (CoreDataController.shared.loadMedicinaleWithOrarioLiberoFromId(id: medicineWithTime.getId()!).ripetizioni < medicineWithTime.getRipetizioni()! - 1 && CoreDataController.shared.loadMedicinaleWithOrarioLiberoFromId(id: medicineWithTime.getId()!).ripetizioni >= 1){
                        CoreDataController.shared.aggiungiRipetizioneMedicinaleWithTimeWithOrarioLibero(medicineWithTime: self.medicineWithTime)
                        
                        let sweetAlert = SweetAlert.init()
                        debugPrint(sweetAlert.showAlert("Success",subTitle: "Devi assumerlo ancora \(medicineWithTime.getRipetizioni()! - Int(CoreDataController.shared.loadMedicinaleWithOrarioLiberoFromId(id: medicineWithTime.getId()!).ripetizioni)) volte", style: .success))
                        sweetAlert.animateAlert()

                    }
                    else if (CoreDataController.shared.loadMedicinaleWithOrarioLiberoFromId(id: medicineWithTime.getId()!).ripetizioni == medicineWithTime.getRipetizioni()! - 1 && CoreDataController.shared.loadMedicinaleWithOrarioLiberoFromId(id: medicineWithTime.getId()!).ripetizioni >= 1){
                        CoreDataController.shared.aggiungiRipetizioneMedicinaleWithTimeWithOrarioLibero(medicineWithTime: self.medicineWithTime)
                        
                        let sweetAlert = SweetAlert.init()
                        debugPrint(sweetAlert.showAlert("Success",subTitle: "Hai finito con l'assunzione di questo medicinale", style: .success))
                        sweetAlert.animateAlert()
                    }
                    else {
                        let sweetAlert = SweetAlert.init()
                        debugPrint(sweetAlert.showAlert("Attenzione",subTitle: "Hai superato il numero di ripetizioni per questo medicinale", style: .warning))
                        sweetAlert.animateAlert()
                    }
                
                }
                else if (medicineWithTime.getTipoOrario() == "orario_libero" && currentDate.days(from_date: medicineWithTime.getTime()!) != 0){
                    let sweetAlert = SweetAlert.init()
                    debugPrint(sweetAlert.showAlert("Attenzione",subTitle: "Non è tempo di assumere questo medicinale", style: .warning))
                    sweetAlert.animateAlert()
                }
                else if ((medicineWithTime.getTipoOrario() == "orario_esatto")
                    && (currentDate < medicineWithTime.getTime()!.addingTimeInterval(-1200) )  && !CoreDataController.shared.existsMedicinaleWithTimeFromId(id: medicineWithTime.getId()!)) || ((medicineWithTime.getTipoOrario() == "orario_approssimato")
                        && (currentDate < medicineWithTime.getTime()!.addingTimeInterval(-5400))  && !CoreDataController.shared.existsMedicinaleWithTimeFromId(id: medicineWithTime.getId()!)){
                    let sweetAlert = SweetAlert.init()
                    debugPrint(sweetAlert.showAlert("Attenzione",subTitle: "Non è ancora tempo\ndi assumere questo medicinale", style: .warning))
                    sweetAlert.animateAlert()
                    
                }
                else if ((medicineWithTime.getTipoOrario() == "orario_esatto")
                    && (medicineWithTime.getTime()!.addingTimeInterval(1200) < currentDate)  && !CoreDataController.shared.existsMedicinaleWithTimeFromId(id: medicineWithTime.getId()!)) || ((medicineWithTime.getTipoOrario() == "orario_approssimato")
                        && (medicineWithTime.getTime()!.addingTimeInterval(5400) < currentDate)  && !CoreDataController.shared.existsMedicinaleWithTimeFromId(id: medicineWithTime.getId()!)){
                    let sweetAlert = SweetAlert.init()
                    debugPrint(sweetAlert.showAlert("Tempo Scaduto",subTitle: "Non è tempo\ndi assumere questo medicinale", style: .warning))
                    sweetAlert.animateAlert()
                    
                }
                else{
                    let sweetAlert = SweetAlert.init()
                    debugPrint(sweetAlert.showAlert("Attenzione",subTitle: "Questo medicinale è già stato\nassunto", style: .warning))
                    sweetAlert.animateAlert()
                }
            }
        }
            
        //pass terapia non farmacologica
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
                            debugPrint(sweetAlert.showAlert("Success",subTitle: "Devi farlo ancora \(terapiaNonFarmacologicaWithTime.getRipetizioni()! - Int(CoreDataController.shared.loadTerNonFarmWithOrarioLiberoFromId(id: terapiaNonFarmacologicaWithTime.getId()!).ripetizioni)) volte", style: .success))
                            sweetAlert.animateAlert()
                            
                        }
                        else if CoreDataController.shared.loadTerNonFarmWithOrarioLiberoFromId(id: terapiaNonFarmacologicaWithTime.getId()!).ripetizioni == terapiaNonFarmacologicaWithTime.getRipetizioni()! - 1 && CoreDataController.shared.loadTerNonFarmWithOrarioLiberoFromId(id: terapiaNonFarmacologicaWithTime.getId()!).ripetizioni >= 1{

                            CoreDataController.shared.aggiungiRipetizioneTerapiaNonFarmacologicaWithTimeWithOrarioLibero(terapiaNonFarmacologicaWithTime: self.terapiaNonFarmacologicaWithTime)
                            let sweetAlert = SweetAlert.init()
                            debugPrint(sweetAlert.showAlert("Success",subTitle: "Hai finito con con questa terapia non farmacologica", style: .success))
                            sweetAlert.animateAlert()
                        }
                        else{

                            let sweetAlert = SweetAlert.init()
                            debugPrint(sweetAlert.showAlert("Attenzione",subTitle: "Hai superato il numero di ripetizioni per questa terapia non farmacologica", style: .warning))
                            sweetAlert.animateAlert()
                        }
                    }
                    else{
                        
                        let sweetAlert = SweetAlert.init()
                        debugPrint(sweetAlert.showAlert("Attenzione",subTitle: "Questa terapia è già stata effettuata", style: .warning))
                        sweetAlert.animateAlert()
                        
                    }
                
                }
            }
            else{
                
                if (terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getNome().contains("Bere") || terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getNome().contains("Utilizzo")) && !CoreDataController.shared.existsTerapiaNonFarmacologicaWithTimeFromId(id: terapiaNonFarmacologicaWithTime.getId()!){
                    terapiaNonFarmacologicaWithTime.aggiungiValue(value: 0)
                    CoreDataController.shared.aggiungiTerapiaNonFarmacologicaWithTime(terapiaNonFarmacologicaWithTime: terapiaNonFarmacologicaWithTime)
                    let sweetAlert = SweetAlert.init()
                    debugPrint(sweetAlert.showAlert("Success",subTitle: "Questa terapia è stata eseguita\ncon successo", style: .success))
                    sweetAlert.animateAlert()
                }
                else if (terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getNome().contains("Bere") || terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getNome().contains("Utilizzo")) && CoreDataController.shared.existsTerapiaNonFarmacologicaWithTimeFromId(id: terapiaNonFarmacologicaWithTime.getId()!){
                    let sweetAlert = SweetAlert.init()
                    debugPrint(sweetAlert.showAlert("Attenzione",subTitle: "Questa terapia è già stata assunta", style: .warning))
                    sweetAlert.animateAlert()
                }
                else{
                    let sweetAlert = SweetAlert.init()
                    debugPrint(sweetAlert.showAlert("Attenzione",subTitle: "Il campo testo\ndeve essere riempito", style: .warning))
                    sweetAlert.animateAlert()
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
    
    override func viewDidDisappear(_ animated: Bool) {
        if enableContentView{
            self.onCancel()
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
