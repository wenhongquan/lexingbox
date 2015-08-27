//
//  RegisterController.swift
//  LIC
//
//  Created by 温红权 on 15/3/12.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import UIKit
//import ObjectMapper

class RegisterController: BaseController,UIAlertViewDelegate {
    
    @IBOutlet weak var userPhone: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var addNumb: UITextField!
    

    
    var lastCount=0;
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        initUI()
        
        registerButton=CommonUtil.buttonSetImage(registerButton,name:"greenbigbtn",states:[UIControlState.Selected,UIControlState.Normal,UIControlState.Highlighted,UIControlState.Disabled])

    }
  
    
    func initUI(){
        
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        
        self.navigationItem.title = "注册"
        
        
        
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        
        
        CommonUtil.setNavigationControllerBackground(self)
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

    
    override func viewDidDisappear(animated: Bool) {
        
//           self.navigationController?.navigationBar.backIndicatorImage =
    }
    
    
    @IBAction func userdelegateAction(sender: AnyObject) {
        
       
        
        CommonUtil.backToWebView(self, name: "webviewcontroller", title: "用户协议", url: BaseString.HTTPADDR+"faq/203001.html")
    }
    
    @IBAction func registerClick(sender: AnyObject) {
        self.view.endEditing(true)

        
        var context="我们将发送验证码短信到这个号码:\n"+addNumb.text+" "+userPhone.text;
        
        var userPhoneText=addNumb.text+" "+userPhone.text;
        
        var text=self.userPhone.text.stringByReplacingOccurrencesOfString(" ", withString: "", options: nil, range: nil)
        
        
        if(BaseString.MOBILEREG.test(text)){
            CommonUtil.alertView(self, title: "确认手机号码", message: context,buttons:[AlertHandler(title: "取消", handle: {}),AlertHandler(title: "好", handle: {
                var user:UserBase = UserBase();
                user.phone=text;
                BaseString.USERPHONE=user.phone
                
                var loding = CommonUtil.alertLoding(self, title: "请稍等...")
                
                if(BaseString.ISTEST){
                    loding.dismiss();
                    
                    
                    var sb = UIStoryboard(name: "Main", bundle:nil)
                    var vc = sb.instantiateViewControllerWithIdentifier("verificationCodeView") as! VerificationCodeController
                    vc.userPhone=userPhoneText
                    vc.hidesBottomBarWhenPushed = true
                    CommonUtil.transitionWithType(kCATransitionMoveIn, withSubType: kCATransitionFromTop, forView: self.view.window!)

                    self.navigationController?.pushViewController(vc, animated: false)
                    
                    
                    
                }else{




                
                UserService.sharedUserService.RegisterValidate({ (data) -> Void in
                    
                    loding.dismiss();
                    if data["status"].int == StatusCode.SystemSC.SYSTEM_OK {
                        
                        
                        var sb = UIStoryboard(name: "Main", bundle:nil)
                        var vc = sb.instantiateViewControllerWithIdentifier("verificationCodeView") as! VerificationCodeController
                        vc.userPhone=userPhoneText
                        vc.hidesBottomBarWhenPushed = true
                        CommonUtil.transitionWithType(kCATransitionMoveIn, withSubType: kCATransitionFromTop, forView: self.view.window!)
                        
                        self.navigationController?.pushViewController(vc, animated: false)


                    
                    }else if data["status"].int == StatusCode.UserSC.PHONE_EXISTS{
                        
                        CommonUtil.alertView(self, title: "此手机号码已经注册", message: "", buttons: [AlertHandler(title: "确定", handle: {})])
                        
                    }else if data["status"].int == StatusCode.UserSC.VALIDATE_CODE_SMS_UPPER_LIMIT{
                        
                        CommonUtil.alertView(self, title: "验证码已达上限", message: userPhoneText+"\n 注册验证码已达到上限，请24小时后再注册", buttons: [AlertHandler(title: "确定", handle: {})])
                        
                    }else if data["status"].int == StatusCode.SMSSC.REPEAT_SAME_PHONE_NO_30_SECONDS_SEND_SAME_CONTENT {
                        
                        CommonUtil.alertView(self, title: "错误", message: "同一手机号30秒内重复提交相同的内容", buttons: [AlertHandler(title: "确定", handle: {})])
                        
                    }else if data["status"].int == StatusCode.SMSSC.REPEAT_SAME_PHONE_NO_5_MINUTES_SEND_MORE_THAN_3_TIMES_SAME_CONTENT {
                        
                        CommonUtil.alertView(self, title: "错误", message: "同一手机号5分钟内重复提交相同的内容超过3次", buttons: [AlertHandler(title: "确定", handle: {})])
                        
                    }else if data["status"].int == StatusCode.SMSSC.PHONE_NO_LIST_FILTERING {
                        
                        CommonUtil.alertView(self, title: "错误", message: "手机号黑名单过滤", buttons: [AlertHandler(title: "确定", handle: {})])
                        
                    }else {
                        
                        CommonUtil.alertView(self, title: "系统错误", message: "我挂了", buttons: [AlertHandler(title: "确定", handle: {})])
                        
                    }


                    
                    
                    }, errorHandler: { (data) -> Void in
                        
                        println(data)
                        
                }, body: (Mapper().toJSON(user)))
                }
            })] )
            
        }else{
            
            CommonUtil.alertView(self, title: "手机号码错误", message: "您输入的是一个无效的手机号码",buttons:[AlertHandler(title: "确定", handle: {})])
        }
        
        
        
        
        
        
        
        
    }
    @IBAction func phoneInput(sender: AnyObject) {
       
  
        if(userPhone.text != ""){
        
           registerButton.enabled=true
        }else{
           registerButton.enabled=false
        }
        
        ValidatePhone(userPhone);
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backLaunch(sender: UIButton){
         self.navigationController?.popViewControllerAnimated(true)
//         CommonUtil.backToView(self, name: "navlogin",type: kCATransitionReveal, subtype: kCATransitionFromBottom)   
    }
    

}

