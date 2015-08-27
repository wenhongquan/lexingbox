//
//  LoginController.swift
//  LIC
//
//  Created by 温红权 on 15/3/12.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import UIKit
//import ObjectMapper

class LoginController: BaseController {
    
    
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPass: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     
        var backBar = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "backLaunch:")
        backBar.tintColor=UIColor.whiteColor()
        
        self.navigationItem.leftBarButtonItem=backBar
        
        
          self.loginButton.addTarget(self, action: "login:", forControlEvents: UIControlEvents.TouchUpInside)
       

        loginButton=CommonUtil.buttonSetImage(loginButton,name:"greenbigbtn",states:[UIControlState.Selected,UIControlState.Normal,UIControlState.Highlighted,UIControlState.Disabled])
        
        
        registerButton = CommonUtil.buttonSetImage(registerButton, name: "remove_devicebtn", states: [UIControlState.Normal,UIControlState.Selected,UIControlState.Highlighted])
        registerButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
        registerButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        
        
        initUI()
    }
    
    
    
    func initUI(){
    
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        
        self.navigationItem.title = "登录"
        
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        CommonUtil.setNavigationControllerBackground(self)
    }
    
    
    
    @IBAction func registerButtonAction(sender: AnyObject) {
        
        CommonUtil.navToView(self, name: "registerView")
        
//        CommonUtil.backToView(self, name: "navregister", type:kCATransitionMoveIn ,subtype: kCATransitionFromTop)
        
    }
    
  
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
          disableNetWork = true
        if(BaseString.NetWorkEnable){
            networkEnable()
        }else{
            networkDisable()
        }
        
        if BaseString.USERPHONE != nil {
        
          userName.text = BaseString.USERPHONE
          ValidatePhone(userName);
        }
        userPass.text = ""
        
      
    }
    

    @IBAction func lostpasswordAction(sender: AnyObject) {
        
        CommonUtil.navToView(self, name: "forgetpassword")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func passInput(sender: AnyObject) {
        if ((userPass.text as NSString).length > 0) && ((userName.text as NSString).length > 0) {
        
            loginButton.enabled = true
        }else{
        
            loginButton.enabled = false
        }
        CommonUtil.validateString(userPass.text, limit: 20)
    }
    
    @IBAction func phoneInput(sender: AnyObject) {
        if  ((userPass.text as NSString).length > 0) && ((userName.text as NSString).length > 0)  {
            
            loginButton.enabled = true
        }else{
            
            loginButton.enabled = false
        }
        
        ValidatePhone(userName);
        
        
        
    }
    func backLaunch(sender: UIButton){
        
        CommonUtil.transitionWithType(kCATransitionReveal, withSubType: kCATransitionFromBottom, forView:self.view.window!)
        self.navigationController?.popViewControllerAnimated(false)

//        CommonUtil.backToView(self, name: "launchView",type: kCATransitionReveal, subtype: kCATransitionFromBottom)
    }
    
    func login(sender: UIButton){
        
        var username=userName.text.stringByReplacingOccurrencesOfString(" ", withString: "", options: nil, range: nil)
        
        var userpass=userPass.text
        
        
        
        var user=UserBase(phone: username, pass: userpass);
        
        if ( BaseString.DEVICETOKEN != "" ){
            user.deviceToken = BaseString.DEVICETOKEN
        }else{
            if(Cache.USER != nil && Cache.USER.deviceToken != nil ){
                user.deviceToken = Cache.USER.deviceToken
            }
        }

        if(BaseString.MOBILEREG.test(username)){
        
         if((userpass as NSString).length <= 20 ){
     
        
        
        UserService.sharedUserService.Login({ (data) -> Void in
        
           
            if(data["status"].int == StatusCode.SystemSC.SYSTEM_OK){

                //缓存用户
                Cache.USER = Mapper<User>().map(data["data"].dictionaryObject!)
                
                Cache.USER.isloginout = false
                
                //同步设置
                CommonUtil.initEffect()
                
                //获取电动车信息
                CommonUtil.getEbickInfo()
                GpsService.sharedGpsService.GetEbickInfo({ (data) -> Void in
                    
                    //返回原路径
                    CommonUtil.transitionWithType(kCATransitionReveal, withSubType: kCATransitionFromBottom, forView:self.view.window!)
                    self.navigationController?.popViewControllerAnimated(false)
                    
                }, errorHandler: { (data) -> Void in
                    
                }, userId: Cache.USER?.id?.description)
                
                
                
                
                //缓存用户
                CommonUtil.saveWithNSUserDefaults(Mapper().toJSON(Cache.USER), key: "USER")
                
               
                //获取报警数据
                CommonUtil.getEventData()
                
                
                
                
              
                
                return
            }else if data["status"].int == StatusCode.SystemSC.SYSTEM_ERROR {
                
                CommonUtil.alertView(self, title: "系统错误", message: "我挂了", buttons: [AlertHandler(title: "确定", handle: {})])
                
            }else if data["status"].int == StatusCode.UserSC.PASSWORD_ERROR{
                
                CommonUtil.alertView(self, title: "", message: "账号或密码错误，请重试",buttons:[AlertHandler(title: "确定", handle: {})])
                
            }else if data["status"].int == StatusCode.UserSC.ACCOUNT_NOT_EXIST{
                
                CommonUtil.alertView(self, title: "", message: "该手机号未注册",buttons:[AlertHandler(title: "确定", handle: {})])
                
            }else{
            
                CommonUtil.alertView(self, title: "", message: "账号或密码错误，请重试",buttons:[AlertHandler(title: "确定", handle: {})])
            }


        }, errorHandler: { (data) -> Void in
            
        }, body: (Mapper().toJSON(user)))
        
            return
         }else{
            CommonUtil.alertView(self, title: "", message: "密码不得超过20个字符",buttons:[AlertHandler(title: "确定", handle: {})])

            }

        }else{
         CommonUtil.alertView(self, title: "", message: "账号或密码错误，请重试",buttons:[AlertHandler(title: "确定", handle: {})])
       
        }
        
        
        
    }
    
  
}