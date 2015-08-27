//
//  ForgetPasswordController.swift
//  LIC
//
//  Created by 温红权 on 15/3/30.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation


class ForgetPasswordController:BaseController{
    



    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var code: UITextField!
    
    @IBOutlet weak var getCodeButton: UIButton!
    
    @IBOutlet weak var confirmButton: UIButton!
    

    
    override func viewDidLoad() {
          super.viewDidLoad()
        initUI();
        
        
  
    }
    
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    var lastTime = 60
    
    
    func timeDown(){
        
        if(lastTime == 0){
           getCodeButton.setTitle("获取验证码", forState: UIControlState.Normal)
            getCodeButton.enabled = true
           lastTime = 60
           return
        }
        
        getCodeButton.setTitle("获取中(" + ((--lastTime > 10) ? lastTime.description : (lastTime.description + "0")) + ")", forState: UIControlState.Disabled)
        getCodeButton.enabled = false
        getCodeButton.setTitleColor(CommonUtil.UIColorFromRGB(0x888888), forState: UIControlState.Disabled)
        
         NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("timeDown"), userInfo: nil, repeats: false)
    }

    @IBAction func confirmButtonAction(sender: AnyObject) {
        
        if ((password.text as NSString).length < 8) {
        
          CommonUtil.alertView(self, title: "密码不得少于8个字符", message: "", buttons: [AlertHandler(title: "确定", handle: {})])
        }else if (code.text as NSString).length != 6  {
        
          CommonUtil.alertView(self, title: "验证码为6个数字", message: "", buttons: [AlertHandler(title: "确定", handle: {})])
        }else {
            var text=self.phone.text.stringByReplacingOccurrencesOfString(" ", withString: "", options: nil, range: nil)

            var user:UserBase = UserBase();
            user.code = code.text
            user.phone = text
            user.password = password.text
            
            if(BaseString.ISTEST){
                BaseString.USERPHONE = text
                self.navigationController?.popViewControllerAnimated(true)
            }else{
                UserService.sharedUserService.forgotPasswordRePassword({ (data) -> Void in
                    
                    
                    if data["status"].int == StatusCode.SystemSC.SYSTEM_OK {
                        
                        BaseString.USERPHONE = text
                        self.navigationController?.popViewControllerAnimated(true)
                        
                        
                    }else if data["status"].int == StatusCode.SystemSC.SYSTEM_ERROR {
                        
                        CommonUtil.alertView(self, title: "系统错误", message: "我挂了", buttons: [AlertHandler(title: "确定", handle: {})])
                        
                    }else if data["status"].int == StatusCode.UserSC.VALIDATE_CODE_SMS_UPPER_LIMIT{
                        
                        CommonUtil.alertView(self, title: "验证码已达上限", message: text+"\n 注册验证码已达到上限，请24小时后再注册", buttons: [AlertHandler(title: "确定", handle: {})])
                        
                    }else if data["status"].int == StatusCode.UserSC.NEW_OLD_PASSWORD_SAME{
                        
                        CommonUtil.alertView(self, title: "新密码与旧密码一样", message: "", buttons: [AlertHandler(title: "确定", handle: {})])
                        
                    }else if data["status"].int == StatusCode.UserSC.ACCOUNT_NOT_EXIST{
                        
                        CommonUtil.alertView(self, title: "用户不存在", message: "", buttons: [AlertHandler(title: "确定", handle: {})])
                        
                    }else if data["status"].int == StatusCode.UserSC.VALIDATE_FIAL{
                        
                        CommonUtil.alertView(self, title: "验证码已失效", message: "", buttons: [AlertHandler(title: "确定", handle: {})])
                        
                    }else if data["status"].int == StatusCode.UserSC.VALIDATE_ERROR{
                        
                        CommonUtil.alertView(self, title: "验证码错误", message: "", buttons: [AlertHandler(title: "确定", handle: {})])
                        
                    }
                    
                    
                    
                    
                    }, errorHandler: { (data) -> Void in
                        
                        println(data)
                        
                    }, body: (Mapper().toJSON(user)))
 
            }
        }
        
        
    }
    
    @IBAction func getcodeButtonAction(sender: AnyObject) {
        
        if(!getCodeButton.enabled){
        
          return
        }
        
        
        var text=self.phone.text.stringByReplacingOccurrencesOfString(" ", withString: "", options: nil, range: nil)
        
        
        if(BaseString.MOBILEREG.test(text)){
            
            if(BaseString.ISTEST){
                if ((password.text as NSString).length < 8) {
                    
                    CommonUtil.alertView(self, title: "密码不得少于8个字符", message: "", buttons: [AlertHandler(title: "确定", handle: {})])
                }else{
                    self.timeDown();
                }
            
            }else{
                
                if ((password.text as NSString).length < 8) {
                    
                    CommonUtil.alertView(self, title: "密码不得少于8个字符", message: "", buttons: [AlertHandler(title: "确定", handle: {})])
                    
                    return
                }
                
            
            UserService.sharedUserService.forgotPasswordValidate({ (data) -> Void in
                
                
                if data["status"].int == StatusCode.SystemSC.SYSTEM_OK {
                    
                    self.timeDown();
                    
                    
                }else if data["status"].int == StatusCode.SystemSC.SYSTEM_ERROR {
                    
                    CommonUtil.alertView(self, title: "系统错误", message: "我挂了", buttons: [AlertHandler(title: "确定", handle: {})])
                    
                }else if data["status"].int == StatusCode.UserSC.PHONE_EXISTS{
                    
                    CommonUtil.alertView(self, title: "此手机号码已经注册", message: "", buttons: [AlertHandler(title: "确定", handle: {})])
                    
                }else if data["status"].int == StatusCode.UserSC.VALIDATE_CODE_SMS_UPPER_LIMIT{
                    
                    CommonUtil.alertView(self, title: "验证码已达上限", message: text+"\n 注册验证码已达到上限，请24小时后再注册", buttons: [AlertHandler(title: "确定", handle: {})])
                    
                }else if data["status"].int == StatusCode.UserSC.ACCOUNT_NOT_EXIST{
                    
                    CommonUtil.alertView(self, title: "手机号未注册", message: text, buttons: [AlertHandler(title: "确定", handle: {})])
                    
                }
                
                
                
                
                }, errorHandler: { (data) -> Void in
                    
                    println(data)
                    
            }, userphone:text )
        
        }

    
    
        }else{
            
            CommonUtil.alertView(self, title: "手机号码错误", message: "您输入的是一个无效的手机号码",buttons:[AlertHandler(title: "确定", handle: {})])

        }
        
    }
 
    
    @IBAction func phoneInput(sender: AnyObject) {
        submitButtonEnable()
        
        ValidatePhone(phone)
    }
    
    @IBAction func passInput(sender: AnyObject) {
        submitButtonEnable()
        
        password.text=CommonUtil.validateString(password.text, limit: 20)
    }
    
    @IBAction func codeInput(sender: AnyObject) {
        submitButtonEnable()
        ValidateCode(code)
    }
    
    func submitButtonEnable(){
    
        if( (phone.text as NSString).length > 0  && (password.text as NSString).length > 0  && (code.text as NSString).length > 0) {
        
           confirmButton.enabled = true
        }else{
        
           confirmButton.enabled = false
        }
        
        if((phone.text as NSString).length > 0 && getCodeButton.titleLabel?.text == "获取验证码"){
           
            getCodeButton.enabled = true
        }else{
        
            getCodeButton.enabled = false
        }
        
        
    
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if(BaseString.USERPHONE != ""){
            self.phone.text = BaseString.USERPHONE
            ValidatePhone(phone);
        }
          disableNetWork = true
        if(BaseString.NetWorkEnable){
            networkEnable()
        }else{
            networkDisable()
        }
    }
    
    
    func initUI(){
        

        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        
        self.navigationItem.title = "忘记密码"
       
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        
        
  
        
        getCodeButton=CommonUtil.buttonSetImage(getCodeButton,name:"whritebtn",states:[UIControlState.Normal])
        
        confirmButton=CommonUtil.buttonSetImage(confirmButton,name:"greenbigbtn",states:[UIControlState.Selected,UIControlState.Normal,UIControlState.Highlighted,UIControlState.Disabled])
       
        
    
    }
    



}