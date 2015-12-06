//
//  GameScene.swift
//  BigBird
//
//  Created by baby on 15/12/6.
//  Copyright (c) 2015年 baby. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var energy:CGFloat = 100
    var background = SKSpriteNode()
    var bird = SKSpriteNode()
    var water = SKSpriteNode()
    var tornato = SKSpriteNode()
    
    
    override func didMoveToView(view: SKView) {
        setupBackground()
        
        let sun = SKSpriteNode(imageNamed: "sun")
        sun.position = CGPointMake(frame.width/2 - UIScreen.mainScreen().bounds.width/2 + 30, frame.height - 50)
        sun.zPosition = -1
        addChild(sun)
        
        setupBird()
        setupTornato()
        
        let bottomBound = SKNode()
        bottomBound.position = CGPointMake(0, 0)
        bottomBound.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(frame.width, 1))
        bottomBound.physicsBody?.dynamic = false
        addChild(bottomBound)
        
        setupWater()
        NSTimer.scheduledTimerWithTimeInterval( 2, target: self, selector: "setupTornato", userInfo: nil, repeats: true)

    }
    
    func setupBackground(){
        let bgTexture = SKTexture(imageNamed: "background")
        let moveBg = SKAction.moveByX(-bgTexture.size().width, y: 0, duration: 10)
        let replaceBg = SKAction.moveByX(bgTexture.size().width, y: 0, duration: 0)
        let moveBgForever = SKAction.repeatActionForever(SKAction.sequence([moveBg,replaceBg]))
        for i in 0...1{
        background = SKSpriteNode(texture: bgTexture)
        background.position = CGPointMake(bgTexture.size().width/2 + bgTexture.size().width * CGFloat(i), CGRectGetMidY(frame))
        background.zPosition = -5
        background.size.height = frame.size.height
        background.runAction(moveBgForever)
        addChild(background)
        }
    }
    
    func setupWater(){
        let waterTexture = SKTexture(imageNamed: "water")
        let moveBg = SKAction.moveByX(-waterTexture.size().width, y: 0, duration: 10)
        let replaceBg = SKAction.moveByX(waterTexture.size().width, y: 0, duration: 0)
        let moveBgForever = SKAction.repeatActionForever(SKAction.sequence([moveBg,replaceBg]))
        for i in 0...1{
            water = SKSpriteNode(texture: waterTexture)
            water.anchorPoint = CGPointMake(0.5, 0)
            water.position = CGPointMake(waterTexture.size().width/2 + waterTexture.size().width * CGFloat(i), 0)
            water.zPosition = 5
            water.size.height = frame.size.height * 160 / 667
            water.runAction(moveBgForever)
            addChild(water)
        }
    }
    
    func setupBird(){
        let birdTexture1 = SKTexture(imageNamed: "bird1")
        let birdTexture2 = SKTexture(imageNamed: "bird2")
        let birdTexture3 = SKTexture(imageNamed: "bird3")
        let birdTexture4 = SKTexture(imageNamed: "bird2")
        let fly = SKAction.animateWithTextures([birdTexture1,birdTexture2,birdTexture3,birdTexture4], timePerFrame: 0.2)
        let flyForever = SKAction.repeatActionForever(fly)
        bird = SKSpriteNode(texture: birdTexture1)
        bird.position = CGPointMake(CGRectGetMidX(frame) - 120, CGRectGetMidY(frame))
        bird.runAction(flyForever)
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture1.size().height/2)
        bird.physicsBody?.dynamic = true
        addChild(bird)
        
    }
    
    func setupTornato(){
        
            let offset = CGFloat(arc4random_uniform(UInt32(frame.height/2.5))) - frame.height/5
            let tornatoTexture = SKTexture(imageNamed: "tornado")
            let moveTornato = SKAction.moveByX(-frame.width * 2, y: 0, duration:NSTimeInterval(frame.width/100))
            let removeTornato = SKAction.removeFromParent()
            let moveAndRemovePies = SKAction.sequence([moveTornato,removeTornato])
            tornato = SKSpriteNode(texture: tornatoTexture)
            tornato.position = CGPointMake(CGRectGetMidX(frame) + frame.width, CGRectGetMidY(frame) + offset)
            tornato.physicsBody = SKPhysicsBody(rectangleOfSize: tornatoTexture.size())
            tornato.physicsBody?.dynamic = false
            tornato.runAction(moveAndRemovePies)
            addChild(tornato)

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       
        bird.physicsBody?.velocity = CGVectorMake(0, 0)
        energy = min(energy,80)
        bird.physicsBody?.applyImpulse(CGVectorMake(0, energy))
//        if energy > 0 {
//            energy--
//        }
        
  
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
