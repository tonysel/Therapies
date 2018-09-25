//
//  HistoryViewController.swift
//  Tesi
//
//  Created by TonySellitto on 24/05/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PopUpViewControllerDelegate{
    
    var popUp : PopUpViewController?
    
    var enableContentView = false
    
    var panGesture = UIPanGestureRecognizer()
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    func onCancel() {
        UIView.animate(withDuration: 0.5, animations: {
            self.contentView.frame.origin.y = self.contentView.frame.origin.y - self.view.frame.height/2 - self.contentView.frame.height/3
            self.blurView.alpha = 0
        }, completion: {(_) in
            
//            self.contentView.willRemoveSubview((self.popUp?.view)!)
//            self.popUp?.dismiss(animated: true, completion: nil)
            
            self.contentView.isHidden = true
            self.blurView.isHidden = true
            self.popUp?.imageView.removeFromSuperview()
            self.popUp?.textLabel.removeFromSuperview()
            self.popUp?.cancelButton.removeFromSuperview()
            self.popUp?.view.removeFromSuperview()
            self.enableContentView = false
        
        })
        
    }

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setGradientBackground()
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(HistoryViewController.draggedView(_:)))
        contentView.isUserInteractionEnabled = true
        contentView.addGestureRecognizer(panGesture)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @objc func draggedView(_ sender:UIPanGestureRecognizer){
        self.view.bringSubview(toFront: contentView)
        let translation = sender.translation(in: self.view)
        contentView.center = CGPoint(x: contentView.center.x + translation.x, y: contentView.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 48.0/255.0, green: 210.0/255.0, blue: 190.0/255.0, alpha: 0.7).cgColor
        let colorBottom = UIColor(red: 52.0/255.0, green: 147.0/255.0, blue: 196.0/255.0, alpha: 0.7).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorTop, colorBottom]
        gradientLayer.locations = [ 0.0, 0.83]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var selectedSegment = 1
    
    @IBAction func segnmentControlUpload(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            selectedSegment = 1
            self.tableView.allowsSelection = true
            self.tableView.reloadData()
        }
        else{
            selectedSegment = 2
            self.tableView.allowsSelection = true
            self.tableView.reloadData()
        }
    }
    
    //Dictionary for terapie farmacologiche
    var arrayTerFarm = [MedicinaleWithTimeCore]()
    var arrayTerNonFarm = [TerapiaNonFarmacologicaWithTimeCore]()
    
    var dictTerFarm = [Int : [MedicinaleWithTimeCore]]()
    var dictTerNonFarm = [Int : [TerapiaNonFarmacologicaWithTimeCore]]()
    var datesString = [String]()
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.contentView.isHidden = true
        self.blurView.isHidden = true
        
        self.contentView.layer.cornerRadius = 12
//        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        DispatchQueue.main.async {
            self.arrayTerFarm = CoreDataController.shared.loadAllMedicinaliWithTimeCore()
            self.arrayTerNonFarm = CoreDataController.shared.loadAllTerapieNonFarmacologicheWithTimeCore()

//            ///////////////////////
            var row = 0
            
            var rowTerNonFarm = 0
            
            for i in self.arrayTerFarm{
                var temp = [MedicinaleWithTimeCore]()
                var tempString = String()
                for j in self.arrayTerFarm{
                    let dateFormatter = DateFormatter.init()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let stringDate = dateFormatter.string(from: i.time! as Date)
                    let stringDate2 = dateFormatter.string(from: j.time! as Date)
//                    print("GUARDA: \(stringDate)-\(row)::::::\(stringDate2)-\(row)")
                    if (stringDate == stringDate2 && !self.datesString.contains(stringDate)){
                        temp.append(j)
                        tempString = stringDate
                    }
                }
                if temp.count != 0{
                    self.dictTerFarm[row] = temp
                    temp.removeAll()
                    self.datesString.append(tempString)
//                    print(self.datesString)
                    row += 1
                }
            }
            
            self.datesString.removeAll()
            
            for i in self.arrayTerNonFarm{
                var temp = [TerapiaNonFarmacologicaWithTimeCore]()
                var tempString = String()
                for j in self.arrayTerNonFarm{
                    let dateFormatter = DateFormatter.init()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let stringDate = dateFormatter.string(from: i.time! as Date)
                    let stringDate2 = dateFormatter.string(from: j.time! as Date)
//                    print("GUARDA: \(stringDate)-\(row)::::::\(stringDate2)-\(row)")
                    if (stringDate == stringDate2 && !self.datesString.contains(stringDate)){
                        temp.append(j)
                        tempString = stringDate
                    }
                }
                if temp.count != 0{
                    self.dictTerNonFarm[rowTerNonFarm] = temp
                    temp.removeAll()
                    self.datesString.append(tempString)
//                    print(self.datesString)
                    rowTerNonFarm += 1
                }
            }

            var matrixTerFarm = [[MedicinaleWithTimeCore]]()
            var matrixTerNonFarm = [[TerapiaNonFarmacologicaWithTimeCore]]()
            
            for (_, value) in self.dictTerFarm{
                matrixTerFarm.append(value)
            }
            
            for (_, value) in self.dictTerNonFarm{
                matrixTerNonFarm.append(value)
            }
            
            self.dictTerFarm.removeAll()
            self.dictTerNonFarm.removeAll()
            
            matrixTerFarm = matrixTerFarm.sorted {
                (med1, med2) -> Bool in
                return (med1[0].time! as Date) > (med2[0].time! as Date)
            }
            
            matrixTerNonFarm = matrixTerNonFarm.sorted {
                (ter1, ter2) -> Bool in
                return (ter1[0].time! as Date) > (ter2[0].time! as Date)
            }
            var i = 0
            for row in matrixTerFarm{
                self.dictTerFarm[i] = row
                i += 1
            }
            
            i = 0
            
            for row in matrixTerNonFarm{
                self.dictTerNonFarm[i] = row
                i += 1
            }
            
//            for (key, value) in self.dictTerFarm{
//                let med = value.sorted {
//                    (med1, med2) -> Bool in
//                    return (med1.time! as Date) < (med2.time! as Date)
//                }
//                tempDict[key] = med
//            }
//
//            self.dictTerFarm = tempDict
//
//            for (key, value) in self.dictTerNonFarm{
//                let ter = value.sorted {
//                    (ter1, ter2) -> Bool in
//                    return (ter1.time! as Date) < (ter2.time! as Date)
//                }
//                tempDict2[key] = ter
//            }
//
//            self.dictTerNonFarm = tempDict2
            
//            //////////////////////////////
            self.tableView.reloadData()
        }
//        
//         self.tableView.reloadData()

      
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        dictTerFarm.removeAll()
        arrayTerFarm.removeAll()
        arrayTerNonFarm.removeAll()
        datesString.removeAll()
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        if selectedSegment == 1{
            return dictTerFarm.count
        }
            
        else {
            
            return dictTerNonFarm.count
            
        }
    }
    
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//        let date = Date(timeIntervalSinceNow: TimeInterval(section * 86400))
//
//        let dateFormatter = DateFormatter.init()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        let stringDate = dateFormatter.string(from: date)
//
//        return stringDate
//    }
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{

        let cell = tableView.dequeueReusableCell(withIdentifier: "historyTherapyViewCell", for: indexPath) as! HistoryTherapyViewCell

        if selectedSegment == 1{

            let medicinaleWithTime = dictTerFarm[indexPath.section]![indexPath.row]

            cell.nameMedicine.text = medicinaleWithTime.nome

            let dateFormatter = DateFormatter.init()
            dateFormatter.dateFormat = "HH:mm"

            if medicinaleWithTime.tipoOrario == "orario_esatto"{
                cell.timeLab.text = dateFormatter.string(from: (medicinaleWithTime.time! as Date))
                cell.ripMedicine.text = ""

            }
            else if medicinaleWithTime.tipoOrario == "orario_libero"{
                cell.timeLab.text = "Orario libero"
                cell.ripMedicine.text = "Ripetizioni effettuate: \(medicinaleWithTime.ripetizioni)"
            }
            else{
                cell.timeLab.text = "\(medicinaleWithTime.orario ?? "nil") \(medicinaleWithTime.quando ?? "nil")"
                cell.ripMedicine.text = ""
            }
            cell.qtaMedicine.text = "\(medicinaleWithTime.dosaggio) \(medicinaleWithTime.misuraDosaggio ?? "pillole")"

            cell.imageCell.image = UIImage(data: CoreDataController.shared.loadImageFromName(nameImage: medicinaleWithTime.nome!))
            
            cell.imageCell.layer.shadowColor = UIColor.black.cgColor
            cell.imageCell.layer.shadowOpacity = 0.3

            cell.qtaMedicine.isHidden = false
        }

        else if selectedSegment == 2{

            let terNonFarmWithTime = dictTerNonFarm[indexPath.section]![indexPath.row]

            cell.nameMedicine.text = terNonFarmWithTime.nome

            let dateFormatter = DateFormatter.init()
            dateFormatter.dateFormat = "HH:mm"

            if terNonFarmWithTime.tipoOrario == "orario_esatto"{
                cell.timeLab.text = dateFormatter.string(from: (terNonFarmWithTime.time! as Date))
                cell.ripMedicine.text = ""

            }
            else if terNonFarmWithTime.tipoOrario == "orario_libero"{
                cell.timeLab.text = "Orario libero"
                cell.ripMedicine.text = "Ripetizioni effettuate: \(terNonFarmWithTime.ripetizioni)"
            }
            else{
                cell.timeLab.text = "\(terNonFarmWithTime.orario ?? "nil") \(terNonFarmWithTime.quando ?? "nil")"
                cell.ripMedicine.text = ""
            }

            if terNonFarmWithTime.nome == "Controllo glicemia"{
                if terNonFarmWithTime.value != 0{
                    cell.qtaMedicine.text = "\(terNonFarmWithTime.value) mg/dL"
                    cell.qtaMedicine.isHidden = false
                }
                else{
                    cell.qtaMedicine.isHidden = true
                }
                cell.imageCell.image = #imageLiteral(resourceName: "syringe")
            }

            else if terNonFarmWithTime.nome == "Controllo peso"{
                if terNonFarmWithTime.value != 0{
                    cell.qtaMedicine.text = "\(terNonFarmWithTime.value) Kg"
                    cell.qtaMedicine.isHidden = false
                }
                else{
                    cell.qtaMedicine.isHidden = true
                }
                cell.imageCell.image = #imageLiteral(resourceName: "scale")
            }

            else{
                if terNonFarmWithTime.value != 0{
                    cell.qtaMedicine.text = "\(terNonFarmWithTime.value)"
                    cell.qtaMedicine.isHidden = false
                }
                else{
                    cell.qtaMedicine.isHidden = true
                }
                cell.imageCell.image = #imageLiteral(resourceName: "water")
            }

            cell.imageCell.layer.shadowColor = UIColor.black.cgColor
            cell.imageCell.layer.shadowOpacity = 0.5
        }
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.27

        return cell

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if selectedSegment == 1{
            return dictTerFarm[section]!.count
//            return arrayTerFarm.count
    }

        else {
            return dictTerNonFarm[section]!.count
//            return arrayTerNonFarm.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 180, height: 30))
        let colorBottom = UIColor(red: 52.0/255.0, green: 147.0/255.0, blue: 196.0/255.0, alpha: 0.7)

        headerView.layer.cornerRadius = 8

        headerView.backgroundColor = colorBottom

        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = .white
        label.textAlignment = .center

        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var stringDate = String()
        var stringDay : String?
        if selectedSegment == 1{
            stringDay = TraslationManager.loadDayName(forDate: dictTerFarm[section]![0].time! as Date)
            stringDate = dateFormatter.string(from: dictTerFarm[section]![0].time! as Date)
        }
        else {
            stringDay = TraslationManager.loadDayName(forDate: dictTerNonFarm[section]![0].time! as Date)
            stringDate = dateFormatter.string(from: dictTerNonFarm[section]![0].time! as Date)
        }
        label.frame = CGRect(x: self.view.frame.midX - 100, y: 7, width: 200, height: 15)
        label.text = "\(stringDay ?? "Nada") \(stringDate)"
        headerView.addSubview(label)
        
        return headerView
    }
    
    @IBOutlet weak var contentView: UIView!
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "historyTherapyViewCell", for: indexPath) as! HistoryTherapyViewCell
        
            if (selectedSegment == 1){
                
//                let customView = UIView()
//
//                customView.frame.size = CGSize(width: 275, height: 331)
//
//                customView.frame.origin.y = -450
//
//                customView.translatesAutoresizingMaskIntoConstraints = false

//                self.view.layer.insertSublayer(contentView.layer, at: 1)
                
//                let horizontalConstraint = NSLayoutConstraint(item: self.contentView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
//                let verticalConstraint = NSLayoutConstraint(item: self.contentView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: -414)
//
//                NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint])
                
//                let horizontalConstraint = NSLayoutConstraint(item: self.contentView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
//                let verticalConstraint = NSLayoutConstraint(item: self.contentView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: -40)
//                let widthConstraint = NSLayoutConstraint(item: self.contentView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 275)
//                let heightConstraint = NSLayoutConstraint(item: self.contentView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 331)
//
//                NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
//                self.contentView.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
//
                self.enableContentView = true
                
                let popUp = storyboard?.instantiateViewController(withIdentifier: "popUpViewController") as! PopUpViewController
                
                self.popUp = popUp
                
                self.popUp?.delegate = self
                
                self.tableView.deselectRow(at: indexPath, animated: true)
                //                popUp.modalPresentationStyle = .formSheet
                self.popUp?.image = UIImage(data: CoreDataController.shared.loadImageFromName(nameImage: self.dictTerFarm[indexPath.section]![indexPath.row].nome!))!
                self.addChildViewController(popUp)
                
                self.popUp?.textLabel.text = "\(self.dictTerFarm[indexPath.section]![indexPath.row].nome!)\n\nCodice Medicinale: \(self.dictTerFarm[indexPath.section]![indexPath.row].codiceMed!)\n\nCodice Terapia: \(self.dictTerFarm[indexPath.section]![indexPath.row].codiceTer!)\n\nDosaggio assunto: \(self.dictTerFarm[indexPath.section]![indexPath.row].dosaggio)"
                
                //make sure that the child view controller's view is the right size
                self.popUp?.view.frame = self.contentView.bounds
                
                self.contentView.addSubview((popUp.view)!)
                
                self.blurView.isHidden = false
        
                self.blurView.alpha = 0
              
                self.contentView.isHidden = false
                
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
        
        if(selectedSegment == 2){
            
            self.enableContentView = true
            
            let popUp = storyboard?.instantiateViewController(withIdentifier: "popUpViewController") as! PopUpViewController
            
            self.popUp = popUp
            
            self.popUp?.delegate = self
            
            self.tableView.deselectRow(at: indexPath, animated: true)
            //                popUp.modalPresentationStyle = .formSheet
            let cell = self.tableView.cellForRow(at: indexPath) as? HistoryTherapyViewCell
            self.popUp?.image = (cell?.imageCell.image)!
            self.addChildViewController(popUp)
            
            self.popUp?.textLabel.text = "\(self.dictTerNonFarm[indexPath.section]![indexPath.row].nome!)\n\n\nCodice Terapia: \(self.dictTerNonFarm[indexPath.section]![indexPath.row].codiceTer!)\n\nValore registrato: \(self.dictTerNonFarm[indexPath.section]![indexPath.row].value) \(self.dictTerFarm[indexPath.section]![indexPath.row].misuraDosaggio)"
            
            //make sure that the child view controller's view is the right size
            self.popUp?.view.frame = self.contentView.bounds
            
            self.contentView.addSubview((popUp.view)!)
            
            self.blurView.isHidden = false
            
            self.blurView.alpha = 0
            
            self.contentView.isHidden = false
            
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


        }

    // MARK: - height cell table view
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if enableContentView{
            self.onCancel()
        }
    }
    

}
