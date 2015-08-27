//
//  BaseTableController.swift
//  LIC
//
//  Created by 温红权 on 15/4/2.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class BaseTableController:UITableViewController,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate{

    
    var locationManager:BMKLocationService!
    var searchService:BMKGeoCodeSearch!
  
    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
        
        if(Cache.USER==nil){
            
            Cache.USER = User()
        }
        
        Cache.USER.latitude = userLocation.location.coordinate.latitude
        Cache.USER.longitude = userLocation.location.coordinate.longitude
        
        var geoCodeOption = BMKReverseGeoCodeOption()
        geoCodeOption.reverseGeoPoint = userLocation.location.coordinate
        
        searchService.reverseGeoCode(geoCodeOption)
        
        
    }
    
    func ValidatePhone(field:UITextField) -> Void  {
        
        field.text =  CommonUtil.validateNumber(field.text,limit:20)
        
        var textCount = field.text.stringByReplacingOccurrencesOfString(" ", withString: "", options: nil, range: nil).lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        
        var text=field.text.stringByReplacingOccurrencesOfString(" ", withString: "", options: nil, range: nil)
        
        if(textCount<=11){
            if(textCount>=4){
                field.text = text.insert(" ", ind: 3)
                text =  field.text
            }
            if(textCount>=8){
                field.text = text.insert(" ", ind: 8)
            }
            
        }else{
            field.text=text
        }
        
        
    }
    
      
    func getevents(){
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
                    
                    CommonUtil.removeTabBarRed(self.tabBarController, index: 2)
                    UIApplication.sharedApplication().applicationIconBadgeNumber = 0
                    
                }else{
               
                    UIApplication.sharedApplication().applicationIconBadgeNumber = allCount
                    CommonUtil.setTabBarRed(self.tabBarController, index: 2, num: 4)
                }
                
            }else{
                CommonUtil.removeTabBarRed(self.tabBarController, index: 2)
                UIApplication.sharedApplication().applicationIconBadgeNumber = 0
            }
            
        }else{
            CommonUtil.removeTabBarRed(self.tabBarController, index: 2)
            UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        }

        
    }


    func onGetReverseGeoCodeResult(searcher: BMKGeoCodeSearch!, result: BMKReverseGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
        Cache.USER.userAddr =  result?.addressDetail
        
        UserService.sharedUserService.UploadUserLocation()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        WebSocketUtil.sharedWebSocket.checkConnect()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "messageHandle:", name: "websocketmessage", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loginHandle:", name: "loginevent", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "getevents", name: "getevents", object: nil)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: kReachabilityChangedNotification, object: nil)
        
        NetworkEnable.sharedNetworkEnable.checkNet()
        
        WebSocketUtil.sharedWebSocket.checkConnect()
        
//        if(BaseString.NetWorkEnable){
//            networkEnable()
//        }else{
//            networkDisable()
//        }
        
        if (self.tableView.indexPathForSelectedRow() != nil){
            tableView.deselectRowAtIndexPath(self.tableView.indexPathForSelectedRow()!, animated: false)
        }
        
        locationManager = BMKLocationService()
        locationManager.delegate = self
        
        
        searchService = BMKGeoCodeSearch()
        searchService.delegate = self
        
        CommonUtil.getevents()
        
    }
    
    func loginHandle(notification:NSNotification){
        var data = notification.object as! String
        
        if(data == "error"){
            BaseString.USERPHONE = Cache.USER.phone
            //跳到登录页
            CommonUtil.backToView(self, name: "navlogin", type:kCATransitionMoveIn, subtype: kCATransitionFromTop)
        }
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        locationManager?.stopUserLocationService()
        locationManager?.delegate = nil
        locationManager = nil
        
        searchService?.delegate = nil
        searchService = nil
        
    }

    
    func  messageHandle(notification:NSNotification){
        var data = notification.object as! String
        if(data.contains("msg")){
            var data:JSON = JSON(data:(data as NSString).dataUsingEncoding(NSUTF8StringEncoding)! )
            
            CommonUtil.GCDThread({()in
                //这里写需要放到子线程做的耗时的代码
                CommonUtil.getevents()
                
                }, afterdo:  nil)
            
            
        }
        webSocketMessageHandler(data)
    }
    
    
    func webSocketMessageHandler(message:String){
        
    }
    
    
    
    func reachabilityChanged(note:NSNotification)
    {
        
        var reach:Reachability? = note.object as? Reachability;
        
        if (reach != nil && reach == NetworkEnable.sharedNetworkEnable.internetConnectionReach)
        {
            if(reach!.isReachable())
            {
                BaseString.NetWorkEnable = true
                if(disableNetWork){
                   networkEnable()
                }
            }
            else
            {
                BaseString.NetWorkEnable = false
                if(disableNetWork){
                   networkDisable()
                }
                
            }
        }
        
        
    }


    var disableNetWork = false
  
    
    func networkEnable(){
        networkWaringView?.removeFromSuperview()
        if(lastHeadView != nil){

            lastHeadView?.frame = CGRect(x: 0, y: 0, width: lastHeadView!.frame.width, height: lastHeadView!.frame.height)
            
            errorViewDisplay = false
            
            
            
        }else{
            //页面初始化时
            if(networkWaringView == nil){
            
               lastHeadView = self.tableView.tableHeaderView
            }
            
        
        }
        
        
        self.tableView.tableHeaderView = self.lastHeadView

        self.tableView.reloadData()
    }
    
    
    func networkDisable(){
        
        addNetWorkWarning()
        
        
    }

    var lastHeadView:UIView?
    
    var errorViewDisplay = false
    
    var networkWaringView:UIView?
    
    func addNetWorkWarning(){

        if(networkWaringView != nil){
            
            if(errorViewDisplay) {
                   return
            }
            
            if(self.tableView.tableHeaderView?.subviews.count>0){
                
                errorViewDisplay = true
                lastHeadView = self.tableView.tableHeaderView
                
                self.tableView.tableHeaderView!.addSubview(networkWaringView!)
                self.tableView.tableHeaderView =  self.tableView.tableHeaderView
            }else{
                
                errorViewDisplay = true
                
                lastHeadView = self.tableView.tableHeaderView
                
                self.tableView.tableHeaderView = networkWaringView
            }
          
            
           
        }else{
        
            networkWaringView = UIView.loadFromNibNamedView("NetworkWarning", bundle: nil)
            networkWaringView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
            networkWaringView?.backgroundColor = CommonUtil.UIColorFromRGB(0xFFDEDE)
            
            if(errorViewDisplay) {
                return
            }
            
            
            if(self.tableView.tableHeaderView?.subviews.count>0){
            
                errorViewDisplay = true
                lastHeadView = self.tableView.tableHeaderView
                
                self.tableView.tableHeaderView!.addSubview(networkWaringView!)
                self.tableView.tableHeaderView =  self.tableView.tableHeaderView
            }else{
            
                errorViewDisplay = true
                
                lastHeadView = self.tableView.tableHeaderView
                
                self.tableView.tableHeaderView = networkWaringView
            }
            
            
            
        }
        
    }
    
    


}