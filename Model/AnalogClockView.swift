//
//  AnalogClockView.swift
//  Tesi
//
//  Created by TonySellitto on 16/06/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit

public class AnalogClockView: UIView {
    var shapeLayer: CAShapeLayer!
    var circleLayer: CALayer!
    var hourHandLayer: CALayer!
    var minuteHandLayer: CALayer!
    var secondHandLayer: CALayer!
    var circlePath: UIBezierPath!
    var hours : Int!
    var minutes : Int!
    
    public init(view: UIView){
        super.init(frame: view.frame)
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func draw(_ rect: CGRect) {
      
//        DispatchQueue.main.async {
        
            // Take shorter of both sides
            if rect.size.width > rect.size.height {
                self.circlePath = UIBezierPath(arcCenter: CGPoint(x: rect.size.width / 2, y: rect.size.height / 2), radius: rect.size.height / 2, startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
            } else {
                self.circlePath = UIBezierPath(arcCenter: CGPoint(x: rect.size.width / 2, y: rect.size.height / 2), radius: rect.size.width / 2, startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
            }

            self.shapeLayer = CAShapeLayer()
            self.shapeLayer.path = self.circlePath.cgPath

            // Set fill color to clear
            self.shapeLayer.fillColor = UIColor.clear.cgColor
            // Set the border color to black
            self.shapeLayer.strokeColor = UIColor.black.cgColor
            // Set width of border
            self.shapeLayer.lineWidth = 1.0

            self.layer.addSublayer(self.shapeLayer)

            // Instantiate circleLayer and put it into the main rect
            self.circleLayer = CALayer()
            self.circleLayer.frame = rect
            self.layer.addSublayer(self.circleLayer)

            // Create replicatorLayer to make a complete circle consisting of 12 parts
            let replicatorLayerFat = CAReplicatorLayer()

            // Offset to put both replicator layers into the vertical center
            let offsetY = (rect.size.height - rect.size.width) / 2

            if rect.size.width > rect.size.height {
                replicatorLayerFat.frame = rect
            } else {
                replicatorLayerFat.frame =  CGRect(x: rect.minX, y: offsetY, width: rect.width, height: rect.width)
            }


            replicatorLayerFat.instanceCount = 12

            // 12 instances (360deg / 12) -> angle for each part
            let angleFat = Float(Double.pi * 2.0) / 12

            // Add correct angle for each part to replicatorLayer
            replicatorLayerFat.instanceTransform = CATransform3DMakeRotation(CGFloat(angleFat), 0.0, 0.0, 1.0)
            self.layer.addSublayer(replicatorLayerFat)

            // Create layer that will be replicated 12 times to form a complete circle
            let instanceLayerFat = CALayer()
            let layerWidthFat: CGFloat = 2.0
            let midXFat = rect.midX - layerWidthFat / 2.0

            instanceLayerFat.frame = CGRect(x: midXFat, y: 0.0, width: layerWidthFat, height: 7)
            instanceLayerFat.backgroundColor = UIColor.black.cgColor
            replicatorLayerFat.addSublayer(instanceLayerFat)

            // Create replicatorLayer to make a complete circle consisting of 12 parts
            let replicatorLayerThin = CAReplicatorLayer()

            if rect.size.width > rect.size.height {
                replicatorLayerThin.frame = rect
            } else {
                replicatorLayerThin.frame =  CGRect(x: rect.minX, y: offsetY, width: rect.width, height: rect.width)
            }

            replicatorLayerThin.instanceCount = 60

            // 12 instances (360deg / 12) -> angle for each part
            let angleThin = Float(Double.pi * 2.0) / 60

            // Add correct angle for each part to replicatorLayer
            replicatorLayerThin.instanceTransform = CATransform3DMakeRotation(CGFloat(angleThin), 0.0, 0.0, 1.0)
            self.layer.addSublayer(replicatorLayerThin)

            // Create layer that will be replicated 12 times to form a complete circle
            let instanceLayerThin = CALayer()
            let layerWidthThin: CGFloat = 0.6
            let midXThin = rect.midX - layerWidthThin / 2.0
            instanceLayerThin.frame = CGRect(x: midXThin, y: 0.0, width: layerWidthThin, height: 4)
            instanceLayerThin.backgroundColor = UIColor.black.cgColor
            replicatorLayerThin.addSublayer(instanceLayerThin)
        
            // Create and draw hour hand layer
            self.hourHandLayer = CALayer()
            self.hourHandLayer.backgroundColor = UIColor.black.cgColor
            // Puts the center of the rectangle in the center of the clock
            self.hourHandLayer.anchorPoint = CGPoint(x: 0.5, y: 0.1)
            // Positions the hand in the middle of the clock
            self.hourHandLayer.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
            
            // Create and draw minute hand layer
            self.minuteHandLayer = CALayer()
            self.minuteHandLayer.backgroundColor = UIColor.black.cgColor
            // Puts the center of the rectangle in the center of the clock
            self.minuteHandLayer.anchorPoint = CGPoint(x: 0.5, y: 0.1)
            // Positions the hand in the middle of the clock
            self.self.minuteHandLayer.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
            
//                    // Create and draw second hand layer
            self.secondHandLayer = CALayer()
            self.secondHandLayer.backgroundColor = UIColor.red.cgColor
            // Puts the center of the rectangle in the center of the clock
            self.secondHandLayer.anchorPoint = CGPoint(x: 0.5, y: 0.1)
            // Positions the hand in the middle of the clock
            self.secondHandLayer.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        
            // Set size of all hands
            if self.frame.size.width > self.frame.size.height {
                self.hourHandLayer.bounds = CGRect(x: 0, y: 0, width: 3, height: (self.frame.size.height / 2) - (self.frame.size.height * 0.2))
                self.minuteHandLayer.bounds = CGRect(x: 0, y: 0, width: 2, height: (self.frame.size.height / 2) - (self.frame.size.height * 0.1))
                self.secondHandLayer.bounds = CGRect(x: 0, y: 0, width: 1.2, height: self.frame.size.height / 2)
            } else {
                self.hourHandLayer.bounds = CGRect(x: 0, y: 0, width: 3, height: (self.frame.size.width / 2) - (self.frame.size.width * 0.2))
                self.minuteHandLayer.bounds = CGRect(x: 0, y: 0, width: 2, height: (self.frame.size.width / 2) - (self.frame.size.width * 0.1))
                self.secondHandLayer.bounds = CGRect(x: 0, y: 0, width: 1.2, height: self.frame.size.width / 2)
            }
            
            // Add all hand layers to as sublayers
            self.circleLayer.addSublayer(self.hourHandLayer)
            self.circleLayer.addSublayer(self.minuteHandLayer)
            self.circleLayer.addSublayer(self.secondHandLayer)
        
            // Get current hours, minutes and seconds
            let date = Date()
            let calendar = Calendar.current
//            let hours = calendar.component(.hour, from: date)
//            let minutes = calendar.component(.minute, from: date)
            let seconds = calendar.component(.second, from: date)
        
            // Calculate the angles for the each hand
            let hourAngle = CGFloat(self.hours * (360 / 12)) + CGFloat(self.minutes) * (1.0 / 60) * (360 / 12)
            let minuteAngle = CGFloat(self.minutes * (360 / 60))
            let secondsAngle = CGFloat(seconds * (360 / 60))
        
            // Transform the hands according to the calculated angles
            self.hourHandLayer.transform = CATransform3DMakeRotation(hourAngle, 0, 0, 1)
            self.minuteHandLayer.transform = CATransform3DMakeRotation(minuteAngle, 0, 0, 1)
            self.secondHandLayer.transform = CATransform3DMakeRotation(secondsAngle / CGFloat(180 * Double.pi), 0, 0, 1)
        
//             Create animation for seconds hand
            let secondsHandAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            // Runs forever
            secondsHandAnimation.repeatCount = Float.infinity
            // One animation (360deg) takes 60 seconds
            secondsHandAnimation.duration = 60
            secondsHandAnimation.isRemovedOnCompletion = false
            secondsHandAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            // From start angle (according to calculated angle from time) plus 360deg which equals 1 rotation
            secondsHandAnimation.fromValue = (secondsAngle + 180) * CGFloat(Double.pi / 180)
            secondsHandAnimation.byValue = 2 * Double.pi
            self.secondHandLayer.add(secondsHandAnimation, forKey: "secondsHandAnimation")
        
            // Create animation for minutes hand
            let minutesHandAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            // Runs forever
            minutesHandAnimation.repeatCount = Float.infinity
            // One animation (360deg) takes 60 minutes (1 hour)
            minutesHandAnimation.duration = 60 * 60
            minutesHandAnimation.isRemovedOnCompletion = false
            minutesHandAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            // From start angle (according to calculated angle from time) plus 360deg which equals 1 rotation
            minutesHandAnimation.fromValue = (minuteAngle + 180) * CGFloat(Double.pi / 180)
            minutesHandAnimation.byValue = 2 * Double.pi
            self.minuteHandLayer.add(minutesHandAnimation, forKey: "minutesHandAnimation")
        
            // Create animation for hours hand
            let hoursHandAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            // Runs forever
            hoursHandAnimation.repeatCount = Float.infinity
            // One animation (360deg) takes 12 hours
            hoursHandAnimation.duration = CFTimeInterval(60 * 60 * 12);
            hoursHandAnimation.isRemovedOnCompletion = false
            hoursHandAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            // From start angle (according to calculated angle from time) plus 360deg which equals 1 rotation
            hoursHandAnimation.fromValue = (hourAngle + 180)  * CGFloat(Double.pi / 180)
            hoursHandAnimation.byValue = 2 * Double.pi
            self.hourHandLayer.add(hoursHandAnimation, forKey: "hoursHandAnimation")

    }
 
}


