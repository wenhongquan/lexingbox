//
//  SettingMessageController.swift
//  LIC
//
//  Created by 温红权 on 15/3/13.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import UIKit

class SettingMessageController: BaseController,UITextViewDelegate {
    
    
    @IBOutlet weak var textfiled: UITextView!
    @IBOutlet weak var textAreaView: UIView!
    
    @IBOutlet weak var subview: UIView!
    @IBOutlet weak var count: UILabel!

    var tiptext = "欢迎您在这里向我们吐槽乐行宝的各种问题。"

    
    var frame:CGRect!

    @IBOutlet weak var tip: UILabel!
    
    @IBOutlet weak var top: NSLayoutConstraint!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initUI()

        
        textAreaView.addTopBorderWithHeight(0.3, color: CommonUtil.UIColorFromRGB(0xd3d2d3))
        
        count.addBottomBorderWithHeight(0.3, color: CommonUtil.UIColorFromRGB(0xd3d2d3))
        
        textfiled.delegate = self
        
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "keyboardWillShowNotification:",
            name: UIKeyboardWillShowNotification,
            object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "keyboardWillHideNotification:",
            name: UIKeyboardWillHideNotification,
            object: nil)

        var button = UIButton()
        
        button.frame = CGRectMake(0.0, 2.0,40, 34);
        button.titleLabel?.textAlignment = NSTextAlignment.Right
        button.addTarget(self, action: "finsh:", forControlEvents: UIControlEvents.TouchUpInside)
        button.setTitle("发送", forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(17)
        button.setTitleColor(CommonUtil.UIColorFromRGB(0x01624b), forState: UIControlState.Disabled)
        button.setTitleColor(CommonUtil.UIColorFromRGB(0x2bcd9c), forState: UIControlState.Normal)
        button.setTitleColor(CommonUtil.UIColorFromRGB(0x01624b), forState: UIControlState.Selected)
        button.setTitleColor(CommonUtil.UIColorFromRGB(0x01624b), forState: UIControlState.Highlighted)
        
//        button.enabled = false
        
        var baritem = UIBarButtonItem(customView: button)
       
        self.navigationItem.rightBarButtonItem = baritem
       
       

        
        self.navigationItem.rightBarButtonItem?.enabled=false
      
        frame = self.subview.frame
        
        self.subview.frame = CGRectMake(frame.origin.x, frame.origin.y - 20, frame.width, frame.height)
        
//        textfiled.becomeFirstResponder()
 
        
    }
    
//    func backtomain(){
//        self.loading?.dismissAnimated(false)
//        self.loading?.dismiss()
//        
//        CommonUtil.transitionWithType(kCATransitionReveal, withSubType: kCATransitionFromBottom, forView: self.view.window!)
//        
//        self.navigationController?.popToRootViewControllerAnimated(false)
//    }
//    
//    var loading:JGProgressHUD?
    
    
    func finsh(sender: UIButton){
    
        if(textfiled.text != ""){
            var feedback:FeedBack = FeedBack();
            feedback.userId = Cache.USER.id
            feedback.message = textfiled.text
            
           
            UserService.sharedUserService.FeedBack({ (data) -> Void in
                
                
                if data["status"].int == StatusCode.SystemSC.SYSTEM_OK {
                    
                     CommonUtil.alertView(self, title: "感谢您的吐槽", message: "", buttons: [AlertHandler(title: "确定", handle: { () -> Void in
                        self.navigationController?.popViewControllerAnimated(true)
                        
                     
                     })])
                  
                    
                    
                }},
                 errorHandler: { (data) -> Void in
                    
                    println(data)
                },  body: (Mapper().toJSON(feedback)))
        
        }
    
    
    }
    
    
    func textViewDidBeginEditing(textView: UITextView) {
//        tip.text=""
    }
    
    
    
    func textViewDidChange(textView: UITextView) {
        if(textfiled.text == ""){
          tip.text=tiptext
        }else{
             tip.text=""
        }
    }

    
    
    func textViewDidEndEditing(textView: UITextView) {
        
        if(textfiled.text == ""){
            tip.text=tiptext
        }else{
            tip.text=""
        }


    }
    
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        var alltext = (textView.text as NSString).stringByReplacingCharactersInRange(range, withString: text)
        
        if((alltext as NSString).length == 0){
        
            tip.text=tiptext
        }else{
        
            tip.text = ""
        }
        var length = 0
        var temp = "";
        for c:Character in alltext {
            
            if((++length) <= 200){
             temp.append(c)
            }
        }
        
        if(length>0){
        
          self.navigationItem.rightBarButtonItem?.enabled=true
            
        }else{
            
          self.navigationItem.rightBarButtonItem?.enabled=false
        }
        
        if (length > 200) {
            count.text = "200/200"
            textView.text = temp;
            return false;
        }
        count.text = (length).description + "/200"
        return true;
    }


    
    

    
    
    override func viewDidDisappear(animated: Bool) {
         NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillShowNotification(notification: NSNotification){
        var info:NSDictionary = notification.userInfo!
        var keyheight = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().height

        
        var height = keyheight + subview.frame.height
        if(height > self.view.frame.height){

            let n = KeyboardNotification(notification)
            let animationDuration = n.animationDuration
            let animationCurve = n.animationCurve

            
            self.view.layoutIfNeeded()
            UIView.animateWithDuration(animationDuration,
                delay: 0,
                options: UIViewAnimationOptions(rawValue: UInt(animationCurve << 16)),
                animations: {
                    self.top.constant = self.view.frame.height - height
                    self.view.layoutIfNeeded()
                },
                completion: nil
            )
            
        }
        

        
    
    }
    
    func keyboardWillHideNotification(notification: NSNotification){
        
        let n = KeyboardNotification(notification)
        let animationDuration = n.animationDuration
        let animationCurve = n.animationCurve
        self.view.layoutIfNeeded()
        UIView.animateWithDuration(animationDuration,
            delay: 0,
            options: UIViewAnimationOptions(rawValue: UInt(animationCurve << 16)),
            animations: {
                self.top.constant = 0
                self.view.layoutIfNeeded()
            },
            completion: nil
        )


    }
    
 
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
    
    }
    
    
    func initUI(){
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        
        self.navigationItem.title = "吐槽产品经理"
        
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        
    }
}