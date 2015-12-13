//
//  GameStartScene.swift
//  BigBird
//
//  Created by baby on 15/12/12.
//  Copyright © 2015年 baby. All rights reserved.
//

import UIKit
import SpriteKit

class GameStartScene: SKScene,UMSocialUIDelegate {
    
    var currentScore:Int!
    var bestScore:Int!
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
            let scoreBoard = SKSpriteNode(imageNamed: "scoreBoard")
            scoreBoard.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame)+115)
            addChild(scoreBoard)
            
            let currentScoreLabel = SKLabelNode(fontNamed: "PingFang SC")
            currentScoreLabel.text = "当前飞行：\(currentScore)M"
            currentScoreLabel.fontSize = 24
            currentScoreLabel.fontColor = UIColor.whiteColor()
            currentScoreLabel.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame)+127)
            currentScoreLabel.zPosition = 1
            addChild(currentScoreLabel)
            
            let bestScoreLabel = SKLabelNode(fontNamed: "PingFang SC")
            bestScoreLabel.text = "最高飞行：\(bestScore)M"
            bestScoreLabel.fontSize = 24
            bestScoreLabel.fontColor = UIColor.whiteColor()
            bestScoreLabel.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame)+87)
            bestScoreLabel.zPosition = 1
            addChild(bestScoreLabel)
            
            let gameOver = SKSpriteNode(imageNamed: "gameOver")
            gameOver.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame)+215)
            addChild(gameOver)

            
            let restartGameButton = ButtonNode(normalName: "restartGame", selectName: "") { () -> () in
                self.startGame()
            }
            restartGameButton.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame))
            addChild(restartGameButton)
        }
        
        let leaderBoard = ButtonNode(normalName: "leaderBoard", selectName: "") { () -> () in
            GameKitHelper.shareInstance.showGKGameCenterViewController(gameViewController)
        }
        leaderBoard.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame) - 80)
        addChild(leaderBoard)
        
        let share = ButtonNode(normalName: "share", selectName: "") { () -> () in
            UMSocialSnsService.presentSnsIconSheetView(gameViewController, appKey: "566d442b67e58e15870068a8", shareText: "我在玩风狂大鸟，快来跟我一起玩", shareImage: UIImage(named: "sharedImage"), shareToSnsNames: [UMShareToQQ,UMShareToWechatTimeline,UMShareToWechatSession,UMShareToSina], delegate: self)
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
