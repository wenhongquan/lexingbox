//
//  IndexBarContentShowView.swift
//  LIC
//
//  Created by 温红权 on 15/6/1.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class IndexBarContentShowView:UIView {
    
    @IBOutlet weak var contentLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = CommonUtil.UIColorFromRGBA(0x0000000, alpha: 0)
        
        
    }
    
    var isshow = 0
    var isclose = 0
    
    func showContent(content:String?,view:UIView?,size:CGRect){
        
      
            self.alpha = 1
            contentLable.text = content;
            self.frame = UIScreen.mainScreen().bounds
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                view?.addSubview(self)
                //            view?.layoutIfNeeded()
                
                }) { (finsh) -> Void in
                    
                 self.isshow++
                
            }
        
        
        
    }
    
    func hideview(){
        
        var temp = self.isshow
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.alpha = 0
                
                }) { (finsh) -> Void in
                    if(self.isshow == temp){
                        self.removeFromSuperview()
                    }
            
            }
            
            
        
    
    }
    
    func hideContent(){
        
         NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("hideview"), userInfo: nil, repeats: false)
      
    }
    
   
    
}