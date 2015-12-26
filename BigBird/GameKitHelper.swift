//
//  GameKitHelper.swift
//  BigBird
//
//  Created by baby on 15/12/12.
//  Copyright © 2015年 baby. All rights reserved.
//

import Foundation
import GameKit

let singleton = GameKitHelper()
let PresentAuthenticationViewController = "PresentAuthenticationViewController"

class GameKitHelper: NSObject,GKGameCenterControllerDelegate {
    
    
    var authenticationViewController:UIViewController?
    var lastError:NSError?
    var gameCenterEnabled:Bool
    
    override init(){
        gameCenterEnabled = true
        super.init()
    }
    
    class var shareInstance:GameKitHelper{
       
        return singleton
    }
    
    func authenticateLocalPlayer(){
        let localPlayer = GKLocalPlayer.localPlayer()
        localPlayer.authenticateHandler = { (viewController,error) in
            self.lastError = error
            if viewController != nil {
                self.authenticationViewController = viewController
                NSNotificationCenter.defaultCenter().postNotificationName(PresentAuthenticationViewController, object: self)
            }else if localPlayer.authenticated {
                self.gameCenterEnabled = true
            }else{
                self.gameCenterEnabled = false
            }
            
        }
    }
    
    func reportScore(score:Int64,forLeaderBoardId leaderBoardId:String){
        if !gameCenterEnabled{
            print("用户没认证")
            return
        }
        
        let scoreReporter = GKScore(leaderboardIdentifier: leaderBoardId)
        scoreReporter.value = score
        scoreReporter.context = 0
        let scores = [scoreReporter]
        GKScore.reportScores(scores) { (error) -> Void in
            self.lastError = error
        }
    }
    
    func reportAchievements(achievements:[GKAchievement]){
        if !gameCenterEnabled{
            print("用户没认证")
            return
        }
        GKAchievement.reportAchievements(achievements) { (error) -> Void in
            self.lastError = error
        }
    }
    
    func showGKGameCenterViewController(viewController:UIViewController!,leaderboard:Bool){
        if !gameCenterEnabled{
            print("用户没认证")
            return
        }
        
        let gameCenterViewController = GKGameCenterViewController()
        gameCenterViewController.gameCenterDelegate = self
        if leaderboard {
            gameCenterViewController.viewState = .Leaderboards
        }else{
            gameCenterViewController.viewState = .Achievements
        }
        viewController.presentViewController(gameCenterViewController, animated: true, completion: nil)
        
        
    }
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
    }

}
