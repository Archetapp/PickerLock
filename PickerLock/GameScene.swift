//
//  GameScene.swift
//  PickerLock
//
//  Created by Jared Davidson on 9/17/15.
//  Copyright (c) 2015 Archetapp. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var Circle = SKSpriteNode()
    var Person = SKSpriteNode()
    var Dot = SKSpriteNode()
    
    var Path = UIBezierPath()
    
    var gameStarted = Bool()
    
    var movingClockwise = Bool()
    var intersected = false
    
    override func didMoveToView(view: SKView) {
       loadView()
    }
    
    func loadView(){
        backgroundColor = SKColor.whiteColor()
        Circle = SKSpriteNode(imageNamed: "Circle")
        Circle.size = CGSize(width: 300, height: 300)
        Circle.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        self.addChild(Circle)
        
        Person = SKSpriteNode(imageNamed: "Person")
        Person.size = CGSize(width: 40, height: 7)
        Person.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 + 120)
        Person.zRotation = 3.14 / 2
        Person.zPosition = 2.0
        self.addChild(Person)
        AddDot()
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if gameStarted == false{
            moveClockWise()
            movingClockwise = true
            gameStarted = true
        }
        else if gameStarted == true{
            DotTouched()
            if movingClockwise == true{
                
                moveCounterClockWise()
                movingClockwise = false
            }
            else if movingClockwise == false{
                
                moveClockWise()
                movingClockwise = true
            }
            
        }
        
        
        
    }
    
    
    
    func AddDot(){
        
        Dot = SKSpriteNode(imageNamed: "Dot")
        Dot.size = CGSize(width: 30, height: 30)
        Dot.zPosition = 1.0
        
        let dx = Person.position.x - self.frame.width / 2
        let dy = Person.position.y - self.frame.height / 2
        
        let rad = atan2(dy, dx)
        
        if movingClockwise == true{
            let tempAngle = CGFloat.random(min: rad + 1.0, max: rad + 2.5)
            let Path2 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width / 2, y: self.frame.height / 2), radius: 120, startAngle: tempAngle, endAngle: tempAngle + CGFloat(M_PI * 4), clockwise: true)
            Dot.position = Path2.currentPoint
            
        }
        else if movingClockwise == false{
            let tempAngle = CGFloat.random(min: rad - 1.0, max: rad - 2.5)
            let Path2 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width / 2, y: self.frame.height / 2), radius: 120, startAngle: tempAngle, endAngle: tempAngle + CGFloat(M_PI * 4), clockwise: true)
            Dot.position = Path2.currentPoint

            
        }
        self.addChild(Dot)
        
        
    }
    
    
    func moveClockWise(){
        
        let dx = Person.position.x - self.frame.width / 2
        let dy = Person.position.y - self.frame.height / 2

        let rad = atan2(dy, dx)
        
        Path = UIBezierPath(arcCenter: CGPoint(x: self.frame.width / 2, y: self.frame.height / 2), radius: 120, startAngle: rad, endAngle: rad + CGFloat(M_PI * 4), clockwise: true)
        let follow = SKAction.followPath(Path.CGPath, asOffset: false, orientToPath: true, speed: 200)
        Person.runAction(SKAction.repeatActionForever(follow).reversedAction())
        
    }
    
    func moveCounterClockWise(){
        
        let dx = Person.position.x - self.frame.width / 2
        let dy = Person.position.y - self.frame.height / 2
        
        let rad = atan2(dy, dx)
        
        Path = UIBezierPath(arcCenter: CGPoint(x: self.frame.width / 2, y: self.frame.height / 2), radius: 120, startAngle: rad, endAngle: rad + CGFloat(M_PI * 4), clockwise: true)
        let follow = SKAction.followPath(Path.CGPath, asOffset: false, orientToPath: true, speed: 200)
        Person.runAction(SKAction.repeatActionForever(follow))

        
    }
    
    func DotTouched(){
        if intersected == true{
            Dot.removeFromParent()
            AddDot()
            intersected = false

        }
        else if intersected == false{
            
            died()
        }
        
    }
    
    func died(){
        self.removeAllChildren()
        let action1 = SKAction.colorizeWithColor(UIColor.redColor(), colorBlendFactor: 1.0, duration: 0.2)
        let action2 = SKAction.colorizeWithColor(UIColor.whiteColor(), colorBlendFactor: 1.0, duration: 0.2)
        self.scene?.runAction(SKAction.sequence([action1,action2]))
        movingClockwise = false
        intersected = false
        gameStarted = false
        self.loadView()

        
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        if Person.intersectsNode(Dot){
            intersected = true
      
        }
        else{
            if intersected == true{
                if Person.intersectsNode(Dot) == false{
                    died()
                }
                
            }
            
        }
        
        
    }
}
















