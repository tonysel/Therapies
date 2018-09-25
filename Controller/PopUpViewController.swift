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
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    public var image = UIImage()

    var imageView = UIImageView()
    
    // - MARK: cancelPressed
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        self.removeFromParentViewController()
//        self.dismiss(animated: true, completion: nil)
        self.delegate?.onCancel()
        
    }
    
    var textLabel = UILabel()
    
//    @IBOutlet weak var popUpView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: 245, height: 400)
     
//        textLabel.translatesAutoresizingMaskIntoConstraints = false
//        textLabel.sizeToFit()
//        textLabel.numberOfLines = 0
//        //        text.textAlignment = .left
//        textLabel.lineBreakMode = .byWordWrapping //Avenir
//        textLabel.font = UIFont.systemFont(ofSize: 17, weight: .light)
//
//        textLabel.adjustsFontSizeToFitWidth = true
//        scrollView.backgroundColor = .clear
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.sizeToFit()
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byWordWrapping
        
        textLabel.font = UIFont.systemFont(ofSize: 17, weight: .light)
        
        textLabel.adjustsFontSizeToFitWidth = true
        
        scrollView.backgroundColor = .clear
        
//        scrollView.contentSize = CGSize(width: screenWidth, height: 2000)

        self.scrollView.addSubview(textLabel)
        self.scrollView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: -20)
        let widthConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 200)
        let heightConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 140)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        let horizontalConstraint1 = NSLayoutConstraint(item: textLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint1 = NSLayoutConstraint(item: textLabel, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: scrollView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: self.imageView.frame.height + 150)
        let widthConstraint1 = NSLayoutConstraint(item: textLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 200)
        let heightConstraint1 = NSLayoutConstraint(item: textLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 220)
        NSLayoutConstraint.activate([horizontalConstraint1, verticalConstraint1, widthConstraint1, heightConstraint1])

        self.view.addSubview(scrollView)
        
//        scrollView.frame.origin.y = self.cancelButton.frame.height + 20
        
        self.cancelButton.layer.cornerRadius = 8
        self.imageView.image = self.image
        self.imageView.layer.shadowColor = UIColor.darkGray.cgColor
        self.imageView.layer.shadowOpacity = 1

        self.view.layer.cornerRadius = 12
        
        self.view.layer.shadowColor = UIColor.darkGray.cgColor
        self.view.layer.shadowOpacity = 0.2
        
        
        self.textLabel.font = UIFont.systemFont(ofSize: 17.0)
        
        //                self.popUp?.textLabel.text = nameEnvironment.uppercased()
        
        
//        self.textLabel.textColor = .lightGray
        
        //                self.popUp?.textLabel.font = self.popUp?.textLabel.font
//        self.textLabel. font.with(traits: [ .traitItalic, .traitBold, .classOldStyleSerifs ])
        
        self.textLabel.textAlignment = .center
        
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
