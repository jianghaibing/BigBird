//
//  AppDelegate.swift
//  BigBird
//
//  Created by baby on 15/12/6.
//  Copyright © 2015年 baby. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UMSocialData.setAppKey(UMAppKey)
        UMSocialWechatHandler.setWXAppId(weChatAppId, appSecret:weChatAppSecret , url: "http://www.umeng.com/social")
        UMSocialQQHandler.setQQWithAppId(qqAppId, appKey: qqAPPKey, url: "http://www.umeng.com/social")
        //UMSocialSinaSSOHandler.openNewSinaSSOWithAppKey(sinaAppKey, redirectURL: "http://sns.whalecloud.com/sina2/callback")
        UMSocialSinaHandler.openSSOWithRedirectURL("http://sns.whalecloud.com/sina2/callback")
        
        UMSocialData.defaultData().extConfig.qqData.url = appStoreDownLoadURL//设置app下载地址,点击分享内容打开的链接
        UMSocialData.defaultData().extConfig.wechatSessionData.url = appStoreDownLoadURL
        //苹果审核，当应用不存在时隐藏
        UMSocialConfig.hiddenNotInstallPlatforms([UMShareToQQ,UMShareToWechatSession,UMShareToWechatTimeline])
        
        //分享的标题
        UMSocialData.defaultData().extConfig.wechatSessionData.title = "强烈推荐【风狂大鸟】🐦"
        UMSocialData.defaultData().extConfig.qqData.title = "强烈推荐【风狂大鸟】🐦"
        
        return true
    }
    
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        return UMSocialSnsService.handleOpenURL(url)
    }
    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        return UMSocialSnsService.handleOpenURL(url)
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return UMSocialSnsService.handleOpenURL(url)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone {
            return .Portrait
        }else{
            return .All
        }
    }

}

