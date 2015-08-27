//
//  AlarmTableController.swift
//  LIC
//
//  Created by 温红权 on 15/3/13.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import UIKit
//import ObjectMapper

class AlarmTableController: BaseTableController{
    
    var allevents:[MsgCount] = []
    var loding:JGProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        CommonUtil.setNavigationControllerBackground(self)
        
        var rightbar = UIBarButtonItem(image: UIImage(named: "customer_service"), style: UIBarButtonItemStyle.Plain, target: self, action: "customerService")
        
        rightbar.imageInsets = UIEdgeInsets(top: 0, left: -7, bottom: 0, right: 7)
        
        
        
        self.navigationItem.setRightBarButtonItem(rightbar, animated: false)
        
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
        
        self.tableView.editing = false //禁止编辑
        
        CommonUtil.getevents()
        
        CommonUtil.GCDThread({()in
        CommonUtil.getEbickInfo()
        
        }, afterdo: nil)
       
        
         CommonUtil.login()
        
    }
    
    
    
  
    
    
    func refreshTable(){
        
        if(Cache.MSGCOUNT != nil ){
            //取一个电动车
            if( Cache.MSGCOUNT.count>0){
                self.allevents = Cache.MSGCOUNT
                
                var temp:[MsgCount] = []
                
                //未登录下只显示天气
                if(Cache.USER?.isloginout == true){
                    for msg in self.allevents {
                        if msg.type == StatusCode.MSG_WEATER {
                           temp.append(msg)
                           continue
                        }
                    }
                }else{
                   temp = self.allevents
                }
                
                self.allevents = temp
                
                
                
                
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
                self.allevents = []
                CommonUtil.removeTabBarRed(self.tabBarController, index: 2)
                UIApplication.sharedApplication().applicationIconBadgeNumber = 0
            }
            
        }
        
        if( self.loding != nil ){
           self.loding.dismiss()
        }
        
        if allevents.count == 0 {
            
            self.tableView.scrollEnabled = false
            
            
        }else{
            
            self.tableView.allowsSelection = true
            self.tableView.scrollEnabled = true
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            
        }
        
        
       self.tableView.reloadData()
    }

    
    
    func customerService(){
        
        CommonUtil.alertCustomService(self)
    }
    
  
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
 
    
    func  enterForegroundNotification(){
        
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), {
            
            //这里写需要放到子线程做的耗时的代码
            CommonUtil.getevents()
            //self.loding=CommonUtil.alertLoding(self, title: "请稍等...")
            //self.loding.dismissAfterDelay(12000)
            
           
        })

        
       
        
    }
    override func viewWillAppear(animated: Bool) {
        
       super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "enterForegroundNotification", name: UIApplicationWillEnterForegroundNotification, object: nil)
        
          disableNetWork = true
        if(BaseString.NetWorkEnable){
            networkEnable()
        }else{
            networkDisable()
        }
   
        CommonUtil.getevents()
        
        loding=CommonUtil.alertLoding(self, title: "请稍等...")
        loding.dismissAfterDelay(12000)
        
        self.refreshTable()
        
    }
    
    
    override func getevents() {
        super.getevents()
        
        self.loding?.dismiss()
        
        
        
        refreshTable()
    }
    
    
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return allevents.count > 0 ?  allevents.count : 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if(allevents.count == 0){
             var cell = tableView.dequeueReusableCellWithIdentifier("numberCell") as! UITableViewCell
             cell.selectionStyle = UITableViewCellSelectionStyle.None
             return cell
        }else{
       
            var cell = tableView.dequeueReusableCellWithIdentifier("movecells") as! TableCellController
           
            var text:String = allevents[indexPath.row].unreadCount.description
            
            if(allevents[indexPath.row].unreadCount > 99){
                text = "99+"
            }
            
            
            cell.titleLable.text = allevents[indexPath.row].typeValue
            cell.discribtionLable.text = CommonUtil.StringLimt(14,string:allevents[indexPath.row].lastMsg.categoryDes)
            cell.timeLable.text = CommonUtil.formatDate(allevents[indexPath.row].lastMsg.insertTime)
            if(allevents[indexPath.row].type == StatusCode.MSG_MOVE ){
             
               cell.images.image = UIImage(named: "movealarm")
              
            }
            
            if(allevents[indexPath.row].type == StatusCode.MSG_OUTAGE ){
                
                cell.images.image = UIImage(named: "power_out")
               
            }
            
            if(allevents[indexPath.row].type == StatusCode.MSG_WEATER ){
                
                cell.images.image = UIImage(named: "weather")
                
            }
          
           
            
  
            
            switch (text as NSString).length {
            
                 case 1:
                    cell.buttonWidth.constant = 19

                    break;
                 case 2:
                    cell.buttonWidth.constant = 25

                    break;
                 case 3:
                    cell.buttonWidth.constant = 33

                    break;
                 default:
                    break
            
            }
            
            
            
            
            cell.numberButton = CommonUtil.NumButtonSetText(cell.numberButton, text: text)
//            var view_bg = UIView(frame: cell.frame)
//            view_bg.backgroundColor = CommonUtil.UIColorFromRGB(0xecf2ff);
//            cell.selectedBackgroundView = view_bg
            
            if(allevents[indexPath.row].unreadCount == 0){
                
                cell.numberButton.hidden = true
            }else{
                cell.numberButton.hidden = false

            }

            
            
            cell.selectionStyle = UITableViewCellSelectionStyle.Default;
            return cell
        }
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        if(allevents.count < 1){
        
          return
        }
        
        var sb = UIStoryboard(name: "Main", bundle:nil)
        
        var vc = sb.instantiateViewControllerWithIdentifier("alarmDetail") as!  AlarmDetailController
        
        vc.type = allevents[indexPath.row].type
        
        vc.hidesBottomBarWhenPushed = true
        
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
    

    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if allevents.count == 0 {
        
          return self.tableView.frame.height
        }else{
        
           return 65
        }
    }
    
    
    override func networkDisable() {
        if(loding != nil){
           loding.dismiss()
        }
    }
    


  
    

}