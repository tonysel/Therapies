//
//  ClockScene.swift
//  Tesi
//
//  Created by TonySellitto on 25/05/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit
import SpriteKit

class ClockScene: SKScene {
    public static var clockScene = ClockScene()
    
//    var arrayChromosomes = [SKSpriteNode]()
//    var isCreated = false
//    var circle : UIBezierPath!
//    var circularMove = SKAction()
//    var countUniversal = 1
//    var bg : SKSpriteNode!
//    var soundCorrect : SKAction!
//    
//    public override func sceneDidLoad() {
//        soundCorrect = SKAction.playSoundFileNamed("soundCorrect.mp3", waitForCompletion: false)
//        
//        
//    }
//    //MARK: function for test
//    public func demo(){
//        if isCreated == false{
//            let node = SKSpriteNode(imageNamed: "cromosomeX")
//            node.name = "cromosomeDemo"
//            node.xScale = 0.1
//            node.yScale = 0.1
//            circle = UIBezierPath(arcCenter: CGPoint(x: (self.frame.width/2) , y: (self.frame.midY)), radius: (self.frame.height / 3), startAngle: 0, endAngle: (2 * .pi), clockwise: true)
//            
//            circularMove = SKAction.follow(circle.cgPath, asOffset: false, orientToPath: false, duration: 10)
//            node.zPosition = 10
//            
//            //            array[i].xScale -= CGFloat(0.0004 * Double(i))
//            //            array[i].yScale -= CGFloat(0.0003 * Double(i))
//            self.addChild(node)
//            
//            node.run(SKAction.repeat(circularMove, count: 20))
//            
//        }
//    }
//    
//    
//    
//    public func createChromosome(){
//        
//        if isCreated == false{
//            self.clear()
//            isCreated = true
//        }
//        
//        
//        if countUniversal >= 1 && countUniversal < 46{
//            
//            let node = SKSpriteNode(imageNamed: "cromosomeX")
//            
//            node.xScale = 0.1
//            node.yScale = 0.1
//            arrayChromosomes.append(node)
//            countUniversal += 1
//            let lenght = arrayChromosomes.count
//            
//            circle = UIBezierPath(arcCenter: CGPoint(x: (self.frame.width/2) , y: (self.frame.midY)), radius: (self.frame.height / 3), startAngle:CGFloat( (Double (lenght ) / 46) * (2 * .pi) ), endAngle: CGFloat( Double (lenght ) / 46  * (2 * .pi) + (2 * .pi)), clockwise: true)
//            
//            circularMove = SKAction.follow(circle.cgPath, asOffset: false, orientToPath: false, duration: 0)
//            node.zPosition = CGFloat(arrayChromosomes.count) + 1
//            
//            self.addChild(node)
//            
//            
//            
//            //  array[i].run(sequence)
//            node.run(SKAction.repeat(circularMove, count: 20))
//            
//            
//            //            self.addChild(node)
//            isCreated = true
//        }
//            
//        else if countUniversal == 46{
//            let node = SKSpriteNode(imageNamed: "cromosomeY")
//            
//            node.xScale = 0.18
//            node.yScale = 0.18
//            arrayChromosomes.append(node)
//            countUniversal += 1
//            let lenght = arrayChromosomes.count
//            
//            circle = UIBezierPath(arcCenter: CGPoint(x: (self.frame.width/2) , y: (self.frame.midY)), radius: (self.frame.height / 3), startAngle:CGFloat( (Double (lenght) / 46) * (2 * .pi) ), endAngle: CGFloat( Double (lenght) / 46  * (2 * .pi) + (2 * .pi)), clockwise: true)
//            
//            circularMove = SKAction.follow(circle.cgPath, asOffset: false, orientToPath: false, duration: 0)
//            node.zPosition = CGFloat(arrayChromosomes.count) + 1
//            node.run(SKAction.repeat(circularMove, count: 20))
//            self.addChild(node)
//            
//        }
//            
//        else{
//            self.clear()
//            self.arrayChromosomes.removeAll()
//        }
//    }
//    
//    public func clear(){
//        self.removeAllChildren()
//        self.removeAllActions()
//        bg = SKSpriteNode(imageNamed: "Cells")
//        
//        bg.size = CGSize(width: self.frame.width, height: self.frame.height - 80)
//        bg.alpha = 0.3
//        
//        bg.position = CGPoint(x: size.width / 2, y: (size.height / 2))
//        bg.zPosition = Z.background
//        
//        addChild(bg)
//        
//        isCreated = false
//    }
//    
//    override public func didMove(to view: SKView) {
//        backgroundColor = #colorLiteral(red: 0.942122519, green: 0.7134601474, blue: 0.5796499252, alpha: 1)
//        
//        
//        bg = SKSpriteNode(imageNamed: "Cells")
//        
//        bg.size = CGSize(width: self.frame.width, height: self.frame.height - 80)
//        bg.alpha = 0.3
//        
//        bg.position = CGPoint(x: size.width / 2, y: (size.height / 2 ))
//        bg.zPosition = Z.background
//        
//        addChild(bg)
//        
//        //function for test
//        demo()
//        
//        //        for i in 1...46{
//        //        createChromosome()
//        //        }
//        //
//        //        createNucleus()
//        //print(countUniversal)
//    }
//    
//    public func createNucleus(){
//        if isCreated == true{
//            
//            self.clear()
//            
//            var circle = UIBezierPath()
//            var circularMove = SKAction()
//            
//            
//            
//            for i in 0...arrayChromosomes.count - 1{
//                circle = UIBezierPath(arcCenter: CGPoint(x: (self.frame.width/2) , y: (self.frame.midY)), radius: (self.frame.height / 3), startAngle:CGFloat( (Double (i+1) / 46) * (2 * .pi) ), endAngle: CGFloat( Double (i + 1) / 46 * (2 * .pi) + (2 * .pi)), clockwise: true)
//                circularMove = SKAction.follow(circle.cgPath, asOffset: false, orientToPath: false, duration: 10)
//                arrayChromosomes[i].zPosition = CGFloat(i) + 1
//                arrayChromosomes[i].xScale -= CGFloat(0.001 * Double(i))
//                arrayChromosomes[i].yScale -= CGFloat(0.0007 * Double(i))
//                self.addChild(arrayChromosomes[i])
//                
//                arrayChromosomes[i].run(SKAction.repeat(circularMove,count: 20))
//            }
//        }
//        
//        if arrayChromosomes.count == 46{
//            
//            delay(seconds: 3.5){
//                let nucleus = SKSpriteNode(imageNamed: "nucleus")
//                nucleus.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
//                nucleus.size = CGSize(width: nucleus.frame.width, height: nucleus.frame.height)
//                nucleus.zPosition = 1
//                
//                let endMessage = SKSpriteNode(imageNamed: "message2")
//                endMessage.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
//                endMessage.zPosition = Z.HUD
//                endMessage.size = CGSize(width: endMessage.frame.width/4, height: endMessage.frame.height/4)
//                
//                
//                let scaleBefore = SKAction.scale(by: 0 , duration: 0.8)
//                let scaleLater = SKAction.scale(to: 1.5, duration: 3)
//                let scaleNucleus = SKAction.scale(to: 0.96, duration: 1.5)
//                let sequence = SKAction.sequence([scaleBefore, scaleLater, scaleBefore])
//                let rotationNucleus1 = SKAction.rotate(toAngle: 2 * .pi, duration: 15)
//                let rotationNucleus2 = SKAction.rotate(toAngle: 0, duration: 15)
//                let sequenceRotationNucleus = SKAction.sequence([rotationNucleus1, rotationNucleus2])
//                
//                nucleus.run(scaleNucleus)
//                nucleus.run(SKAction.repeatForever(sequenceRotationNucleus))
//                nucleus.run(self.soundCorrect)
//                
//                endMessage.run(SKAction.repeat(sequence, count: 2))
//                
//                self.addChild(nucleus)
//                self.addChild(endMessage)
//                
//                PlaygroundPage.current.assessmentStatus = .pass(message: "Congratulation ✅, you have created a cell nucleus.")
//                
//            }
//        }
//    }
}
