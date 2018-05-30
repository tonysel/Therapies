//
//  MainViewController.swift
//  Tesi
//
//  Created by TonySellitto on 12/05/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit

extension Date{
    func days(from_date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: from_date, to: self).day ?? 0
    }
}

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FBManagerDelegate{
    
    let fbManager = FBManager()
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var profileButton: UIBarButtonItem!
    
    var refresher : UIRefreshControl!
    
    func onSuccess() {
        
        print("success Main View")
        
        self.dictTerFarm = TerapieManager.createTerapieFarmacologicheInWeek(paziente: (appDelegate?.paziente)!)
        self.dictTerNonFarm = TerapieManager.createTerapieNonFarmacologicheInWeek(paziente: (appDelegate?.paziente)!)
        var tempDict = [Int : [MedicinaleWithTime]]()
        var tempDict2 = [Int : [TerapiaNonFarmacologicaWithTime]]()
        
        for (key, value) in dictTerFarm{
            let med = value.sorted {
                (med1, med2) -> Bool in
                return med1.getTime()! < med2.getTime()!
                }
            tempDict[key] = med
        }
        
        dictTerFarm = tempDict
        
        for (key, value) in dictTerNonFarm{
            let ter = value.sorted {
                (ter1, ter2) -> Bool in
                return ter1.getTime()! < ter2.getTime()!
            }
            tempDict2[key] = ter
        }
        
        dictTerNonFarm = tempDict2

        self.profileButton.isEnabled = true
        
        self.isFinishedLoading = true
        self.tableView.reloadData()
        self.tableView.isHidden = false
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        
//      NotificationManager.createNotificationsForTerapieFarmacologiche(paziente: (appDelegate?.paziente!)!)
        
    }
    
    func onFailure() {
        
    }
    
    var selectedSegment = 1
    
    @IBAction func segnmentControlUpload(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            selectedSegment = 1
            self.tableView.reloadData()
        }
        else{
            selectedSegment = 2
            self.tableView.reloadData()
        }
    }
    
    //Variable to control loading data in tableView
    var isFinishedLoading = false
    //Dictionary for terapie farmacologiche
    var dictTerFarm = [Int : [MedicinaleWithTime]]()
    
    //Dictionary for terapie NON farmacologiche
    var dictTerNonFarm = [Int : [TerapiaNonFarmacologicaWithTime]]()
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    
    func readIsFirstTimeLogin() -> Bool{
        
        var format = PropertyListSerialization.PropertyListFormat.xml//format of the property list
        var plistData: [String:AnyObject] = [:]  //our data
        let plistPath:String? = Bundle.main.path(forResource: "data", ofType: "plist")! //the path of the data
        let plistXML = FileManager.default.contents(atPath: plistPath!)! //the data in XML format
        var isFirstTimeLogin = false
        do{
            //convert the data to a dictionary and handle errors.
            plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &format) as! [String : AnyObject]
            
            //assign the values in the dictionary to the properties
            isFirstTimeLogin = plistData["isFirstTimeLogin"] as! Bool
            
        }
        catch{ // error condition
            print("Error reading plist: \(error), format: \(format)")
        }
        
        return isFirstTimeLogin
    }
    
    func readPropertyList(){
        
        var format = PropertyListSerialization.PropertyListFormat.xml//format of the property list
        var plistData: [String:AnyObject] = [:]  //our data
        let plistPath:String? = Bundle.main.path(forResource: "data", ofType: "plist")! //the path of the data
        let plistXML = FileManager.default.contents(atPath: plistPath!)! //the data in XML format
        do{ //convert the data to a dictionary and handle errors.
            
            plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &format) as! [String : AnyObject]
            
            //assign the values in the dictionary to the properties
            let isFirstTimeLogin = plistData["isFirstTimeLogin"] as! Bool
            
            print("vediii benneeeee plist: \(isFirstTimeLogin)")
            
        }
        catch{ // error condition
            print("Error reading plist: \(error), format: \(format)")
        }
    }
    
    @objc func populate(){
        let fbManager = FBManager()
        fbManager.updateDB(codicePaziente: (appDelegate?.qrCode)!, ultimaModificaPiano: (appDelegate?.paziente?.getUltimaModifica())!)
        
        refresher.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        if  UserDefaults.standard.bool(forKey: "notFirstTime") == false{
            
            fbManager.savePaziente(qrCode: (appDelegate?.qrCode)!)
            
            UserDefaults.standard.set(true, forKey: "notFirstTime")
            
        }
            //        notFirstTime is true in this case
        else{
            self.appDelegate?.paziente = CoreDataController.shared.loadAllPazienti()[0]
            
            self.onSuccess()
            
            //            fbManager.updateDB(codicePaziente: (appDelegate?.qrCode!)!, ultimaModificaPiano: (appDelegate?.paziente?.getUltimaModifica())!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.tableView.delegate = self
        self.tableView.isHidden = true
        self.tableView.dataSource = self
        self.activityIndicator.startAnimating()
        self.profileButton.isEnabled = false        
        
        fbManager.delegate = self
        
       
        
        //Create a refresh object to reload data
        refresher = UIRefreshControl()
        let colorRefresher =  UIColor(red: 4.0/255.0, green: 182.0/255.0, blue: 189.0/255.0, alpha: 1)
        refresher.tintColor = colorRefresher
        refresher.addTarget(self, action: #selector(MainViewController.populate), for: UIControlEvents.valueChanged)
        tableView.refreshControl = refresher
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let date = Date(timeIntervalSinceNow: TimeInterval(section * 86400))
        
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let stringDate = dateFormatter.string(from: date)
        
        return stringDate
    }
    
    
    func tableView(_ tableView: UITableView!, cellForRowAt indexPath: IndexPath!) -> UITableViewCell!{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "therapyCell", for: indexPath) as! TherapyViewCell
        
        if isFinishedLoading && selectedSegment == 1{
            
            let medicinaleWithTime = dictTerFarm[indexPath.section]![indexPath.row]
            
            cell.ripMedicine.isHidden = false
            
//            print("ultimo passaggio: \(medicinaleWithTime.getMedicinale().getNome())")
            
            cell.nameMedicine.text = medicinaleWithTime.getMedicinale().getNome()
            
            let dateFormatter = DateFormatter.init()
            dateFormatter.dateFormat = "HH:mm"
            
            if medicinaleWithTime.getTipoOrario() == "orario_esatto"{
                cell.timeLab.text = dateFormatter.string(from: (medicinaleWithTime.getTime()!))
                cell.ripMedicine.text = ""
            }
            else if medicinaleWithTime.getTipoOrario() == "orario_libero"{
                cell.timeLab.text = "Orario libero"
                cell.ripMedicine.text = "Ripetizioni: \(medicinaleWithTime.getRipetizioni() ?? 0)"
            }
            else{
                cell.timeLab.text = "\(medicinaleWithTime.getOrarioApprossimato() ?? "nil")-\(medicinaleWithTime.getQuandoApprossimato() ?? "nil")"
                cell.ripMedicine.text = ""
            }
            cell.qtaMedicine.text = "\(medicinaleWithTime.getDosaggio() ?? 0) - \(medicinaleWithTime.getMedicinale().getMisuraDosaggio())"

//            cell.qtaMedicine.isHidden = false
        }
            
        else if isFinishedLoading && selectedSegment == 2{
            
            let terapiaNonFarmacologicaWithTime = dictTerNonFarm[indexPath.section]![indexPath.row]
            
            cell.nameMedicine.text = terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getNome()
            
            let dateFormatter = DateFormatter.init()
            dateFormatter.dateFormat = "HH:mm"
            if terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getTipoOrario() == "orario_esatto"{
                cell.timeLab.text = dateFormatter.string(from: (terapiaNonFarmacologicaWithTime.getTime()!))
                cell.qtaMedicine.text = ""
            }
            else if terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getTipoOrario() == "orario_libero"{
                cell.timeLab.text = "Orario libero"
                cell.qtaMedicine.text = "Ripetizioni: \(terapiaNonFarmacologicaWithTime.getRipetizioni() ?? 0)"
            }
            else{
                cell.timeLab.text = "\(terapiaNonFarmacologicaWithTime.getOrarioApprossimato() ?? "nil")-\(terapiaNonFarmacologicaWithTime.getQuandoApprossimato() ?? "nil")"
                cell.qtaMedicine.text = ""
            }
            cell.ripMedicine.isHidden = true
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isFinishedLoading && selectedSegment == 1{
            return dictTerFarm[section]!.count
        }
            
        else if isFinishedLoading && selectedSegment == 2{
            return dictTerNonFarm[section]!.count
        }
            
        else{
            return 0
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "specificTherapySegue"{
            let indexPath = self.tableView.indexPathForSelectedRow!
            if(selectedSegment == 1){
                let vcDestination = segue.destination as! SpecificTherapyViewController
               
                vcDestination.medicineWithTime = self.dictTerFarm[indexPath.section]![indexPath.row] ///////
            } else {
                let vcDestination = segue.destination as! SpecificTherapyViewController
              
                vcDestination.terapiaNonFarmacologicaWithTime = self.dictTerNonFarm[indexPath.section]![indexPath.row] ///////
            }
              self.tableView.deselectRow(at: indexPath, animated: true)
        }
      
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if (selectedSegment == 1){
//            self.performSegue(withIdentifier: "specificTherapySegue", sender: tableView)
//        }
//        else{
//            self.performSegue(withIdentifier: "specificTherapySegue", sender: tableView)
////            let alert = UIAlertController(title: "Attention!", message: "You need to login to proceed", preferredStyle: UIAlertControllerStyle.alert)
////            let bottoneOk = UIAlertAction ( title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
////            alert.addAction(bottoneOk)
////            self.present(alert, animated: true, completion: nil)
//        }
//        self.tableView.deselectRow(at: indexPath, animated: true)
//    }
//    
    
    // MARK: - Table view delegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
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