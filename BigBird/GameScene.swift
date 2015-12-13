//
//  GameScene.swift
//  BigBird
//
//  Created by baby on 15/12/6.
//  Copyright (c) 2015年 baby. All rights reserved.
//

import SpriteKit

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    var energy:Int = 100
    var distance:Int = 0
    var maxDistance:Int = 0
    var timer:NSTimer!
    var firstTimePlay = true

    enum GameStatus:UInt{
        case Ready = 0
        case Playing = 1
        case Over = 2
    }
    var gameStatus:GameStatus = .Ready
    
    enum ColliderType:UInt32{
        case Bird = 1
        case Fish1 = 2
        case Fish2 = 4
        case Object = 8
    }
    
    var background = SKSpriteNode()
    var bird = SKSpriteNode()
    var water = SKSpriteNode()
    var tornato = SKSpriteNode()
    var fish1 = SKSpriteNode()
    var fish2 = SKSpriteNode()
    var shark = SKSpriteNode()
    var distanceLabel = SKLabelNode()
    var maxDistanceLabel = SKLabelNode()
    var startLabel = SKSpriteNode()
    var tapLabel = SKSpriteNode()
    var progressBackground = SKSpriteNode()
    var progress = SKSpriteNode()
    var energyLabel = SKLabelNode()
    var introduce = SKSpriteNode()
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        maxDistance = NSUserDefaults.standardUserDefaults().objectForKey("maxDistance") as? NSInteger ?? 0
        firstTimePlay = NSUserDefaults.standardUserDefaults().objectForKey("firstTimePlay") as? Bool ?? true
        
        setupBackground()
        
        progressBackground.color = UIColor(red: 245/255, green: 161/255, blue: 49/255, alpha: 1)
        progressBackground.size = CGSizeMake(180, 30)
        progressBackground.anchorPoint = CGPointMake(0, 1)
        progressBackground.position = CGPointMake(CGRectGetMidX(frame)-90, frame.height)
        addChild(progressBackground)
        
        progress.color = UIColor(red: 94/255, green: 202/255, blue: 138/255, alpha: 1)
        progress.size = CGSizeMake(180, 30)
        progress.anchorPoint = CGPointMake(0, 1)
        progress.position = CGPointMake(CGRectGetMidX(frame)-90, frame.height)
        addChild(progress)
        
        energyLabel.text = "100/100"
        energyLabel.fontSize = 20
        energyLabel.fontName = "PingFang SC"
        energyLabel.position = CGPointMake(CGRectGetMidX(frame), frame.height - 22)
        addChild(energyLabel)
        
        let sun = SKSpriteNode(imageNamed: "sun")
        sun.position = CGPointMake(frame.width/2 - UIScreen.mainScreen().bounds.width/2 + 30, frame.height - 50)
        sun.zPosition = -1
        addChild(sun)
        
        distanceLabel.text = "当前:0M"
        distanceLabel.fontSize = 20
        distanceLabel.fontColor = UIColor(red: 245/255, green: 161/255, blue: 49/255, alpha: 1)
        distanceLabel.fontName = "PingFang SC"
        distanceLabel.position = CGPointMake(CGRectGetMidX(frame)-150, frame.height - 22)
        addChild(distanceLabel)
        
        maxDistanceLabel.text = "最高:\(maxDistance)M"
        maxDistanceLabel.fontSize = 20
        maxDistanceLabel.fontColor = UIColor(red: 82/255, green: 108/255, blue: 147/255, alpha: 1)
        maxDistanceLabel.fontName = "PingFang SC"
        maxDistanceLabel.position = CGPointMake(CGRectGetMidX(frame)+150, frame.height - 22)
        addChild(maxDistanceLabel)
        
        startLabel = SKSpriteNode(imageNamed: "start")
        startLabel.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame) + 150)
        addChild(startLabel)
        
        tapLabel = SKSpriteNode(imageNamed: "tap")
        tapLabel.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame))
        addChild(tapLabel)
        
        setupBird()
        
        let bottomBound = SKNode()
        bottomBound.position = CGPointMake(0, 0)
        bottomBound.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(frame.width, 1))
        bottomBound.physicsBody?.dynamic = false
        bottomBound.physicsBody?.categoryBitMask = ColliderType.Object.rawValue
        bottomBound.physicsBody?.contactTestBitMask = ColliderType.Object.rawValue
        bottomBound.physicsBody?.collisionBitMask = ColliderType.Object.rawValue
        addChild(bottomBound)

        setupWater()
        if firstTimePlay{
            setupIntroduce()
        }
    }
    
    func setupIntroduce(){
        introduce = SKSpriteNode(imageNamed: "introduce")
        introduce.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame))
        introduce.zPosition = 10
        introduce.size.height = frame.size.height
        addChild(introduce)
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
        bird.physicsBody?.categoryBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.contactTestBitMask = ColliderType.Object.rawValue
        bird.physicsBody?.collisionBitMask = ColliderType.Object.rawValue

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
        tornato.physicsBody?.categoryBitMask = ColliderType.Object.rawValue
        tornato.physicsBody?.contactTestBitMask = ColliderType.Object.rawValue
        tornato.physicsBody?.collisionBitMask = ColliderType.Object.rawValue
        addChild(tornato)
        for _ in 0...1{
            setupFish1()
            setupFish2()
        }
        
        if distance % 20 == 0 {
            setupShark()
        }
    }
    
    func setupFish1(){
        let offsetY = CGFloat(arc4random_uniform(100))
        let randomDuration = NSTimeInterval(arc4random_uniform(12))
        let offsetX = CGFloat(arc4random_uniform(UInt32(frame.width)))
        let Fish1Texture = SKTexture(imageNamed: "fish1")
        let moveFish = SKAction.moveByX(-frame.width * 3, y: 0, duration:max(10,randomDuration))
        let removeFish = SKAction.removeFromParent()
        let moveAndRemoveFish = SKAction.sequence([moveFish,removeFish])
        fish1 = SKSpriteNode(texture: Fish1Texture)
        fish1.position = CGPointMake(CGRectGetMidX(frame) + frame.width + offsetX , 10 + offsetY)
        fish1.physicsBody = SKPhysicsBody(rectangleOfSize: Fish1Texture.size())
        fish1.physicsBody?.dynamic = false
        fish1.runAction(moveAndRemoveFish)
        fish1.physicsBody?.categoryBitMask = ColliderType.Fish1.rawValue
        fish1.physicsBody?.contactTestBitMask = ColliderType.Bird.rawValue
        fish1.physicsBody?.collisionBitMask = ColliderType.Fish1.rawValue
        addChild(fish1)
    }
    
    func setupFish2(){
        let offsetY = CGFloat(arc4random_uniform(110))
        let randomDuration = NSTimeInterval(arc4random_uniform(18))
        let offsetX = CGFloat(arc4random_uniform(UInt32(frame.width)))
        let Fish2Texture = SKTexture(imageNamed: "fish2")
        let moveFish = SKAction.moveByX(-frame.width * 4, y: 0, duration:max(15,randomDuration))
        let removeFish = SKAction.removeFromParent()
        let moveAndRemoveFish = SKAction.sequence([moveFish,removeFish])
        fish2 = SKSpriteNode(texture: Fish2Texture)
        fish2.position = CGPointMake(CGRectGetMidX(frame) + frame.width + offsetX*2 , 10 + offsetY)
        fish2.physicsBody = SKPhysicsBody(rectangleOfSize: Fish2Texture.size())
        fish2.physicsBody?.dynamic = false
        fish2.runAction(moveAndRemoveFish)
        fish2.physicsBody?.categoryBitMask = ColliderType.Fish2.rawValue
        fish2.physicsBody?.contactTestBitMask = ColliderType.Bird.rawValue
        fish2.physicsBody?.collisionBitMask = ColliderType.Fish2.rawValue
        addChild(fish2)
    }
    
    func setupShark(){
        let sharkTexture = SKTexture(imageNamed: "shark")
        let moveShark = SKAction.moveByX(0, y: 100, duration:0.5)
        let pauseShark = SKAction.moveByX(0, y: 0, duration: 2)
        let removeShark = SKAction.removeFromParent()
        let moveAndRemoveShark = SKAction.sequence([moveShark,pauseShark,removeShark])
        shark = SKSpriteNode(texture: sharkTexture)
        shark.position = CGPointMake(CGRectGetMidX(frame) - 120 , -50)
        shark.zPosition = 1
        shark.physicsBody = SKPhysicsBody(rectangleOfSize: sharkTexture.size())
        shark.physicsBody?.dynamic = false
        shark.runAction(moveAndRemoveShark)
        shark.physicsBody?.categoryBitMask = ColliderType.Object.rawValue
        shark.physicsBody?.contactTestBitMask = ColliderType.Object.rawValue
        shark.physicsBody?.collisionBitMask = ColliderType.Object.rawValue
        addChild(shark)
    }
    

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if gameStatus == .Ready && !firstTimePlay {
            gameStatus = .Playing
            bird.physicsBody?.dynamic = true
            startLabel.removeFromParent()
            tapLabel.removeFromParent()
            timer = NSTimer.scheduledTimerWithTimeInterval( 2, target: self, selector: "setupTornato", userInfo: nil, repeats: true)
        }

        if firstTimePlay{
            firstTimePlay = false
            introduce.removeFromParent()
            NSUserDefaults.standardUserDefaults().setBool(firstTimePlay, forKey: "firstTimePlay")
        }
        
        if gameStatus == .Playing {
            energy -= 2
            progress.size.width -= 3.6
            energyLabel.text = "\(energy)/100"
            bird.physicsBody?.velocity = CGVectorMake(0, 0)
            bird.physicsBody?.applyImpulse(CGVectorMake(0, CGFloat(energy)*0.8))
        }
  
    }
    
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    //MARK: - Contact Delegate
    func didBeginContact(contact: SKPhysicsContact) {
        
        if contact.bodyA.categoryBitMask == ColliderType.Fish1.rawValue || contact.bodyB.categoryBitMask == ColliderType.Fish1.rawValue{
            contact.bodyA.node?.removeFromParent()
            energy += 10
            energy = min(energy,100)
            progress.size.width = min(progress.size.width + 18 , 180)
            energyLabel.text = "\(energy)/100"
        }
        
        if contact.bodyA.categoryBitMask == ColliderType.Fish2.rawValue || contact.bodyB.categoryBitMask == ColliderType.Fish2.rawValue{
            contact.bodyA.node?.removeFromParent()
            energy += 15
            energy = min(energy,100)
            progress.size.width = min(progress.size.width + 27 , 180)
            energyLabel.text = "\(energy)/100"
        }
        
        if contact.bodyA.categoryBitMask == ColliderType.Object.rawValue || contact.bodyB.categoryBitMask == ColliderType.Object.rawValue{
            if gameStatus != .Over {
                gameStatus = .Over
                //当取得最高分时把分数发给排行榜
                if distance == maxDistance{
                    GameKitHelper.shareInstance.reportScore(Int64(maxDistance), forLeaderBoardId: "com.baby.big")
                }
                timer.invalidate()
                NSUserDefaults.standardUserDefaults().setInteger(maxDistance, forKey: "maxDistance")
                NSUserDefaults.standardUserDefaults().synchronize()
                if let scene = GameStartScene(fileNamed: "GameStartScene"){
                    scene.currentScore = distance
                    scene.bestScore = maxDistance
                    scene.gameOver = true
                    scene.scaleMode = .AspectFill
                    let transtion = SKTransition.pushWithDirection(.Down, duration: 0.5)
                    view?.presentScene(scene, transition: transtion)
                }
            }
        }
    }
}
