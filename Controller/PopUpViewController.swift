//
//  PopUpViewController.swift
//  Tesi
//
//  Created by TonySellitto on 09/06/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    var delegate : PopUpViewControllerDelegate?
    
    @IBOutlet weak var cancelButton: UIButton!
    
    public var image = UIImage()

    @IBOutlet weak var imageView: UIImageView!
    @IBAction func cancelPressed(_ sender: UIButton) {
        self.removeFromParentViewController()
//        self.dismiss(animated: true, completion: nil)
        self.delegate?.onCancel()
        
    }
    
//    @IBOutlet weak var popUpView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let blur = UIBlurEffectStyle()
//        self.view.isOpaque = false
        
        self.cancelButton.layer.cornerRadius = 8
        self.imageView.image = self.image
        self.imageView.layer.shadowColor = UIColor.darkGray.cgColor
        self.imageView.layer.shadowOpacity = 1

        self.view.layer.cornerRadius = 12
        
        self.view.layer.shadowColor = UIColor.darkGray.cgColor
        self.view.layer.shadowOpacity = 0.4
        
//        self.popUpView.layer.shadowColor = UIColor(named: "black")?.cgColor
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

protocol PopUpViewControllerDelegate {
    func onCancel()
}
