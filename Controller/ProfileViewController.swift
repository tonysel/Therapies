//
//  ProfileViewController.swift
//  Tesi
//
//  Created by TonySellitto on 17/05/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 48.0/255.0, green: 210.0/255.0, blue: 190.0/255.0, alpha: 1).cgColor
        let colorBottom = UIColor(red: 52.0/255.0, green: 147.0/255.0, blue: 196.0/255.0, alpha: 1).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorTop, colorBottom]
        //gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        //gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.locations = [ 0.0, 0.83]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0){
            return dictProfile.count
        }
        else{
            return dictClinicalBrief.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath)
        if (indexPath.section == 0){
            cell.textLabel?.text = dictProfile[indexPath.row]
            cell.detailTextLabel?.text = titles[indexPath.row]
        }
        else if(indexPath.section == 1){
            cell.textLabel?.text = dictClinicalBrief[indexPath.row]
            cell.detailTextLabel?.text = titles[indexPath.row + 3]
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
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
        label.frame = CGRect(x: self.view.frame.midX - 100, y: 7, width: 200, height: 15)
        
        if (section == 0){
            label.text = "About Me"
        }
        else{
            label.text =  "Cartella Clinica Personale"
        }
        
        headerView.addSubview(label)
        
        
        return headerView
    }
    
    var dictProfile = [Int: String]()
    
    var dictClinicalBrief = [Int : String]()
    
    var titles = ["Nome", "Cognome", "Codice Fiscale", "Medico Controllo", "Ultima Modifica Terapia", "Prossimo Controllo"]
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate

    @IBOutlet weak var profileTableView: UITableView!
    
    @IBOutlet weak var signOutButton: UIButton!
    
    @IBAction func signOut(_ sender: UIButton) {
        
        
        UserDefaults.standard.set(false, forKey: "notFirstTime")
        self.dismiss(animated: true, completion: nil)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "PageControl")
//        navigationController?.pushViewController(vc!, animated: true)
//        navigationController?.popViewController(animated: true)
        self.present(vc!, animated: true, completion: nil)
//        self.dismiss(animated: true, completion: nil)
        appDelegate?.paziente = nil
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.signOutButton.layer.cornerRadius = 8
        self.signOutButton.layer.borderWidth = 1
        self.signOutButton.layer.borderColor = UIColor.white.cgColor
        
//        self.setGradientBackground()
        
        self.profileTableView.delegate = self
        self.profileTableView.dataSource = self
        self.profileTableView.isScrollEnabled = false
        self.profileTableView.tableFooterView = UIView()
    
        dictProfile[0] = appDelegate?.paziente?.getNome()
        dictProfile[1] = appDelegate?.paziente?.getCognome()
        dictProfile[2] = appDelegate?.paziente?.getCodiceFiscale()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        dictClinicalBrief[0] = "\(appDelegate?.paziente?.getMedicoControllo().getNome()  ?? "Mario") \(appDelegate?.paziente?.getMedicoControllo().getCognome() ?? "Bianchi")"
        
        dictClinicalBrief[1] = dateFormatter.string(from: (appDelegate?.paziente?.getUltimaModifica())!)
            
        dictClinicalBrief[2] = dateFormatter.string(from: (appDelegate?.paziente?.getProssimoControllo())!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
