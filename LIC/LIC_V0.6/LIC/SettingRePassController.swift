//
//  SettingRePassController.swift
//  LIC
//
//  Created by 温红权 on 15/3/13.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import UIKit
//import ObjectMapper

class SettingRePassController: BaseController {
    
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var oldpass: UITextField!
    @IBOutlet weak var newpass: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initUI()
    }
    
    @IBAction func repasswordAction(sender: AnyObject) {
        
        if(oldpass.text != Cache.USER.password){

            CommonUtil.alertView(self, title: "旧密码错误", message: "", buttons: [AlertHandler(title: "确定", handle: {})])
            return
        }
        
        
        if oldpass.text == newpass.text {
            
            CommonUtil.alertView(self, title: "新密码与旧密码一样", message: "", buttons: [AlertHandler(title: "确定", handle: {})])
         
        }else if (newpass.text as NSString).length < 8 || (oldpass.text as NSString).length < 8 {
        
            CommonUtil.alertView(self, title: "密码不得少于8个字符", message: "", buttons: [AlertHandler(title: "确定", handle: {})])
        }else {
            
            var user:UserBase = UserBase()
            user.id = Cache.USER.id
            user.oldPassword = oldpass.text
            user.password = newpass.text
            user.clientType = nil
            user.agentId = nil
        
           
            UserService.sharedUserService.RePassword({ (data) -> Void in
                
                
                if data["status"].int == StatusCode.SystemSC.SYSTEM_OK {
                    
                    BaseString.USERPHONE = Cache.USER.phone
                
                    self.loginout()
                    
                    CommonUtil.saveWithNSUserDefaults("", key: "USER")
                   
                    
                    //提示
                    CommonUtil.alertView(self, title: "您的密码已经更改，请重新登录", message: "",buttons:[AlertHandler(title: "确定", handle: { () -> Void in
                        
                          self.navigationController?.popViewControllerAnimated(true)
                    })])

                  
                    
                    
                    
                    
                    
                    
                }else if data["status"].int == StatusCode.SystemSC.SYSTEM_ERROR {
                    
                    CommonUtil.alertView(self, title: "系统错误", message: "我挂了", buttons: [AlertHandler(title: "确定", handle: {})])
                    
                }else if data["status"].int == StatusCode.UserSC.NEW_OLD_PASSWORD_SAME{
                    
                    CommonUtil.alertView(self, title: "新密码与旧密码一样", message: "", buttons: [AlertHandler(title: "确定", handle: {})])
                    
                }
                
                
                
                
                }, errorHandler: { (data) -> Void in
                    
                    println(data)
                    
                }, body: (Mapper().toJSON(user)))
            
        }
        
        
    }
    
    func loginout(){
        
        Cache.USER.isloginout = true
        
        //缓存用户
        CommonUtil.saveWithNSUserDefaults(Mapper().toJSON(Cache.USER), key: "USER")
        
        CommonUtil.getevents()
        
     
        BaseString.USERPHONE = Cache.USER.phone
        
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        
        CommonUtil.GCDThread({()in
            UserService.sharedUserService.LoginOut({(data)in}, errorHandler: {(data)in})
            
            }, afterdo: nil)
        
        
    }

    
    
    @IBAction func oldpassput(sender: AnyObject) {
        
        if((oldpass.text as NSString).length > 0 && (newpass.text as NSString).length > 0){
        
          confirmButton.enabled = true
        }else{
        
          confirmButton.enabled = false
        }
        
        CommonUtil.validateString(oldpass.text, limit: 20)
        
    }
    
    @IBAction func newpassput(sender: AnyObject) {
        
        if((oldpass.text as NSString).length > 0 && (newpass.text as NSString).length > 0){
            
            confirmButton.enabled = true
        }else{
            
            confirmButton.enabled = false
        }
        
        CommonUtil.validateString(oldpass.text, limit: 20)
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
    
    
    
    
    
    func initUI(){
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        
        self.navigationItem.title = "修改密码"
        
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        
    
         confirmButton=CommonUtil.buttonSetImage(confirmButton,name:"greenbigbtn",states:[UIControlState.Selected,UIControlState.Normal,UIControlState.Highlighted,UIControlState.Disabled])
        confirmButton.enabled = false
    }

    
    
    
    
}