//
//  BigBirdNavigationController.swift
//  BigBird
//
//  Created by baby on 15/12/12.
//  Copyright © 2015年 baby. All rights reserved.
//

import UIKit

class BigBirdNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        GameKitHelper.shareInstance.authenticateLocalPlayer()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showAuthenticationViewController", name: PresentAuthenticationViewController, object: nil)
    }
    
    func showAuthenticationViewController(){
        let gameKitHelper = GameKitHelper.shareInstance
        
        if let authenticationViewController = gameKitHelper.authenticationViewController{
            topViewController?.presentViewController(authenticationViewController, animated: true, completion: nil)
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

}
