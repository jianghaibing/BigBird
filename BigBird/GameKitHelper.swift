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

class GameKitHelper: NSObject {
    
    
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

}
