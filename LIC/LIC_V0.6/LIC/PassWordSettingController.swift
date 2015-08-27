//
//  PassWordSettingController.swift
//  LIC
//
//  Created by 温红权 on 15/3/17.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import UIKit
//import ObjectMapper

class PassWordSettingController: BaseController,PasswordSettingTableControllerHandlerProtocol {
    
    var userPhone="";
    var code="";
    
  
   
    
    weak var tableControl:PasswordSettingTableController!
    
    func passwordInputhandler() {
        
        if((tableControl.userPass.text as! NSString).length > 0 && (tableControl.userpassagain.text as! NSString).length > 0){
          self.navigationItem.rightBarButtonItem?.enabled = true
        }else{
          self.navigationItem.rightBarButtonItem?.enabled = false
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var backButton = UIBarButtonItem()
        
        backButton.action="backLaunch:"
        backButton.title = "取消"
        backButton.tintColor = UIColor.whiteColor()
        backButton.target=self;
        
        
        self.navigationItem.setLeftBarButtonItems([backButton], animated: true)

        
        
        var button = UIButton()
        
        button.frame = CGRectMake(0.0, 2.0,34, 34);
        button.titleLabel?.textAlignment = NSTextAlignment.Right
        button.addTarget(self, action: "complate:", forControlEvents: UIControlEvents.TouchUpInside)
        button.setTitle("完成", forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(17)
        button.setTitleColor(CommonUtil.UIColorFromRGB(0x01624b), forState: UIControlState.Disabled)
        button.setTitleColor(CommonUtil.UIColorFromRGB(0x2bcd9c), forState: UIControlState.Normal)
        button.setTitleColor(CommonUtil.UIColorFromRGB(0x01624b), forState: UIControlState.Selected)
        button.setTitleColor(CommonUtil.UIColorFromRGB(0x01624b), forState: UIControlState.Highlighted)
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem?.enabled = false
        
        
        initUI()

    }
    
    
    func initUI(){
        
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        
        self.navigationItem.title = "设置乐行宝密码"
        
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        
        
        CommonUtil.setNavigationControllerBackground(self)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
          disableNetWork = true
        if(BaseString.NetWorkEnable){
            networkEnable()
        }else{
            networkDisable()
        }
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "SetPasswordSegue") {
            tableControl = segue.destinationViewController as! PasswordSettingTableController
            tableControl.passwordtablehandle=self
            }
    }
    
    func backLaunch(sender: UIButton){
         CommonUtil.transitionWithType(kCATransitionReveal, withSubType: kCATransitionFromBottom, forView:self.view.window!)
        
        self.navigationController?.popToViewController(self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - 1 - 1 - 1] as! UIViewController, animated: false)
        
//        CommonUtil.backToView(self, name: "navlogin",type: kCATransitionReveal, subtype: kCATransitionFromBottom)
    }

    func complate(sender: UIButton){
        self.view.endEditing(true)
        var pass = tableControl.userPass.text
        var passs = tableControl.userpassagain.text
        var phone = tableControl.userName.text
        
        if(pass as! NSString).length < 8 {
            
            CommonUtil.alertView(self, title: "密码不得少于8个字符", message: "", buttons: [AlertHandler(title: "确定", handle: {})])
        
        }else if(pass != passs){

            CommonUtil.alertView(self, title: "密码不一致，请重新输入", message: "", buttons: [AlertHandler(title: "确定", handle: {})])
        
        }else{
             self.view.endEditing(true)
            
            var loding = CommonUtil.alertLoding(self, title: "请稍等...")
            var user:UserBase = UserBase()
            user.code=code
            user.phone=phone
            user.password=pass
            user.deviceToken=BaseString.DEVICETOKEN
           
            UserService.sharedUserService.Register({(data)in
                if data["status"].int == StatusCode.SystemSC.SYSTEM_OK {
                    
                    //缓存用户
                    Cache.USER = Mapper<User>().map(data["data"].dictionaryObject!)
                    
                    if(Cache.USER != nil){
                        loding.dismiss();
                        
                        
                        //缓存用户
                        Cache.USER = Mapper<User>().map(data["data"].dictionaryObject!)
                        
                        Cache.USER.isloginout = false
                        
                        CommonUtil.initEffect()
                        
                        //建立websocket
                        WebSocketUtil.sharedWebSocket.connect()
                        
                        //缓存用户
                        CommonUtil.saveWithNSUserDefaults(Mapper().toJSON(Cache.USER), key: "USER")
                        
//                        //页面跳转至首页
                        CommonUtil.backToView(self, name: "maintab")
                        
                        
                        //获取报警数据
                        CommonUtil.getEventData()
                        
                        
                        //返回原路径
//                        CommonUtil.transitionWithType(kCATransitionReveal, withSubType: kCATransitionFromBottom, forView:self.view.window!)
//                        
//                        self.navigationController?.popToViewController(self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - 1 - 1 - 1 -  1] as! UIViewController, animated: false)
                        
                        
                      
                    }
                    
                }else if data["status"].int == StatusCode.UserSC.PHONE_EXISTS {
                    
                    CommonUtil.alertView(self, title: "手机号已注册", message: "", buttons: [AlertHandler(title: "确定", handle: {})])

                }
                
                
                }, errorHandler: {(data)in
            }, body: (Mapper().toJSON(user)))
        
        }
        
        
    }

    
    
}

