//
//  UIbrandImageView.swift
//  LIC
//
//  Created by 温红权 on 15/5/28.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation


class UIbrandImageView:UIImageView {
    
    var clickevent:ClickEvent?
    
    //    private var effectView:UIView?
    
    init(image: UIImage!,event:ClickEvent?) {
        super.init(image: image)
        clickevent = event
        
        
        //
        //
        //        effectView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        //        effectView?.hidden = true
        //        effectView?.backgroundColor = CommonUtil.UIColorFromRGBA(0x000000, alpha: 0.4)
        //        self.addSubview(effectView!)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //    override func layoutSubviews() {
    //        self.effectView?.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    //    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        
        
        //
        //        effectView?.hidden = false
        
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        
        //        UIView.animateWithDuration(0.4, animations: {
        //            effectView?.hidden = true
        //        })
        //        self.layoutIfNeeded()
        
        clickevent?()
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        super.touchesCancelled(touches, withEvent: event)
        
        //        UIView.animateWithDuration(0.4, animations: {
        //             effectView?.hidden = true
        //        })
        //        self.layoutIfNeeded()
        
    }
    
    
    
}