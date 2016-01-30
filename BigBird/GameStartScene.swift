//
//  GameStartScene.swift
//  BigBird
//
//  Created by baby on 15/12/12.
//  Copyright © 2015年 baby. All rights reserved.
//

import UIKit
import SpriteKit

class GameStartScene: SKScene{
    
    var currentScore:Int!
    var bestScore:Int!
    var startGameButton:ButtonNode!
    var gameOver = false
    
    override func didMoveToView(view: SKView) {
        
        let gameViewController = ((UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController as! BigBirdNavigationController).topViewController as! GameViewController
        gameViewController.adBannerView?.hidden = false
        
        let background = SKSpriteNode(imageNamed: "bg_wide-1")
        background.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame))
        background.zPosition = -5
        background.size.height = frame.size.height
        let move = SKAction.moveByX(100, y: 0, duration: 10)
        let scale = SKAction.scaleTo(1.2, duration: 10)
        let moveAndScale = SKAction.sequence([move,scale])
        let reversedMove = moveAndScale.reversedAction()
        let moveAndReverse = SKAction.sequence([moveAndScale,reversedMove])
        background.runAction(SKAction.repeatActionForever(moveAndReverse))
        addChild(background)
        
        if !gameOver {
            setupBird()
            startGameButton = ButtonNode(normalName: "startGame", selectName: "") { () -> () in
                self.runAction(SKAction.playSoundFileNamed("Floomp-Public_D-340_hifi.mp3", waitForCompletion: false))
                self.startGame()
            }
            startGameButton.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame))
            addChild(startGameButton)
        }else {
            let scoreBoard = SKSpriteNode(imageNamed: "scoreBoard")
            scoreBoard.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame)+115)
            addChild(scoreBoard)
            
            let currentScoreLabel = SKLabelNode(fontNamed: "PingFang SC")
            currentScoreLabel.text = "Current Score：\(currentScore)M"
            currentScoreLabel.fontSize = 24
            currentScoreLabel.fontColor = UIColor.whiteColor()
            currentScoreLabel.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame)+127)
            currentScoreLabel.zPosition = 1
            addChild(currentScoreLabel)
            
            let bestScoreLabel = SKLabelNode(fontNamed: "PingFang SC")
            bestScoreLabel.text = "Best Score：\(bestScore)M"
            bestScoreLabel.fontSize = 24
            bestScoreLabel.fontColor = UIColor.whiteColor()
            bestScoreLabel.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame)+87)
            bestScoreLabel.zPosition = 1
            addChild(bestScoreLabel)
            
            let gameOver = SKSpriteNode(imageNamed: "gameOver")
            gameOver.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame)+215)
            addChild(gameOver)

            
            let restartGameButton = ButtonNode(normalName: "restartGame", selectName: "") { () -> () in
                self.runAction(SKAction.playSoundFileNamed("Floomp-Public_D-340_hifi.mp3", waitForCompletion: false))
                self.startGame()
            }
            restartGameButton.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame))
            addChild(restartGameButton)
        }
        
        let leaderBoard = ButtonNode(normalName: "leaderBoard", selectName: "") { () -> () in
            self.runAction(SKAction.playSoundFileNamed("Floomp-Public_D-340_hifi.mp3", waitForCompletion: false))
            GameKitHelper.shareInstance.showGKGameCenterViewController(gameViewController, leaderboard: true)
        }
        leaderBoard.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame) - 80)
        addChild(leaderBoard)
        
        let achievement = ButtonNode(normalName: "achievement", selectName: "") { () -> () in
            self.runAction(SKAction.playSoundFileNamed("Floomp-Public_D-340_hifi.mp3", waitForCompletion: false))
            GameKitHelper.shareInstance.showGKGameCenterViewController(gameViewController, leaderboard: false)
        }
        achievement.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame) - 160)
        addChild(achievement)
        
        let share = ButtonNode(normalName: "share", selectName: "") { () -> () in
            self.runAction(SKAction.playSoundFileNamed("Floomp-Public_D-340_hifi.mp3", waitForCompletion: false))
            var shareText = ""
            
            if self.gameOver{
                shareText = "I am playing [Bird VS Wind],and got best score【\(self.bestScore)M】，come and play with me!👍👏🏻 download address:" + appStoreDownLoadURL
            }else{
                shareText = "I am playing [Bird VS Wind],come and play with me👍👏🏻 download address:" + appStoreDownLoadURL
            }
            
            UMSocialSnsService.presentSnsIconSheetView(gameViewController, appKey: UMAppKey, shareText: shareText, shareImage: UIImage(named: "sharedImage"), shareToSnsNames: [UMShareToFacebook,UMShareToTwitter,UMShareToInstagram,UMShareToWhatsapp], delegate: self)
            
        }
        share.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame) - 240)
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
        bird.size = CGSizeMake(111, 89)
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

extension GameStartScene:UMSocialUIDelegate{
    
//    func didSelectSocialPlatform(platformName: String!, withSocialData socialData: UMSocialData!) {
//        if platformName == UMShareToQQ {return}//解决掉QQ时在代理中设置分享内容奔溃的问题
//        var urlStr = ""
//        if platformName == UMShareToSina{
//            urlStr = "下载地址："+appStoreDownLoadURL
//        }
//        if self.gameOver{
//            socialData.shareText = "我在【风狂大鸟】中最高飞行了【\(self.bestScore)米】，快来和我比比看吧，我在排行榜等你哦！👍👏🏻\(urlStr)"
//        }else{
//            socialData.shareText = "我在玩【风狂大鸟】，快来跟我一起挑战排行榜吧！👍👏🏻\(urlStr)"
//        }
//        
//    }
    
}
