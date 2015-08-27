//
//  NotAccessErrorView.swift
//  LIC
//
//  Created by 温红权 on 15/7/7.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class NotAccessErrorView:UIView{

    @IBOutlet weak var warningLable: UILabel!

    @IBOutlet weak var detailButton: UIButton!
    
    var clickEvent:ClickEvent?
    
    
    @IBAction func detailButtonAction(sender: AnyObject) {
        
        clickEvent?()
    }
    
    
    

}