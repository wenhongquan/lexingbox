//
//  UIViewTouchView.swift
//  LIC
//
//  Created by 温红权 on 15/4/21.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

typealias ClickEvent = () -> Void

class UIViewTouchView: UIView {
    
    var clickevnt:ClickEvent?

    var effectView:UIView?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        effectView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        effectView?.hidden = true
        
        effectView?.backgroundColor = CommonUtil.UIColorFromRGBA(0x000000, alpha: 0.4)
        self.addSubview(effectView!)
        self.bringSubviewToFront(effectView!)
    }
    

    
    override func layoutSubviews() {
        super.layoutSubviews()
        effectView?.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    }
    
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        
         effectView?.hidden = false

    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
    
        UIView.animateWithDuration(0.4, animations: {
            effectView?.hidden = true
        })
        self.layoutIfNeeded()

        clickevnt?()
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        super.touchesCancelled(touches, withEvent: event)
        
        UIView.animateWithDuration(0.4, animations: {
             effectView?.hidden = true
        })
        self.layoutIfNeeded()
    
    }
    
    
    
}