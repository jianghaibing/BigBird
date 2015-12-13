//
//  GameViewController.swift
//  BigBird
//
//  Created by baby on 15/12/6.
//  Copyright (c) 2015年 baby. All rights reserved.
//

import UIKit
import SpriteKit
import iAd

class GameViewController: UIViewController,ADBannerViewDelegate {
    
    var adBannerView:ADBannerView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let scene = GameStartScene(fileNamed:"GameStartScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            adBannerView = ADBannerView(adType: .Banner)
            adBannerView?.frame.origin = CGPointMake(0, 0)
            adBannerView?.backgroundColor = UIColor.clearColor()
            adBannerView?.delegate = self
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            skView.addSubview(adBannerView!)
            skView.presentScene(scene)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        print("已经载入广告")
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        print(error)
    }
}
