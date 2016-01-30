//
//  AchievementsHelper.swift
//  BigBird
//
//  Created by baby on 15/12/25.
//  Copyright © 2015年 baby. All rights reserved.
//

import Foundation
import GameKit

class AchievementsHelper{
    
    struct Constants {

        static let juniorAirmanID = "JuniorAirman_achievement"
        static let airmanId = "Airman_achievement"
        static let seniorAirmanID = "SeniorAirman_achievement"
        static let proAirmanID = "WindAirman_achievement"
        static let fullyEatID = "FullyEat_achievement"
        static let liveSoOKID = "AliveSoOK_achievement"
        static let freeFallID = "FreeFall_achivement"
        static let onlyBigFishID = "OnlyBigFish_achievement"
        static let onlySmallFishID = "OnlySmallFish_achievement"
    }
    
    class func completeJuniorAirmanAchievement(distance:Int)->GKAchievement{
        let percent = distance/100 * 100
        let flyingDistanceAchieve = GKAchievement(identifier: Constants.juniorAirmanID)
        flyingDistanceAchieve.percentComplete = Double(percent)
        flyingDistanceAchieve.showsCompletionBanner = true
        return flyingDistanceAchieve
    }
    
    class func completeAirmanAchievement(distance:Int)->GKAchievement{
        let percent = distance/500 * 100
        let flyingDistanceAchieve = GKAchievement(identifier: Constants.airmanId)
        flyingDistanceAchieve.percentComplete = Double(percent)
        flyingDistanceAchieve.showsCompletionBanner = true
        return flyingDistanceAchieve
    }

    class func completeSeniorAirmanAchievement(distance:Int)->GKAchievement{
        let percent = distance/2000 * 100
        let flyingDistanceAchieve = GKAchievement(identifier: Constants.seniorAirmanID)
        flyingDistanceAchieve.percentComplete = Double(percent)
        flyingDistanceAchieve.showsCompletionBanner = true
        return flyingDistanceAchieve
    }
    
    class func completeProAirmanAchievement(distance:Int)->GKAchievement{
        let percent = distance/5000 * 100
        let flyingDistanceAchieve = GKAchievement(identifier: Constants.proAirmanID)
        flyingDistanceAchieve.percentComplete = Double(percent)
        flyingDistanceAchieve.showsCompletionBanner = true
        return flyingDistanceAchieve
    }

    class func completefullyEatAchievement()->GKAchievement{
        let fullyEatAchieve = GKAchievement(identifier: Constants.fullyEatID)
        fullyEatAchieve.percentComplete = 100
        fullyEatAchieve.showsCompletionBanner = true
        return fullyEatAchieve
    }

    class func completeLiveSoOkAchievement()->GKAchievement{
        let liveSoOKAchieve = GKAchievement(identifier: Constants.liveSoOKID)
        liveSoOKAchieve.percentComplete = 100
        liveSoOKAchieve.showsCompletionBanner = true
        return liveSoOKAchieve
    }
    
    class func completeFreeFallAchievement()->GKAchievement{
        let freeFallAchieve = GKAchievement(identifier: Constants.freeFallID)
        freeFallAchieve.percentComplete = 100
        freeFallAchieve.showsCompletionBanner = true
        return freeFallAchieve
    }
    
    class func completeonlyBigFishAchievement()->GKAchievement{
        let onlyBigFishAchieve = GKAchievement(identifier: Constants.onlyBigFishID)
        onlyBigFishAchieve.percentComplete = 100
        onlyBigFishAchieve.showsCompletionBanner = true
        return onlyBigFishAchieve
    }
    
    class func completeonlySmallFishAchievement()->GKAchievement{
        let onlySmallFishAchieve = GKAchievement(identifier: Constants.onlySmallFishID)
        onlySmallFishAchieve.percentComplete = 100
        onlySmallFishAchieve.showsCompletionBanner = true
        return onlySmallFishAchieve
    }


}