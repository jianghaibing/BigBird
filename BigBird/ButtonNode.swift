//
//  ButtonNode.swift
//  BigBird
//
//  Created by baby on 15/12/11.
//  Copyright © 2015年 baby. All rights reserved.
//

import Foundation
import SpriteKit

class ButtonNode: SKNode {
    var sprite:SKSpriteNode!
    var normalTexture:SKTexture!
    var selectTexture:SKTexture!
    typealias callBack = () -> ()
    var callback:callBack!
    var single = false
    
    init(normalName:String!, selectName:String!, callback:callBack!) {
        super.init()
        if normalName == "" {
            print(" normal name  can't null ")
            return
        }
        normalTexture = SKTexture(imageNamed:normalName)
        if selectName == "" {
            single = true
        }else{
            selectTexture = SKTexture(imageNamed:selectName)
        }
        sprite = SKSpriteNode(texture: normalTexture)
        self.callback = callback
        self.userInteractionEnabled = true
        self.addChild(sprite)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if single {
            sprite.setScale(1.1)
        } else {
            sprite.texture = selectTexture
        }
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if single {
            sprite.setScale(1)
        } else {
            sprite.texture = normalTexture
        }
        performSelector("doCallBack", withObject: self, afterDelay: 0.1)
        
    }
    
    func doCallBack(){
        callback()
    }
}
