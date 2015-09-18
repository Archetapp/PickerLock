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
    
    var Path = UIBezierPath()
    
    var gameStarted = Bool()
    
    var movingClockwise = Bool()
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        Circle = SKSpriteNode(imageNamed: "Circle")
        Circle.size = CGSize(width: 300, height: 300)
        Circle.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        self.addChild(Circle)
        
        Person = SKSpriteNode(imageNamed: "Person")
        Person.size = CGSize(width: 40, height: 7)
        Person.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 + 120)
        Person.zRotation = 3.14 / 2
        self.addChild(Person)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if gameStarted == false{
            moveClockWise()
            movingClockwise = true
            gameStarted = true
        }
        else if gameStarted == true{
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
    
    func moveClockWise(){
        
        var dx = Person.position.x - self.frame.width / 2
        var dy = Person.position.y - self.frame.height / 2

        var rad = atan2(dy, dx)
        
        Path = UIBezierPath(arcCenter: CGPoint(x: self.frame.width / 2, y: self.frame.height / 2), radius: 120, startAngle: rad, endAngle: rad + CGFloat(M_PI * 4), clockwise: true)
        let follow = SKAction.followPath(Path.CGPath, asOffset: false, orientToPath: true, speed: 200)
        Person.runAction(SKAction.repeatActionForever(follow).reversedAction())
        
    }
    
    func moveCounterClockWise(){
        
        var dx = Person.position.x - self.frame.width / 2
        var dy = Person.position.y - self.frame.height / 2
        
        var rad = atan2(dy, dx)
        
        Path = UIBezierPath(arcCenter: CGPoint(x: self.frame.width / 2, y: self.frame.height / 2), radius: 120, startAngle: rad, endAngle: rad + CGFloat(M_PI * 4), clockwise: true)
        let follow = SKAction.followPath(Path.CGPath, asOffset: false, orientToPath: true, speed: 200)
        Person.runAction(SKAction.repeatActionForever(follow))

        
    }
    
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
