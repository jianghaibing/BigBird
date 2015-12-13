//
//  GameStartScene.swift
//  BigBird
//
//  Created by baby on 15/12/12.
//  Copyright © 2015年 baby. All rights reserved.
//

import UIKit
import SpriteKit

class GameStartScene: SKScene {
    
    var startGameButton:ButtonNode!
    var gameOver = false
    
    override func didMoveToView(view: SKView) {
        let gameViewController = ((UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController as! BigBirdNavigationController).topViewController as! GameViewController
        gameViewController.adBannerView?.hidden = false
        
        let background = SKSpriteNode(imageNamed: "bg_wide")
        background.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame))
        background.zPosition = -5
        background.size.height = frame.size.height
        addChild(background)
        
        if !gameOver {
            setupBird()
            startGameButton = ButtonNode(normalName: "startGame", selectName: "") { () -> () in
                self.startGame()
            }
            startGameButton.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame))
            addChild(startGameButton)
        }else {
            let restartGameButton = ButtonNode(normalName: "restartGame", selectName: "") { () -> () in
                self.startGame()
            }
            restartGameButton.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame))
            addChild(restartGameButton)
        }
        
        let leaderBoard = ButtonNode(normalName: "leaderBoard", selectName: "") { () -> () in
            
        }
        leaderBoard.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame) - 80)
        addChild(leaderBoard)
        
        let share = ButtonNode(normalName: "share", selectName: "") { () -> () in
            
        }
        share.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame) - 160)
        addChild(share)
    }
    
    func setupBird(){
        let birdTexture1 = SKTexture(imageNamed: "bird1")
        let birdTexture2 = SKTexture(imageNamed: "bird2")
        let birdTexture3 = SKTexture(imageNamed: "bird3")
        let birdTexture4 = SKTexture(imageNamed: "bird2")
        let fly = SKAction.animateWithTextures([birdTexture1,birdTexture2,birdTexture3,birdTexture4], timePerFrame: 0.2)
        let flyForever = SKAction.repeatActionForever(fly)
        let bird = SKSpriteNode(texture: birdTexture1)
        bird.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame) + 200)
        bird.runAction(flyForever)
        addChild(bird)
        
    }
    
    func startGame(){
        if let gameScene = GameScene(fileNamed: "GameScene"){
            let gameViewController = ((UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController as! BigBirdNavigationController).topViewController as! GameViewController
            gameViewController.adBannerView?.hidden = true
            gameScene.scaleMode = .AspectFill
            let transtion = SKTransition.doorsOpenHorizontalWithDuration(1)
            view?.presentScene(gameScene, transition: transtion)
        }
    }
    
}
