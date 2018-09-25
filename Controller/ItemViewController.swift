//
//  ItemViewController.swift
//  Tesi
//
//  Created by TonySellitto on 16/05/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit
import AVFoundation
import NotificationCenter
import UserNotifications


class ItemViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    func onFailure() {
        //debugPrint("error")
    }
    
    func onSuccess() {
        debugPrint("success")
    }

//    var plistURL : URL {
//        let documentDirectoryURL =  try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        return documentDirectoryURL.appendingPathComponent("data.plist")
//    }
    
    func savePropertyList(_ plist: Any) throws{
        let plistPath:String? = Bundle.main.path(forResource: "data", ofType: "plist")!

            let plistData = try PropertyListSerialization.data(fromPropertyList: plist, format: .xml, options: 0)
            try plistData.write(to: URL(string: plistPath!)!)
        }
    
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var itemIndex : Int = 0
    var imageName : String = ""{
        didSet{
            if let imageView = contentImageView{
                imageView.image = UIImage(named: imageName)
            }
            
        }
    }
 
    @IBOutlet weak var text: UILabel!
    
    var label : String = ""

    var messageStartButton = "Hello!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        startButton.setTitle(messageStartButton, for: .normal)
        self.startButton.layer.cornerRadius = 8
//        self.startButton.layer.borderWidth = 1
        
        text.text! = label
        text.sizeToFit()
        text.numberOfLines = 0
        //        text.textAlignment = .left
        text.lineBreakMode = .byWordWrapping //Avenir
        //        text.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        text.textColor = UIColor.white
        
        self.view.addSubview(text)
        text.adjustsFontSizeToFitWidth = true
        
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var contentImageView: UIImageView!
    
    
   
    @IBOutlet weak var startButton: UIButton!

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
