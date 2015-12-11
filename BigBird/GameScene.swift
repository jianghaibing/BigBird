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
    var distance:Int = 0
    var maxDistance:Int = 0
    
    var background = SKSpriteNode()
    var bird = SKSpriteNode()
    var water = SKSpriteNode()
    var tornato = SKSpriteNode()
    var fish1 = SKSpriteNode()
    var fish2 = SKSpriteNode()
    var distanceLabel = SKLabelNode()
    var maxDistanceLabel = SKLabelNode()
    var startGameButton:ButtonNode!
    
    override func didMoveToView(view: SKView) {
        speed = 0
        setupBackground()
        
        let sun = SKSpriteNode(imageNamed: "sun")
        sun.position = CGPointMake(frame.width/2 - UIScreen.mainScreen().bounds.width/2 + 30, frame.height - 50)
        sun.zPosition = -1
        addChild(sun)
        
        distanceLabel.text = "当前:0M"
        distanceLabel.fontSize = 20
        distanceLabel.fontName = "PingFang SC"
        distanceLabel.position = CGPointMake(CGRectGetMidX(frame)+150, frame.height - 30)
        addChild(distanceLabel)
        
        maxDistanceLabel.text = "当前:0M"
        maxDistanceLabel.fontSize = 20
        maxDistanceLabel.fontName = "PingFang SC"
        maxDistanceLabel.position = CGPointMake(CGRectGetMidX(frame)+150, frame.height - 60)
        addChild(maxDistanceLabel)
        
        setupBird()
        
        let bottomBound = SKNode()
        bottomBound.position = CGPointMake(0, 0)
        bottomBound.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(frame.width, 1))
        bottomBound.physicsBody?.dynamic = false
        addChild(bottomBound)
        
        setupWater()
        
        startGameButton = ButtonNode(normalName: "bird2", selectName: "") { () -> () in
            self.startGame()
        }
        startGameButton.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame))
        
        addChild(startGameButton)
    }
    
    func startGame(){  
        startGameButton.removeFromParent()
        NSTimer.scheduledTimerWithTimeInterval( 2, target: self, selector: "setupTornato", userInfo: nil, repeats: true)
        speed = 1
        bird.physicsBody?.dynamic = true
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
        bird.physicsBody?.dynamic = false
        bird.physicsBody?.allowsRotation = false
        addChild(bird)
        
    }
    
    func setupTornato(){
        distance += 5
        distanceLabel.text = "当前:"+"\(distance)"+"M"
        maxDistance = max(maxDistance,distance)
        maxDistanceLabel.text = "最高:"+"\(maxDistance)"+"M"
        
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
        for _ in 0...1{
            setupFish1()
            setupFish2()
        }
    }
    
    func setupFish1(){
        let offsetY = CGFloat(arc4random_uniform(100))
        let randomDuration = NSTimeInterval(arc4random_uniform(12))
        let offsetX = CGFloat(arc4random_uniform(UInt32(frame.width)))
        let Fish1Texture = SKTexture(imageNamed: "fish1")
        let moveTornato = SKAction.moveByX(-frame.width * 3, y: 0, duration:max(10,randomDuration))
        let removeTornato = SKAction.removeFromParent()
        let moveAndRemovePies = SKAction.sequence([moveTornato,removeTornato])
        fish1 = SKSpriteNode(texture: Fish1Texture)
        fish1.position = CGPointMake(CGRectGetMidX(frame) + frame.width + offsetX , 10 + offsetY)
        fish1.physicsBody = SKPhysicsBody(rectangleOfSize: Fish1Texture.size())
        fish1.physicsBody?.dynamic = false
        fish1.runAction(moveAndRemovePies)
        addChild(fish1)
    }
    
    func setupFish2(){
        let offsetY = CGFloat(arc4random_uniform(110))
        let randomDuration = NSTimeInterval(arc4random_uniform(18))
        let offsetX = CGFloat(arc4random_uniform(UInt32(frame.width)))
        let Fish2Texture = SKTexture(imageNamed: "fish2")
        let moveTornato = SKAction.moveByX(-frame.width * 4, y: 0, duration:max(15,randomDuration))
        let removeTornato = SKAction.removeFromParent()
        let moveAndRemovePies = SKAction.sequence([moveTornato,removeTornato])
        fish2 = SKSpriteNode(texture: Fish2Texture)
        fish2.position = CGPointMake(CGRectGetMidX(frame) + frame.width + offsetX*2 , 10 + offsetY)
        fish2.physicsBody = SKPhysicsBody(rectangleOfSize: Fish2Texture.size())
        fish2.physicsBody?.dynamic = false
        fish2.runAction(moveAndRemovePies)
        addChild(fish2)
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
