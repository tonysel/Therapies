//
//  PageViewController.swift
//  Tesi
//
//  Created by TonySellitto on 16/05/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit

class PageViewController: UIViewController, UIPageViewControllerDataSource {
    
    
    
    var pageViewController : UIPageViewController?
    //    let contentImages = ["gauge","first","second"]
    let contentText = ["Benvenuto.\nTherapieSafe ti aiuterà a ricordare le terapie fornite dal tuo medico.", "Quest'ultimo assegna il tuo piano di trattamento e ti fornisce un semplice qrCode personale da scannerizzare.", "Sarai in grado di:\nvedere le terapie da fare entro una settimana e quelle già fatte;\n                           ricevere notifiche;\ninviare un sos silenzioso in qualsiasi momento al proprio medico.", "Inizia scannerizzando il qrCode a te assegnato"]
    
    //    var backgroundImage : [UIImage?] = [ #imageLiteral(resourceName: "simbols"),#imageLiteral(resourceName: "simbols3"), #imageLiteral(resourceName: "simbols2") , nil ]
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        
        //        guard let vcIndex = viewControllerList.index(of: viewController) else{return nil}
        //
        //        let previousIndex = vcIndex - 1
        //
        //        guard previousIndex >= 0 else{return nil}
        //
        //        guard viewControllerList.count > previousIndex else{return nil}
        //
        //        return viewControllerList[previousIndex]
        
        let itemController = viewController as! ItemViewController
        
        if itemController.itemIndex > 0{
            return getItemController(itemController.itemIndex - 1)
        }
        
        return nil
    }
    
    //    func currentControllerIndex() -> Int{
    //        let pageItemController = self.currentControllerIndex()
    //        if let controller = pageItemController as? ItemViewController{
    //            return controller.itemIndex
    //        }
    //        return -1
    //    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        
        let itemController = viewController as! ItemViewController
        
        if itemController.itemIndex + 1 < contentText.count{
            return getItemController(itemController.itemIndex + 1)
        }
        
        return nil
        
        
        
        //        guard let vcIndex = viewControllerList.index(of: viewController) else{return nil}
        //
        //        let nextIndex = vcIndex + 1
        //
        //        guard viewControllerList.count != nextIndex else{return nil}
        //
        //        guard viewControllerList.count > nextIndex else{return nil}
        //
        //        return viewControllerList[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return contentText.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    
    
    func currentController() -> UIViewController?{
        if(self.pageViewController?.viewControllers?.count)! > 0 {
            return self.pageViewController?.viewControllers![0]
        }
        return nil
    }
    
    func getItemController(_ itemIndex : Int) -> UIViewController?{
        
        let colorTop =  UIColor(red: 48.0/255.0, green: 210.0/255.0, blue: 190.0/255.0, alpha: 1).cgColor
        let colorBottom = UIColor(red: 52.0/255.0, green: 147.0/255.0, blue: 196.0/255.0, alpha: 1).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorTop, colorBottom]
        //gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        //gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.locations = [ 0.0, 0.83]
        
        //gradientLayer.frame = (self.pageViewController?.view.bounds)!
        
        let pageItemController = self.storyboard?.instantiateViewController(withIdentifier: "ItemController") as! ItemViewController
        
        if itemIndex < contentText.count - 1{
            
            
            pageItemController.messageStartButton = "Skip Intro"
            //pageItemController.startButtonVisible = false
            
            
            pageItemController.itemIndex = itemIndex
            //          pageItemController.imageName = contentImages[itemIndex]
            pageItemController.label = contentText[itemIndex]
            
            //pageItemController.text.font =  UIFont.systemFont(ofSize: 19, weight: .regular)
            
            let bgImageView = UIImageView(frame: self.view.frame)
            //         bgImageView.image = backgroundImage[itemIndex]
            bgImageView.contentMode = .scaleAspectFill
            bgImageView.alpha = 0.6
            //bgImageView.sizeToFit()
            
            gradientLayer.frame = pageItemController.view.bounds
            
            pageItemController.view.layer.insertSublayer(gradientLayer, at: 0)
            
            pageItemController.view.insertSubview(bgImageView, at: 1)
            
            return pageItemController
        }
        
        if itemIndex == contentText.count - 1{
            
            pageItemController.itemIndex = itemIndex
            
            
            pageItemController.messageStartButton = "Start"
            
            pageItemController.label = contentText[itemIndex]
            
            let bgImageView = UIImageView(frame: self.view.frame)
            
            bgImageView.contentMode = .scaleAspectFill
            
            bgImageView.alpha = 0.6
            
            gradientLayer.frame = pageItemController.view.bounds
            
            pageItemController.view.layer.insertSublayer(gradientLayer, at: 0)
            
            pageItemController.view.insertSubview(bgImageView, at: 1)
            
            return pageItemController
        }
        return nil
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setGradientBackground()
        createPageViewController()
        setupPageControl()
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func createPageViewController(){
        let pageController = self.storyboard?.instantiateViewController(withIdentifier: "PageController") as! UIPageViewController
        pageController.dataSource = self
        
        if contentText.count > 0{
            let firstController = getItemController(0)!
            let startingViewControllers = [firstController]
            pageController.setViewControllers(startingViewControllers, direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        }
        pageViewController = pageController
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController?.didMove(toParentViewController: self)
        
    }
    
    func setupPageControl(){
        
        let colorAppaerence =  UIColor(red: 52.0/255.0, green: 147.0/255.0, blue: 196.0/255.0, alpha: 1)
        let colorBottom =  UIColor(red: 48.0/255.0, green: 210.0/255.0, blue: 190.0/255.0, alpha: 1).cgColor
        let colorTop = UIColor(red: 52.0/255.0, green: 147.0/255.0, blue: 196.0/255.0, alpha: 1).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorTop, colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.locations = [ 0.5, 0.65]
        gradientLayer.frame = self.view.bounds
        
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.darkGray
        appearance.currentPageIndicatorTintColor = UIColor.white
        appearance.backgroundColor = colorAppaerence
        
        
    }
    
    
}

