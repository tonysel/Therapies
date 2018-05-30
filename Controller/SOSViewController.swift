//
//  SOSTableViewController.swift
//  Tesi
//
//  Created by TonySellitto on 24/05/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit

class SOSViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
  
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    var soss : [SOS]?
    var isFinishedLoading = false
    var refresher : UIRefreshControl!
    var fbManager = FBManager()
    
    
    @IBAction func infoButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Info", message: "You can see if the doctor has visualized your SOS through the checkmark ✅.", preferredStyle: UIAlertControllerStyle.alert)
        let bottoneOk = UIAlertAction ( title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(bottoneOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @objc func populate(){
        
        fbManager.readRichiesteAiuto(medico: (appDelegate?.paziente?.getMedicoControllo())!, codice: (appDelegate?.qrCode!)!) { (soss) in
            self.soss = soss
       
            let tempSoss = soss.sorted {
                (sos1, sos2) -> Bool in
                return sos1.getTime() > sos2.getTime()
            }
            
            self.soss = tempSoss
            
            self.tableView.isHidden = false
            self.isFinishedLoading = true
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
            self.refresher.endRefreshing()
            
        }
        
        refresher.endRefreshing()
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        if !(appDelegate?.isInternetAvailable())!{
            appDelegate?.showInternetAlert(view: self)
            self.tableView.isHidden = false
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
        
        fbManager.readRichiesteAiuto(medico: (appDelegate?.paziente?.getMedicoControllo())!, codice: (appDelegate?.qrCode!)!) { (soss) in
            self.soss = soss
            
            let tempSoss = soss.sorted {
                (sos1, sos2) -> Bool in
                return sos1.getTime() > sos2.getTime()
            }
            
            self.soss = tempSoss
            
            self.tableView.isHidden = false
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
            self.isFinishedLoading = true
            self.tableView.reloadData()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.tableView.isHidden = true
        self.tableView.tableFooterView = UIView()
        
        
//        fbManager.readRichiesteAiuto(medico: (appDelegate?.paziente?.getMedicoControllo())!, codice: (appDelegate?.qrCode!)!) { (soss) in
//            self.soss = soss
//         
//            let tempSoss = soss.sorted {
//                (sos1, sos2) -> Bool in
//                return sos1.getTime() > sos2.getTime()
//            }
//            
//            self.soss = tempSoss
//            
//            self.tableView.isHidden = false
//            self.activityIndicator.isHidden = true
//            self.activityIndicator.stopAnimating()
//            self.isFinishedLoading = true
//            self.tableView.reloadData()
//            
//        }

        refresher = UIRefreshControl()
        let colorRefresher =  UIColor(red: 4.0/255.0, green: 182.0/255.0, blue: 189.0/255.0, alpha: 1)
        refresher.tintColor = colorRefresher
        refresher.addTarget(self, action: #selector(MainViewController.populate), for: UIControlEvents.valueChanged)
        tableView.refreshControl = refresher
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isFinishedLoading{
            return (soss?.count)!
        }
        else{
            return 0
        }
    }

   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sosCell", for: indexPath)
        
        cell.textLabel?.text = soss?[indexPath.row].getNota()
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        cell.detailTextLabel?.text = dateFormatter.string(from: (soss?[indexPath.row].getTime())!)
        
        if soss![indexPath.row].getVisualizzata() == 1{
            cell.accessoryType = .checkmark}
        else{
            cell.accessoryType = .none
        }
        //            cell.detailTextLabel?.text = dictProfile[indexPath.row]
        
        
        return cell
    }
  

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
