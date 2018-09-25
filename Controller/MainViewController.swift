//
//  MainViewController.swift
//  Tesi
//
//  Created by TonySellitto on 12/05/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit


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

//        if UserDefaults.standard.bool(forKey: "notFirstTime") == true{
        
          //Old system of notifications
//        DispatchQueue.main.async {
//            NewNotificationManager.createNotificationsForTerapieFarmacologiche(paziente: (self.appDelegate?.paziente!)!)
//        }
        
        DispatchQueue.main.async {
            NotificationManager.createNotificationsForTerapieFarmacologiche()
        }
        
//        }
        
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
    
//    override func viewDidDisappear(_ animated: Bool) {
//        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
//        self.navigationController?.navigationBar.barTintColor = .white
//
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//    }
    
    @objc func populate(){
        let fbManager = FBManager()
        fbManager.updateDB(codicePaziente: (appDelegate?.qrCode)!, ultimaModificaPiano: (appDelegate?.paziente?.getUltimaModifica())!)
        
        refresher.endRefreshing()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//
//        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
//        self.navigationController?.navigationBar.barTintColor = .white
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.barTintColor = .white
        
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
        
//        self.tableView.backgroundView?.frame.origin.y -= 0
        self.setGradientBackground()
      
        self.tableView.delegate = self
        self.tableView.isHidden = true
        self.tableView.dataSource = self
        self.activityIndicator.startAnimating()
        self.profileButton.isEnabled = false        
        
        self.fbManager.delegate = self
    
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

    
//    var countDownTimer : Timer!
    var totalTime = 100
    
    
    // MARK: - Timer
//    func startTimer() {
//        countDownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
//    }
//
//    @objc func updateTime() {
//        let cell = self.tableView.dequeueReusableCell(withIdentifier: "therapyCell") as! TherapyViewCell
//        cell.timerLabel.text = "\(timeFormatted(totalTime))"
//
//        if totalTime != 0 {
//            totalTime -= 1
//        } else {
//            endTimer()
//
//        }
//    }
//
//    func endTimer() {
//        countDownTimer.invalidate()
//    }
    
//    func timeFormatted(_ totalSeconds: Int) -> String {
//        let seconds: Int = totalSeconds % 60
//        //     let hours: Int = totalSeconds / 3600
//        return String(format: "%02d", seconds)
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "therapyCell", for: indexPath) as! TherapyViewCell
//        let cell = TherapyViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "therapyCell")
        
        if isFinishedLoading && selectedSegment == 1{
            
            let medicinaleWithTime = dictTerFarm[indexPath.section]![indexPath.row]
            
            cell.ripMedicine.isHidden = false
            
            cell.nameMedicine.text = medicinaleWithTime.getMedicinale().getNome()
            
            let dateFormatter = DateFormatter.init()
            dateFormatter.dateFormat = "HH:mm"
            
            if medicinaleWithTime.getTipoOrario() == "orario_esatto"{
                cell.timeLab.text = dateFormatter.string(from: (medicinaleWithTime.getTime()!))
                if CoreDataController.shared.existsMedicinaleWithTimeFromId(id: medicinaleWithTime.getId()!){
                    cell.ripMedicine.text =  "✅"
                    cell.ripMedicine.font = UIFont.systemFont(ofSize: 16)
                    cell.ripMedicine.textColor = .black
                }
                else{
                    cell.ripMedicine.text = ""
                    cell.ripMedicine.font = UIFont.systemFont(ofSize: 16)
                    cell.ripMedicine.textColor = .black
                }
                
            }
            else if medicinaleWithTime.getTipoOrario() == "orario_libero"{
                cell.timeLab.text = "Orario libero"
                if CoreDataController.shared.existsMedicinaleWithTimeFromId(id: medicinaleWithTime.getId()!){
                    if medicinaleWithTime.getRipetizioni()! - Int(CoreDataController.shared.loadMedicinaleWithOrarioLiberoFromId(id: medicinaleWithTime.getId()!).ripetizioni) > 0{
                        cell.ripMedicine.text = "Ripetizioni mancanti: \(medicinaleWithTime.getRipetizioni()! - Int(CoreDataController.shared.loadMedicinaleWithOrarioLiberoFromId(id: medicinaleWithTime.getId()!).ripetizioni))"
                        cell.ripMedicine.font = UIFont.systemFont(ofSize: 16)
                        cell.ripMedicine.textColor = .black
                    }
                    else{
                        cell.ripMedicine.text =  "✅"
                        cell.ripMedicine.font = UIFont.systemFont(ofSize: 16)
                        cell.ripMedicine.textColor = .black
                    }
                }
                else{
                    cell.ripMedicine.text = "Ripetizioni mancanti: \(medicinaleWithTime.getRipetizioni() ?? 0)"
                    cell.ripMedicine.font = UIFont.systemFont(ofSize: 16)
                    cell.ripMedicine.textColor = .black
                }
            }
            else{
                cell.timeLab.text = "\(medicinaleWithTime.getOrarioApprossimato() ?? "nil") \(medicinaleWithTime.getQuandoApprossimato() ?? "nil")"
                if CoreDataController.shared.existsMedicinaleWithTimeFromId(id: medicinaleWithTime.getId()!){
                    cell.ripMedicine.text =  "✅"
                    cell.ripMedicine.font = UIFont.systemFont(ofSize: 16)
                    cell.ripMedicine.textColor = .black
                }
                else{
                    cell.ripMedicine.text = ""
                    cell.ripMedicine.font = UIFont.systemFont(ofSize: 16)
                    cell.ripMedicine.textColor = .black
                }
            }
            cell.qtaMedicine.text = "\(medicinaleWithTime.getDosaggio() ?? 0) \(medicinaleWithTime.getMedicinale().getMisuraDosaggio())"
            cell.codTer.text = "Cod Ter : \(medicinaleWithTime.getCodiceTerapia() ?? "nil")"
            
//            let calendar = Calendar.init(identifier: .gregorian)
            
            let cd = CoreDataController()
            
            let currentDate = Date()
            
//            (currentDate.addingTimeInterval(-1200) <= medicinaleWithTime.getTime()! && medicinaleWithTime.getTime()! <= currentDate.addingTimeInterval(1200))
            
            if indexPath.section == 0{
                if medicinaleWithTime.getTipoOrario() == "orario_libero"  && !cd.existsMedicinaleWithTimeFromId(id: medicinaleWithTime.getId()!) || ((medicinaleWithTime.getTipoOrario() == "orario_esatto")  && !cd.existsMedicinaleWithTimeFromId(id: medicinaleWithTime.getId()!) && (currentDate >= medicinaleWithTime.getTime()!.addingTimeInterval(-1200) && medicinaleWithTime.getTime()!.addingTimeInterval(1200) >= currentDate)) || ((medicinaleWithTime.getTipoOrario() == "orario_approssimato")  && !cd.existsMedicinaleWithTimeFromId(id: medicinaleWithTime.getId()!) && (currentDate >= medicinaleWithTime.getTime()!.addingTimeInterval(-5400) && medicinaleWithTime.getTime()!.addingTimeInterval(5400) >= currentDate)){
                    cell.customView.layer.borderWidth = 2.4
                    cell.customView.layer.borderColor = UIColor(red: 240.0/255.0, green: 150.0/255.0, blue: 55.0/255.0, alpha: 0.8).cgColor
                }
                else if ((medicinaleWithTime.getTipoOrario() == "orario_esatto")  && !cd.existsMedicinaleWithTimeFromId(id: medicinaleWithTime.getId()!) && (medicinaleWithTime.getTime()!.addingTimeInterval(1200) < currentDate)) || ((medicinaleWithTime.getTipoOrario() == "orario_approssimato")  && !cd.existsMedicinaleWithTimeFromId(id: medicinaleWithTime.getId()!) && (medicinaleWithTime.getTime()!.addingTimeInterval(5400) < currentDate)){
                    cell.ripMedicine.text = "⚠︎"
                    cell.ripMedicine.font = UIFont.boldSystemFont(ofSize: 25)
                    cell.ripMedicine.textColor = .orange
                    cell.customView.layer.borderWidth = 3
                    cell.customView.layer.borderColor = UIColor(red: 22.0/255.0, green: 169.0/255.0, blue: 182.0/255.0, alpha: 0.8).cgColor
                }
                else{
                    cell.customView.layer.borderWidth = 3
                    
                    cell.customView.layer.borderColor = UIColor(red: 22.0/255.0, green: 169.0/255.0, blue: 182.0/255.0, alpha: 0.8).cgColor
                }
                cell.clockImage.isHidden = false
                cell.timerLabel.isHidden = true
            }
            else{
                cell.customView.layer.borderWidth = 0
                cell.clockImage.isHidden = false
                cell.timerLabel.isHidden = true
            }

//            let analogClock = AnalogClockView(view: cell.clockImage!)
//
//            analogClock.hours = calendar.component(.hour, from: medicinaleWithTime.getTime()! )
//            analogClock.minutes = calendar.component(.minute, from: medicinaleWithTime.getTime()! )
//            cell.clockImage.addSubview(analogClock)
            
//            cell.clockImage.hours = calendar.component(.hour, from: medicinaleWithTime.getTime()! )
//            cell.clockImage.minutes = calendar.component(.minute, from: medicinaleWithTime.getTime()! )
            
//            cell.draw(CGRect(origin: CGPoint.zero, size: CGSize(width: 56, height: 56)))
            
//            cell.clockImage = AnalogClockView(hours: calendar.component(.hour, from: medicinaleWithTime.getTime()!), minutes: calendar.component(.minute, from: medicinaleWithTime.getTime()!), view: UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 56, height: 56))))
    
//            }
        
//            cell.qtaMedicine.isHidden = false
        }
            
        else if isFinishedLoading && selectedSegment == 2{
            
            let terapiaNonFarmacologicaWithTime = dictTerNonFarm[indexPath.section]![indexPath.row]
            
            cell.nameMedicine.text = terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getNome()
        
            let dateFormatter = DateFormatter.init()
            dateFormatter.dateFormat = "HH:mm"
            if terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getTipoOrario() == "orario_esatto"{
                cell.timeLab.text = dateFormatter.string(from: (terapiaNonFarmacologicaWithTime.getTime()!))
                if CoreDataController.shared.existsTerapiaNonFarmacologicaWithTimeFromId(id: terapiaNonFarmacologicaWithTime.getId()!){
                    if CoreDataController.shared.loadTerNonFarmWithOrarioLiberoFromId(id: terapiaNonFarmacologicaWithTime.getId()!).value != 0{
                        cell.qtaMedicine.text = "\(CoreDataController.shared.loadTerNonFarmWithOrarioLiberoFromId(id: terapiaNonFarmacologicaWithTime.getId()!).value)"
                    }
                    else{
                        cell.qtaMedicine.text = ""
                    }
                    cell.ripMedicine.text =  "✅"
                    cell.ripMedicine.font = UIFont.systemFont(ofSize: 16)
                    cell.ripMedicine.textColor = .black
                }else{
                    cell.qtaMedicine.text = ""
                    cell.ripMedicine.text =  ""
                    cell.ripMedicine.font = UIFont.systemFont(ofSize: 16)
                    cell.ripMedicine.textColor = .black
                }
            
            }
            else if terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getTipoOrario() == "orario_libero"{
                cell.timeLab.text = "Orario libero"
                if CoreDataController.shared.existsTerapiaNonFarmacologicaWithTimeFromId(id: terapiaNonFarmacologicaWithTime.getId()!){
                    if  terapiaNonFarmacologicaWithTime.getRipetizioni()! - Int(CoreDataController.shared.loadTerNonFarmWithOrarioLiberoFromId(id: terapiaNonFarmacologicaWithTime.getId()!).ripetizioni) > 0{
                        cell.ripMedicine.text = "Ripetizioni mancanti: \(terapiaNonFarmacologicaWithTime.getRipetizioni()! - Int(CoreDataController.shared.loadTerNonFarmWithOrarioLiberoFromId(id: terapiaNonFarmacologicaWithTime.getId()!).ripetizioni))"
                        cell.qtaMedicine.text = ""
                        cell.ripMedicine.font = UIFont.systemFont(ofSize: 16)
                        cell.ripMedicine.textColor = .black
                    }
                    else{
                        cell.ripMedicine.text =  "✅"
                        cell.ripMedicine.font = UIFont.systemFont(ofSize: 16)
                        cell.qtaMedicine.text = ""
                        cell.ripMedicine.textColor = .black
                    }
                }
                else{
                    cell.ripMedicine.text = "Ripetizioni mancanti: \(terapiaNonFarmacologicaWithTime.getRipetizioni() ?? 0)"
                    cell.ripMedicine.font = UIFont.systemFont(ofSize: 16)
                    cell.qtaMedicine.text = ""
                    cell.ripMedicine.textColor = .black
                }
                
            }
            else{
                cell.timeLab.text = "\(terapiaNonFarmacologicaWithTime.getOrarioApprossimato() ?? "nil")-\(terapiaNonFarmacologicaWithTime.getQuandoApprossimato() ?? "nil")"
                if CoreDataController.shared.existsTerapiaNonFarmacologicaWithTimeFromId(id: terapiaNonFarmacologicaWithTime.getId()!){
//                    cell.qtaMedicine.text = "\(CoreDataController.shared.loadTerNonFarmWithOrarioLiberoFromId(id: terapiaNonFarmacologicaWithTime.getId()!).value)"
                    if CoreDataController.shared.loadTerNonFarmWithOrarioLiberoFromId(id: terapiaNonFarmacologicaWithTime.getId()!).value != 0{
                        cell.qtaMedicine.text = "\(CoreDataController.shared.loadTerNonFarmWithOrarioLiberoFromId(id: terapiaNonFarmacologicaWithTime.getId()!).value)"
                    }
                    else{
                        cell.qtaMedicine.text = ""
                    }
                    cell.ripMedicine.text =  "✅"
                    cell.ripMedicine.font = UIFont.systemFont(ofSize: 16)
                    cell.ripMedicine.textColor = .black
                }else{
                    cell.qtaMedicine.text = ""
                    cell.ripMedicine.text = ""
                    cell.ripMedicine.font = UIFont.systemFont(ofSize: 16)
                    cell.ripMedicine.textColor = .black
                }
               
            }
            cell.codTer.text = "Cod Ter: \(terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getCodice())"

//            let calendar = Calendar.init(identifier: .gregorian)
            
//            let analogClock = AnalogClockView(view: cell.clockImage)
//
//            analogClock.hours = calendar.component(.hour, from: terapiaNonFarmacologicaWithTime.getTime()! )
//            analogClock.minutes = calendar.component(.minute, from: terapiaNonFarmacologicaWithTime.getTime()! )
//            cell.clockImage.addSubview(analogClock)
            
//             cell.draw(CGRect(origin: CGPoint.zero, size: CGSize(width: 56, height: 56)))
            
            let cd = CoreDataController()
            
            let currentDate = Date()
            
            if indexPath.section == 0{
                
                if terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getTipoOrario() == "orario_libero"  && !cd.existsTerapiaNonFarmacologicaWithTimeFromId(id: terapiaNonFarmacologicaWithTime.getId()!) || ((terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getTipoOrario() == "orario_esatto" )  && !cd.existsTerapiaNonFarmacologicaWithTimeFromId(id: terapiaNonFarmacologicaWithTime.getId()!) && (currentDate.addingTimeInterval(-1200) <= terapiaNonFarmacologicaWithTime.getTime()! && terapiaNonFarmacologicaWithTime.getTime()! <= currentDate.addingTimeInterval(1200))) || ((terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getTipoOrario() == "orario_approssimato")  && !cd.existsTerapiaNonFarmacologicaWithTimeFromId(id: terapiaNonFarmacologicaWithTime.getId()!) && (currentDate.addingTimeInterval(-5400) <= terapiaNonFarmacologicaWithTime.getTime()! && terapiaNonFarmacologicaWithTime.getTime()! <= currentDate.addingTimeInterval(5400))){
                    cell.customView.layer.borderWidth = 2.4
                
                        cell.customView.layer.borderColor = UIColor(red: 240.0/255.0, green: 150.0/255.0, blue: 55.0/255.0, alpha: 0.8).cgColor
                    
                }
                else if ((terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getTipoOrario() == "orario_esatto" )  && !cd.existsTerapiaNonFarmacologicaWithTimeFromId(id: terapiaNonFarmacologicaWithTime.getId()!) && (terapiaNonFarmacologicaWithTime.getTime()!.addingTimeInterval(1200) < currentDate)) || ((terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getTipoOrario() == "orario_approssimato")  && !cd.existsTerapiaNonFarmacologicaWithTimeFromId(id: terapiaNonFarmacologicaWithTime.getId()!) && (terapiaNonFarmacologicaWithTime.getTime()!.addingTimeInterval(5400) < currentDate)){
                    cell.ripMedicine.text = "⚠︎"
                    cell.ripMedicine.font = UIFont.boldSystemFont(ofSize: 25)
                    cell.ripMedicine.textColor = .orange
                    
                    cell.customView.layer.borderWidth = 3
                    
                    cell.customView.layer.borderColor = UIColor(red: 22.0/255.0, green: 169.0/255.0, blue: 182.0/255.0, alpha: 0.8).cgColor
                }
                else{
                    cell.customView.layer.borderWidth = 3
                    
                    cell.customView.layer.borderColor = UIColor(red: 22.0/255.0, green: 169.0/255.0, blue: 182.0/255.0, alpha: 0.8).cgColor
                }
                cell.clockImage.isHidden = false
                cell.timerLabel.isHidden = true
            }
            else{
                cell.customView.layer.borderWidth = 0
                cell.clockImage.isHidden = false
                cell.timerLabel.isHidden = true
            }

        }
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.27
        
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

    // - MARK: Prepare
    
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
    
    // - MARK: ViewFroHeaderInSection
    
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
        let date = Date(timeIntervalSinceNow: TimeInterval(section * 86400))
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let stringDate = dateFormatter.string(from: date)
        label.frame = CGRect(x: self.view.frame.midX - 125, y: 7, width: 250, height: 15)
        if section == 0{
            label.text = "OGGI \(TraslationManager.loadDayName(forDate: date)) \(stringDate)"
        }
        else{
            label.text = "\(TraslationManager.loadDayName(forDate: date)) \(stringDate)"
        }
        headerView.addSubview(label)
        
//       self.view.layer.insertSublayer(headerView.layer, at:0)

        return headerView
    }

    func setGradientBackground() {
        let colorTop =  UIColor(red: 48.0/255.0, green: 210.0/255.0, blue: 190.0/255.0, alpha: 0.7).cgColor
        let colorBottom = UIColor(red: 52.0/255.0, green: 147.0/255.0, blue: 196.0/255.0, alpha: 0.7).cgColor
     
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorTop, colorBottom]
        gradientLayer.locations = [0.0, 0.83]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
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
