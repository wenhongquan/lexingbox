//
//  InputLexingCodeTableController.swift
//  LIC
//
//  Created by 温红权 on 15/4/15.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation
//import ObjectMapper

class InputLexingCodeTableController:BaseTableController{

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }


    override func viewWillAppear(animated: Bool) {
        
        if (self.tableView.indexPathForSelectedRow() != nil){
            tableView.deselectRowAtIndexPath(self.tableView.indexPathForSelectedRow()!, animated: false)
        }
    }

    
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
     
        return 15

    }
    
    
    func backtomain(){
        self.loading?.dismissAnimated(false)
        self.loading?.dismiss()
        
        CommonUtil.transitionWithType(kCATransitionReveal, withSubType: kCATransitionFromBottom, forView: self.view.window!)
        
        self.navigationController?.popToRootViewControllerAnimated(false)
    }
    
    var loading:JGProgressHUD?
    
    @IBAction func lexingCodeInput(sender: AnyObject) {
        lexingCodelable.text=CommonUtil.validateString(lexingCodelable.text, limit: 10)
        
        if  ((lexingCodelable.text as NSString).length == 10)  {
            
            self.navigationItem.rightBarButtonItem?.enabled = true
        }else{
            
            self.navigationItem.rightBarButtonItem?.enabled = false
        }
        

        
    }
    @IBOutlet weak var lexingCodelable: UITextField!
    func connect(sender: UIButton){
    
        if(Cache.EBICK == nil){
           return
        }
        var gps = GpsInfo()
        gps.ebikeId = Cache.EBICK.id
        gps.userId = Cache.USER.id
        gps.lexingCode = lexingCodelable.text
        
        GpsService.sharedGpsService.PutEbickLexingCodeCONN({(data) in
            if(data["status"].int == StatusCode.SystemSC.SYSTEM_OK){
                
                self.loading =  CommonUtil.alertSuccess(self.navigationController!.view!,title:"成功")
                
                self.loading?.dismissAfterDelay(1200)
                
                NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("backtomain"), userInfo: nil, repeats: false)
                
            }else
                if(data["status"].int == StatusCode.GpsSC.GPS_ALREADY_OTHERS_BIND){
                    CommonUtil.alertView(self, title: "连接失败", message: "该设备已被使用", buttons: [AlertHandler(title: "确定", handle: {
                        
                    })])
                }else
                    
                    if(data["status"].int == StatusCode.GpsSC.GPS_ALREADY_SELF_BIND){
                        CommonUtil.alertView(self, title: "连接失败", message: "您已经连接了乐行宝设备", buttons: [AlertHandler(title: "确定", handle: {})])
                    }else
                        if(data["status"].int == StatusCode.GpsSC.GPS_NOT_EXIST){
                            CommonUtil.alertView(self, title: "连接失败", message: "请输入乐行宝设备上的乐行码", buttons: [AlertHandler(title: "确定", handle: {})])
                        }else
                            if(data["status"].int == StatusCode.GpsSC.NOT_FOUND_GPS){
                                CommonUtil.alertView(self, title: "连接失败", message: "请输入乐行宝设备上的乐行码", buttons: [AlertHandler(title: "确定", handle: {})])
            }
            
            
            }, errorHandler: {(data) in
                
                
            }, body: (Mapper().toJSON(gps)))
    
    }
    
    func clear(sender: UIButton){
        
        // 跳转至输入扫码界面
        CommonUtil.transitionWithType(kCATransitionReveal, withSubType: kCATransitionFromBottom, forView: self.view.window!)
 
        self.navigationController?.popViewControllerAnimated(false)
        
    }
    
    
    
    
    func initUI(){
        
        CommonUtil.setNavigationControllerBackground(self)
        
        self.navigationItem.leftItemsSupplementBackButton = false

        self.tableView.scrollEnabled = true
    
        var button = UIButton()
        
        button.frame = CGRectMake(0.0, 2.0,40, 34);
        button.titleLabel?.textAlignment = NSTextAlignment.Right
        button.addTarget(self, action: "connect:", forControlEvents: UIControlEvents.TouchUpInside)
        button.setTitle("连接", forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(17)
        button.setTitleColor(CommonUtil.UIColorFromRGB(0x01624b), forState: UIControlState.Disabled)
        button.setTitleColor(CommonUtil.UIColorFromRGB(0x2bcd9c), forState: UIControlState.Normal)
        button.setTitleColor(CommonUtil.UIColorFromRGB(0x01624b), forState: UIControlState.Selected)
        button.setTitleColor(CommonUtil.UIColorFromRGB(0x01624b), forState: UIControlState.Highlighted)
        
        //        button.enabled = false
        
        var baritem = UIBarButtonItem(customView: button)
        
        self.navigationItem.rightBarButtonItem = baritem
        
        self.navigationItem.rightBarButtonItem?.enabled = false
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
     
        
        
        var item1 = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "clear:")
        item1.tintColor = UIColor.whiteColor()
        self.navigationItem.setLeftBarButtonItems([item1], animated: false)
        
        
        self.navigationItem.title = "设备信息"
        
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        
        
        self.tableView.allowsSelection = false
        self.tableView.scrollEnabled = true
    }

}