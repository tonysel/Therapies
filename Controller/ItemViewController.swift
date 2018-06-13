//
//  ItemViewController.swift
//  Tesi
//
//  Created by TonySellitto on 14/04/18.
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
//
    
//    func writeQRCodePaziente(qrCode: String){
//
////        let initialFileURL = URL(fileURLWithPath: Bundle.main.path(forResource: "data", ofType: "plist")!)
////        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
////        let writableFileURL = documentDirectoryURL.appendingPathComponent("data.plist", isDirectory: false)
////
////        do {
////            try FileManager.default.copyItem(at: initialFileURL, to: writableFileURL)
////        } catch {
////            print("Copying file failed with error : \(error)")
////        }
////
//
//
//        var dataFilePath: String? {
//            return Bundle.main.path(forResource: "data", ofType: "plist")
//        }
//
//        var dict: NSMutableDictionary? {
//            guard let filePath = dataFilePath else { return nil }
//            return NSMutableDictionary(contentsOfFile: filePath)
//        }
//
//        let fileManager = FileManager.default
//
//
//        dict?.setObject("1234", forKey: "qrCode" as NSCopying)
//        dict?.write(toFile: dataFilePath!, atomically: true)
//
//            // confirm
//            let resultDict = NSMutableDictionary(contentsOfFile: dataFilePath!)
//            print("saving, dict: \(resultDict)") // I can see this is working
//
//
//        }
//
    
//        do{
//            //convert the data to a dictionary and handle errors.
//            plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &format) as! [String : AnyObject]
//
//            //assign the values in the dictionary to the properties
//            isFirstTimeLogin = plistData["isFirstTimeLogin"] as! Bool
//
//        }
//        catch{ // error condition
//            print("Error reading plist: \(error), format: \(format)")
//        }
//
//        return isFirstTimeLogin
    
    
//    func writeQRCodePaziente(QRCode: String){
                        //
                        //             let plistPath:String? = Bundle.main.path(forResource: "data", ofType: "plist")! //the path of the data
                        //
                        //        let dictionary = NSMutableDictionary(contentsOfFile: plistPath!)
                        //     //   var format = PropertyListSerialization.PropertyListFormat.xml//format of the property list
                        //     //   var plistData: [String:AnyObject] = [:]  //our data
                        //
                        //    //   let plistXML = FileManager.default.contents(atPath: plistPath!)! //the data in XML format
                        //        dictionary?.setValue(QRCode, forKey: "qrCode")
                        //        dictionary?.write(toFile: plistPath!, atomically: false)
                        //       print("FATTOOOOOOOOOO")
        
    func savePropertyList(_ plist: Any) throws{
        let plistPath:String? = Bundle.main.path(forResource: "data", ofType: "plist")!

            let plistData = try PropertyListSerialization.data(fromPropertyList: plist, format: .xml, options: 0)
            try plistData.write(to: URL(string: plistPath!)!)
        }
//    }
    
    
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

    var messageStartButton = "ciaooooo"
    
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
