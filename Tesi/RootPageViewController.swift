//
//  RootPageViewController.swift
//  Tesi
//
//  Created by TonySellitto on 15/04/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit

class RootPageViewController: UIPageViewController, UIPageViewControllerDataSource{
    
    lazy var viewControllerList : [UIViewController] = {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = sb.instantiateViewController(withIdentifier: "ItemController")
        let vc2 = sb.instantiateViewController(withIdentifier: "qrCodeController")
        return [vc1, vc2]
    }()
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllerList.index(of: viewController) else{return nil}
        
        let previousIndex = vcIndex - 1
        
        guard previousIndex >= 0 else{return nil}
        
        guard viewControllerList.count > previousIndex else{return nil}
        
        return viewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = viewControllerList.index(of: viewController) else{return nil}
        
        let nextIndex = vcIndex + 1
        
        guard viewControllerList.count != nextIndex else{return nil}
        
        guard viewControllerList.count > nextIndex else{return nil}
        
        return viewControllerList[nextIndex]
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
       // self.setGradientBackground()
        if let firstViewController = viewControllerList.first{
            self.setViewControllers([firstViewController
                ], direction: .forward, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
