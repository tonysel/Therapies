//
//  HistoryViewController.swift
//  Tesi
//
//  Created by TonySellitto on 24/05/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view.
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
            self.tableView.reloadData()
        }
        else{
            selectedSegment = 2
            self.tableView.reloadData()
        }
    }
    
    //Dictionary for terapie farmacologiche
    var arrayTerFarm = [MedicinaleWithTimeCore]()
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.prefersLargeTitles = true
        arrayTerFarm = CoreDataController.shared.loadAllMedicinaliWithTimeCore()
        self.tableView.reloadData()
    }
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
    
    
    func tableView(_ tableView: UITableView!, cellForRowAt indexPath: IndexPath!) -> UITableViewCell!{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyTherapyViewCell", for: indexPath) as! HistoryTherapyViewCell
        
        if selectedSegment == 1{
            
            let medicinaleWithTime = arrayTerFarm[indexPath.row]
            
            cell.nameMedicine.text = medicinaleWithTime.nome
            
            let dateFormatter = DateFormatter.init()
            dateFormatter.dateFormat = "HH:mm"
            
            if medicinaleWithTime.tipoOrario == "orario_esatto"{
                cell.timeLab.text = dateFormatter.string(from: (medicinaleWithTime.time! as Date))
                cell.ripMedicine.text = ""
            }
            else if medicinaleWithTime.tipoOrario == "orario_libero"{
                cell.timeLab.text = "Orario libero"
                cell.ripMedicine.text = "Ripetizioni: \(medicinaleWithTime.ripetizioni)"
            }
            else{
                cell.timeLab.text = "\(medicinaleWithTime.orario ?? "nil")-\(medicinaleWithTime.quando ?? "nil")"
                cell.ripMedicine.text = ""
            }
            cell.qtaMedicine.text = "\(medicinaleWithTime.dosaggio )"
            
            cell.qtaMedicine.isHidden = false
        }
            
        else if selectedSegment == 2{
            
//            let terapiaNonFarmacologicaWithTime = dictTerNonFarm[indexPath.section]![indexPath.row]
//
//            cell.nameMedicine.text = terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getNome()
//
//            let dateFormatter = DateFormatter.init()
//            dateFormatter.dateFormat = "HH:mm"
//            if terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getTipoOrario() == "orario_esatto"{
//                cell.timeLab.text = dateFormatter.string(from: (terapiaNonFarmacologicaWithTime.getTime()!))
//                cell.qtaMedicine.text = ""
//            }
//            else if terapiaNonFarmacologicaWithTime.getTerapiaNonFarmacologica().getTipoOrario() == "orario_libero"{
//                cell.timeLab.text = "Orario libero"
//                cell.qtaMedicine.text = "Ripetizioni: \(terapiaNonFarmacologicaWithTime.getRipetizioni() ?? 0)"
//            }
//            else{
//                cell.timeLab.text = "\(terapiaNonFarmacologicaWithTime.getOrarioApprossimato() ?? "nil")-\(terapiaNonFarmacologicaWithTime.getQuandoApprossimato() ?? "nil")"
//                cell.qtaMedicine.text = ""
//            }
//            cell.ripMedicine.isHidden = true
//        }
            
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if selectedSegment == 1{
            return arrayTerFarm.count
        }
            
        else {
            return arrayTerFarm.count
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "specificTherapySegue"{
//            let indexPath = self.tableView.indexPathForSelectedRow!
//            if(selectedSegment == 1){
//                let vcDestination = segue.destination as! SpecificTherapyViewController
//
//                vcDestination.medicineWithTime = self.dictTerFarm[indexPath.section]![indexPath.row] ///////
//            } else {
//                let vcDestination = segue.destination as! SpecificTherapyViewController
//
//                vcDestination.terapiaNonFarmacologicaWithTime = self.dictTerNonFarm[indexPath.section]![indexPath.row] ///////
//            }
//            self.tableView.deselectRow(at: indexPath, animated: true)
//        }
//
//    }
//
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
    

}
