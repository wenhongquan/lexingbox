//
//  CityListController.swift
//  LIC
//
//  Created by 温红权 on 15/5/6.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class CityListController :BaseController {
    
    @IBOutlet weak var topspace: NSLayoutConstraint!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initItem();
    }
    
    func initItem(){
       
        
        self.title = "城市列表"
        self.tabBarItem.setTitleTextAttributes([NSFontAttributeName : UIFont.systemFontOfSize(17.0)], forState: UIControlState.Normal)
        self.tabBarItem.setTitlePositionAdjustment(UIOffsetMake(0.0, -15.0))

       
    }
    
    override func viewDidLoad() {
        topspace.constant =  self.tabBarController!.tabBar.frame.height
    }
    
    override func getevents(){
        if(Cache.MSGCOUNT == nil){
            return
        }
        
        if(Cache.MSGCOUNT != nil ){
            //取一个电动车
            if( Cache.MSGCOUNT.count>0){
                
                var hasNoRead = false
                
                var allCount = 0
                
                for msgCount in Cache.MSGCOUNT {
                    if msgCount.unreadCount > 0 {
                        hasNoRead = true;
                        allCount += msgCount.unreadCount
                    }
                    
                }
                if(!hasNoRead){
                    
                    // CommonUtil.removeTabBarRed(self.tabBarController, index: 2)
                    UIApplication.sharedApplication().applicationIconBadgeNumber = 0
                    
                }else{
                    
                    UIApplication.sharedApplication().applicationIconBadgeNumber = allCount
                    // CommonUtil.setTabBarRed(self.tabBarController, index: 2, num: 4)
                }
                
            }else{
                // CommonUtil.removeTabBarRed(self.tabBarController, index: 2)
                UIApplication.sharedApplication().applicationIconBadgeNumber = 0
            }
            
        }
        
    }

    
}