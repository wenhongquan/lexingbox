//
//  CommonUtil.swift
//  LIC
//
//  Created by 温红权 on 15/3/11.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import UIKit
import AudioToolbox
//import ObjectMapper

typealias ALERTHANDLER = () -> Void
typealias THREADMETHOD = () -> Void

class AlertHandler{
    var title:String?
    var handle:ALERTHANDLER?
    required init(title:String,handle:ALERTHANDLER){
        self.title=title;
        self.handle=handle;
    }
}


struct CommonUtil {
    static func  resizeImage(image:UIImage,scan:CGFloat) ->UIImage{
        
        UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scan, image.size.height * scan));
        
        image.drawInRect(CGRectMake(0, 0, image.size.width * scan, image.size.height * scan))
        var images = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return images;
        
    }
    
    
    static func setNavigationControllerBackground(view:UIViewController) {
        
        view.navigationController?.navigationBar.titleTextAttributes=[NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        view.navigationController?.navigationBar.translucent = false;
        
        view.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "topbarbg_ios7"), forBarMetrics: UIBarMetrics.Default)
        
    }
    
    
    static func buttonSetImage(button:UIButton,name:String,states:[UIControlState]) -> UIButton {
        
        
        
        var top:CGFloat = 10; // 顶端盖高度
        var bottom:CGFloat = 10 ; // 底端盖高度
        var left:CGFloat = 10; // 左端盖宽度
        var right:CGFloat = 10; // 右端盖宽度
        var insets = UIEdgeInsetsMake(top, left, bottom, right);
        
        
        
        for state:UIControlState in states {
            
            if(state == UIControlState.Normal ){
                
                var image2 = UIImage(named: name)
                image2 = image2?.resizableImageWithCapInsets(insets, resizingMode: UIImageResizingMode.Stretch)
                button.setBackgroundImage(image2, forState: UIControlState.Normal)
            }
            if(state == UIControlState.Disabled ){
                var image1 = UIImage(named: name+"disable")
                image1 = image1?.resizableImageWithCapInsets(insets, resizingMode: UIImageResizingMode.Stretch)
                button.setBackgroundImage(image1, forState: UIControlState.Disabled)
                
            }
            if(state == UIControlState.Highlighted ){
                var image1 = UIImage(named: name+"highlight")
                image1 = image1?.resizableImageWithCapInsets(insets, resizingMode: UIImageResizingMode.Stretch)
                button.setBackgroundImage(image1, forState: UIControlState.Highlighted)
                
            }
            if(state == UIControlState.Selected){
                var image3 = UIImage(named: name+"highlight")
                image3 = image3?.resizableImageWithCapInsets(insets, resizingMode: UIImageResizingMode.Stretch)
                button.setBackgroundImage(image3, forState:  UIControlState.Selected)
                
            }
            
            
        }
        
        return button
    }
    
    static func buttonSetImage(button:UIButton,name:String,states:[UIControlState],radio:CGFloat) -> UIButton {
        
        
        
        var top:CGFloat = radio; // 顶端盖高度
        var bottom:CGFloat = radio ; // 底端盖高度
        var left:CGFloat = radio; // 左端盖宽度
        var right:CGFloat = radio; // 右端盖宽度
        var insets = UIEdgeInsetsMake(top, left, bottom, right);
        
        
        
        for state:UIControlState in states {
            
            if(state == UIControlState.Normal ){
                
                var image2 = UIImage(named: name)
                image2 = image2?.resizableImageWithCapInsets(insets, resizingMode: UIImageResizingMode.Stretch)
                button.setBackgroundImage(image2, forState: UIControlState.Normal)
            }
            if(state == UIControlState.Disabled ){
                var image1 = UIImage(named: name+"disable")
                image1 = image1?.resizableImageWithCapInsets(insets, resizingMode: UIImageResizingMode.Stretch)
                button.setBackgroundImage(image1, forState: UIControlState.Disabled)
                
            }
            if(state == UIControlState.Highlighted ){
                var image1 = UIImage(named: name+"highlight")
                image1 = image1?.resizableImageWithCapInsets(insets, resizingMode: UIImageResizingMode.Stretch)
                button.setBackgroundImage(image1, forState: UIControlState.Highlighted)
                
            }
            if(state == UIControlState.Selected){
                var image3 = UIImage(named: name+"highlight")
                image3 = image3?.resizableImageWithCapInsets(insets, resizingMode: UIImageResizingMode.Stretch)
                button.setBackgroundImage(image3, forState:  UIControlState.Selected)
                
            }
            
            
        }
        
        return button
    }
    
    static func NumButtonSetText(button:UIButton,text:String) -> UIButton {
        
        
        
        
        var top:CGFloat = 10; // 顶端盖高度
        var bottom:CGFloat = 10 ; // 底端盖高度
        var left:CGFloat = 10; // 左端盖宽度
        var right:CGFloat = 10; // 右端盖宽度
        var insets = UIEdgeInsetsMake(top, left, bottom, right);
        
        var image2 = UIImage(named: "numbutton")
        image2 = image2?.resizableImageWithCapInsets(insets, resizingMode: UIImageResizingMode.Stretch)
        button.setBackgroundImage(image2, forState: UIControlState.Normal)
        
        
        
        
        
        
        button.setTitle(text, forState: UIControlState.Normal)
        
        return button
    }
    
    
    static func StringLimt(limt:Int,string:String) ->String{
        
        if(string as NSString).length > limt {
            
            return (string as NSString).substringToIndex(limt) + "..."
        }else{
            
            return  string
        }
        
        
    }
    
    
    
    static func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static func UIColorFromRGBA(rgbValue: UInt,alpha:CFloat) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    static func alertView(view:UIViewController,title:String,message:String,buttons:[AlertHandler]) -> Void{
        
        
        if ((UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 8.0)  {
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            
            for  button in buttons {
                
                
                if(button.title == "取消"||button.title == "等待"){
                    var cancelAction = UIAlertAction(title: button.title!, style:.Cancel ) { (action) in
                        
                        button.handle!()
                        
                    }
                    alertController.addAction(cancelAction)
                }else{
                    var defultAction = UIAlertAction(title: button.title!, style: .Default) { (action) in
                        
                        button.handle!()
                        
                    }
                    alertController.addAction(defultAction)
                    
                    
                }
                
            }
            
            NSOperationQueue.mainQueue().addOperationWithBlock({
                () in
                view.presentViewController(alertController, animated: true) {
                    
                    
                }
                
                
                
            })
            
            
        }else{
            
            let alertView =  UIAlertViewExt(title: title, message:message, delegate: IosActionSheetDegetel.sharedIosActionSheetDegetel, cancelButtonTitle: nil)
            
            
            
            for  (index,button) in  enumerate(buttons) {
                
                
                if(button.title == "取消"||button.title == "等待"){
                    
                    alertView.addButtonWithTitle(button.title!)
                    alertView.cancelButtonIndex = index
                    alertView.handles?.append({()in
                        button.handle!()
                    })
                    
                }else{
                    alertView.addButtonWithTitle(button.title!)
                    
                    alertView.handles?.append({()in
                        button.handle!()
                    })
                    
                    
                    
                }
                
            }
            
            NSOperationQueue.mainQueue().addOperationWithBlock({
                () in
                
                alertView.show()
                
            })
            
        }
        
    }
    
    
    
    static func alertTelService(view:UIViewController,tels:String...){
        
        if ((UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 8.0)  {
            
            
            let shareMenu = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
            
            
            for tel in tels {
                
                let mobile = UIAlertAction(title: tel, style: .Default ) { (_) in
                    
                    UIApplication.sharedApplication().openURL(NSURL(string: "tel:"+tel)!)
                    return
                }
                shareMenu.addAction(mobile)
                
            }
            
            
            
            
            let cancelAction = UIAlertAction(title: "取消", style: .Cancel) { (_) in }
            
            
            shareMenu.addAction(cancelAction)
            
            shareMenu.view.tintColor=UIColor.darkGrayColor()
            
            
            
            shareMenu.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.allZeros
            
            shareMenu.popoverPresentationController?.sourceView = view.view
            shareMenu.popoverPresentationController?.sourceRect = CGRectMake((view.view.frame.size.width*0.5), (view.view.frame.size.height*0.5), 0, 0);// 显示在中心位置
            
            
            
            
            view.presentViewController(shareMenu, animated: true, completion: nil)
        }else{
            
            
            
            let shareMenu = UIActionSheetExt(title: nil, delegate: IosActionSheetDegetel.sharedIosActionSheetDegetel, cancelButtonTitle: nil, destructiveButtonTitle: nil)
            
            
            for tel in tels {
                shareMenu.addButtonWithTitle(tel)
                shareMenu.handles?.append({()in
                    
                    UIApplication.sharedApplication().openURL(NSURL(string: "tel:"+tel)!)
                })
                
            }
            
            shareMenu.addButtonWithTitle("取消")
            
            shareMenu.tag = StatusCode.ActionSheetSC.TEL
            shareMenu.cancelButtonIndex = tels.count
            
            
            if(view.tabBarController != nil){
                shareMenu.showFromTabBar(view.tabBarController?.tabBar)
            }else{
                shareMenu.showInView(view.view)
            }
            
            
        }
        
        
    }
    
    
    
    static func alertCustomService(view:UIViewController){
        
        if ((UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 8.0)  {
            
            
            let shareMenu = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
            
            let mobile = UIAlertAction(title: "15850771966", style: .Default ) { (_) in
                
                UIApplication.sharedApplication().openURL(NSURL(string: "tel:15850771966")!)
                return
            }
            
            let tel = UIAlertAction(title: "025-85729982", style: .Default ) { (_) in
                
                UIApplication.sharedApplication().openURL(NSURL(string: "tel:025-85729982")!)
                return
            }
            let cancelAction = UIAlertAction(title: "取消", style: .Cancel) { (_) in }
            shareMenu.addAction(tel)
            shareMenu.addAction(mobile)
            
            
            shareMenu.addAction(cancelAction)
            
            shareMenu.view.tintColor=UIColor.darkGrayColor()
            
            
            
            shareMenu.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.allZeros
            
            shareMenu.popoverPresentationController?.sourceView = view.view
            shareMenu.popoverPresentationController?.sourceRect = CGRectMake((view.view.frame.size.width*0.5), (view.view.frame.size.height*0.5), 0, 0);// 显示在中心位置
            
            
            
            
            view.presentViewController(shareMenu, animated: true, completion: nil)
            
        }else{
            
            
            
            let shareMenu = UIActionSheetExt(title: nil, delegate: IosActionSheetDegetel.sharedIosActionSheetDegetel, cancelButtonTitle: nil, destructiveButtonTitle: nil, otherButtonTitles: "025-85729982","15850771966","取消")
            
            shareMenu.tag = StatusCode.ActionSheetSC.TEL
            shareMenu.cancelButtonIndex = 2
            shareMenu.handles?.append({()in
                UIApplication.sharedApplication().openURL(NSURL(string: "tel:025-85729982")!)
            })
            
            shareMenu.handles?.append({()in
                UIApplication.sharedApplication().openURL(NSURL(string: "tel:15850771966")!)
            })
            if(view.tabBarController != nil){
                shareMenu.showFromTabBar(view.tabBarController?.tabBar)
            }else{
                shareMenu.showInView(view.view)
            }
            
            
        }
        
        
        
    }
    
    
    static func alertLoding(view:UIViewController,title:String) -> JGProgressHUD {
        
        var HUD = JGProgressHUD(style: JGProgressHUDStyle.Dark)
        HUD.textLabel.text=title
        HUD.showInView(view.view)
        //        HUD.dismissAnimated(false)
        
        return HUD
        
    }
    
    static func alertLoding(view:UIView,title:String) -> JGProgressHUD {
        
        var HUD = JGProgressHUD(style: JGProgressHUDStyle.Dark)
        HUD.textLabel.text=title
        
        HUD.square = true
        HUD.dismissAnimated(false)
        HUD.showInView(view)
        //        HUD.dismissAnimated(false)
        
        return HUD
        
    }
    
    static func alertSuccess(view:UIView,title:String)-> JGProgressHUD{
        
        var HUD = JGProgressHUD(style: JGProgressHUDStyle.Dark)
        HUD.indicatorView = JGProgressHUDSuccessIndicatorView()
        HUD.textLabel.text=title
        HUD.square = true
        HUD.dismissAnimated(false)
        
        
        HUD.showInView(view)
        
        return HUD
        
    }
    
    
    static func backToView(view:BaseController,name:String)->Void{
        
        
        var sb = UIStoryboard(name: "Main", bundle:nil)
        
        var vc = sb.instantiateViewControllerWithIdentifier(name) as! UIViewController
        
        view.presentViewController(vc, animated: true, completion: nil)
        
        return
        
        
    }
    
    static func backToView(view:UIViewController,name:String,type:String,subtype:String)->Void{
        
        
        var sb = UIStoryboard(name: "Main", bundle:nil)
        
        var vc = sb.instantiateViewControllerWithIdentifier(name) as! UIViewController
        
        
        transitionWithType(type, withSubType: subtype, forView: view.view.window!)
        
        view.presentViewController(vc, animated: false, completion: nil)
        
        
        
    }
    
    
    static func backToTabViewPush(view:UIViewController,subtype:String,tabIndex:Int)->Void{
        
        
        var sb = UIStoryboard(name: "Main", bundle:nil)
        
        var vc = sb.instantiateViewControllerWithIdentifier("maintab") as? UITabBarController
        
        vc?.selectedIndex=tabIndex
        
        transitionWithType(kCATransitionFade, withSubType: subtype, forView: view.view.window!)
        
        view.presentViewController(vc!, animated: false, completion: nil)
        
        return
        
        
    }
    
    static func navToView(view:UIViewController,name:String)->Void{
        
        
        var sb = UIStoryboard(name: "Main", bundle:nil)
        
        
        
        var vc = sb.instantiateViewControllerWithIdentifier(name) as! UIViewController
        
        
        vc.hidesBottomBarWhenPushed = true
        
        
        view.navigationController?.pushViewController(vc, animated: true)
        
        return
        
        
    }
    
    
    
    static func backToWebView(view:BaseController,name:String,title:String,url:String)->Void{
        
        if (NSClassFromString("WKWebView") != nil) {
            
            var sb = UIStoryboard(name: "Main", bundle:nil)
            var vc = sb.instantiateViewControllerWithIdentifier(name) as! WebViewController
            vc.hidesBottomBarWhenPushed = true
            var bar = UIBarButtonItem()
            bar.title = "返回"
            view.navigationItem.backBarButtonItem =  bar
            vc.titles=title
            vc.url=url
            view.navigationController?.pushViewController(vc, animated: true)
            
        }else{
            var sb = UIStoryboard(name: "Main", bundle:nil)
            var vc = sb.instantiateViewControllerWithIdentifier("uiWebViewExtController") as! UIWebViewExtController
            vc.hidesBottomBarWhenPushed = true
            var bar = UIBarButtonItem()
            bar.title = "返回"
            view.navigationItem.backBarButtonItem =  bar
            vc.titles=title
            vc.url=url
            view.navigationController?.pushViewController(vc, animated: true)
        }
        
        return
    }
    
    static func backToWebView(view:BaseTableController,name:String,title:String,url:String)->Void{
        if (NSClassFromString("WKWebView") != nil) {
            var sb = UIStoryboard(name: "Main", bundle:nil)
            var vc = sb.instantiateViewControllerWithIdentifier(name) as! WebViewController
            vc.titles=title
            vc.url=url
            
            var bar = UIBarButtonItem()
            bar.title = "返回"
            
            view.navigationItem.backBarButtonItem =  bar
            vc.hidesBottomBarWhenPushed = true
            
            view.navigationController?.pushViewController(vc, animated: true)
            
        }else{
            var sb = UIStoryboard(name: "Main", bundle:nil)
            var vc = sb.instantiateViewControllerWithIdentifier("uiWebViewExtController") as! UIWebViewExtController
            vc.titles=title
            vc.url=url
            
            var bar = UIBarButtonItem()
            bar.title = "返回"
            
            view.navigationItem.backBarButtonItem =  bar
            vc.hidesBottomBarWhenPushed = true
            
            view.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        
        return
    }
    
    
    
    static func saveWithNSUserDefaults(data:AnyObject,key:String) {
        /// 1、利用NSUserDefaults存储数据
        let defaults = NSUserDefaults.standardUserDefaults();
        //  2、存储数据
        defaults.setObject(data, forKey: key);
        //  3、同步数据
        defaults.synchronize();
    }
    

    
    static func readWithNSUserDefaults(key:String) -> AnyObject? {
        let defaults = NSUserDefaults.standardUserDefaults();
        var data: AnyObject? = defaults.objectForKey(key);
        if( data != nil ){
            return data
        }
        
        return nil
    }
    
    
    
    static func transitionWithType(type:String,withSubType subType:String,forView view:UIView){
        
        //创建CATransition对象
        var animation = CATransition()
        
        //设置运动时间
        animation.duration = 0.4
        
        //设置运动type
        animation.type = type;
        
        if (!subType.isEmpty) {
            
            //设置子类
            animation.subtype = subType;
        }
        
        //设置运动速度
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        
        view.layer.addAnimation(animation, forKey: "animation")
        
    }
    static func transitionWithType(type:String,withSubType subType:String,forView view:UIView,time:Double){
        
        //创建CATransition对象
        var animation = CATransition()
        
        //设置运动时间
        animation.duration = time
        
        //设置运动type
        animation.type = type;
        
        if (!subType.isEmpty) {
            
            //设置子类
            animation.subtype = subType;
        }
        
        //设置运动速度
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        
        view.layer.addAnimation(animation, forKey: "animation")
        
    }
    
    
    static func validateNumber(number:String,limit:Int) -> String {
        if ((number as NSString).length == 0){
            return "";
        }
        var string=""
        for c in number {
            if ( c.toInt() >= 48 && c.toInt() <= 57){
                if((string as NSString).length <= limit){
                    string.append(c)
                }
            }
        }
        return string
    }
    
    static func validateString(string:String,limit:Int) -> String {
        if ((string as NSString).length == 0){
            return "";
        }
        var stringtemp=""
        if (string as NSString).length > limit {
            
            stringtemp = (string as NSString).substringToIndex(limit)
        }else{
            
            stringtemp = string
        }
        return stringtemp
    }
    
    
    
    static func FloatToDate(date:NSTimeInterval?,format:String?) -> String {
        
        if(date==nil||format==nil){
            return ""
        }
        var formats = format
        if(formats == ""){
            formats = "yyyy/MM/dd HH:mm:ss"
        }
        
        
        var outputFormat = NSDateFormatter()
        let myDataSource: NSString = "\(date!/1000)"
        //格式化规则
        outputFormat.dateFormat = formats!
        //定义时区
        outputFormat.locale = NSLocale(localeIdentifier: "shanghai")
        
        
        NSDate(timeIntervalSince1970: myDataSource.doubleValue)
        
        //发布时间
        return outputFormat.stringFromDate(NSDate(timeIntervalSince1970: myDataSource.doubleValue))
        
    }
    
    static func  FloatToTime(date:NSTimeInterval?) -> String {
        
        if(date == nil){
            return ""
        }
        
        
        
        
        
        var day = Int( Double(date!) / (3600*24))
        var hous = Int((Double(date!) - Double(day) * 3600*24 ) / (3600))
        var mins = Int((Double(date!) - Double(day)*3600*24 - Double(hous) * 3600 ) / (60))
        var seconds = Int((Double(date!) - Double(day)*3600*24 - Double(hous) * 3600 - Double(mins) * 60))
        
        if(seconds >= 30 ){
            
            mins+=1
        }
        
        
        var temp = ""
        if(day > 0){
            temp+=(day.description+"天")
        }
        if(hous > 0){
            temp+=(hous.description+"小时")
        }
        if(mins > 0){
            temp+=(mins.description+"分")
        }
        
        if(day<1&&hous<1&&mins<1){
            temp += "0分"
            
        }
        
        
        return temp;
        
        
    }
    
    static func  FloatToAttrTime(date:NSTimeInterval?) -> NSMutableAttributedString {
        var attributedString = NSMutableAttributedString(string:"")
        if(date == nil){
            return attributedString
        }
        
        var day = Int( Double(date!) / (3600*24))
        var hous = Int((Double(date!) - Double(day)*3600*24 ) / (3600))
        var mins = Int((Double(date!) - Double(day)*3600*24 - Double(hous) * 3600 ) / (60))
        var seconds = Int((Double(date!) - Double(day)*3600*24 - Double(hous) * 3600 - Double(mins) * 60))
        
        if(seconds >= 30 ){
            mins+=1
        }
        
        
        if(day > 0){
            attributedString.appendAttributedString( CommonUtil.SetLableTextAttr(day.description, numSize: 16, desc: "天", descSize: 10) )
        }
        if(hous > 0){
            attributedString.appendAttributedString( CommonUtil.SetLableTextAttr(hous.description, numSize: 16, desc: "小时", descSize: 10) )
        }
        if(mins > 0){
            
            attributedString.appendAttributedString( CommonUtil.SetLableTextAttr(mins.description, numSize: 16, desc: "分", descSize: 10) )
            
        }
        
        if(day<1&&hous<1&&mins<1){
            attributedString.appendAttributedString( CommonUtil.SetLableTextAttr("0", numSize: 16, desc: "分", descSize: 10) )
            
        }
        
        
        return attributedString;
        
        
    }
    
    
    static func FloatToDate(date:NSTimeInterval?) -> NSDate {
        
        if(date==nil){
            return NSDate()
        }
        
        
        let myDataSource: NSString = "\(date!/1000)"
        
        //发布时间
        return NSDate(timeIntervalSince1970: myDataSource.doubleValue)
        
    }
    
    static func complaywithNow(date:NSTimeInterval) -> Bool {
        
        
        
        var dateFormatter2 = NSDateFormatter()
        dateFormatter2.dateFormat = "yyyy-MM-dd"
        // Date 转 String
        var nowString = dateFormatter2.stringFromDate(NSDate())          // 2015-03-24 21:00:00
        // String 转 Date
        var now = dateFormatter2.dateFromString(nowString)!
        
        let myDataSource: NSString = "\(date/1000)"
        
        var data = NSDate(timeIntervalSince1970: myDataSource.doubleValue)
        
        
        if( data.compare(now) == NSComparisonResult.OrderedDescending   ){
            
            return true
        }else{
            
            return false
        }
        
        
    }
    
    
    static func GCDThread(whatdo:THREADMETHOD?,afterdo:THREADMETHOD?){
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), {
            
            //这里写需要放到子线程做的耗时的代码
            whatdo?()
            
            dispatch_async(dispatch_get_main_queue(), {
                
                
                afterdo?()
            })
        })
        
        
    }
    
    
    static func getEventData(){
        
        //报警数据加载到内存
        
        
        
        CommonUtil.GCDThread({()->Void in
            
            CommonUtil.getevents()
            
            }, afterdo: nil)
        
        
        
    }
    
    
    static func getevents(){
        
        // sleep(10)
            
            
            EventService.sharedEventService.GetMsgCount({(data)in
                
                
                if data["status"].int == StatusCode.SystemSC.SYSTEM_OK {
                    
                    if data["data"].count > 0 {
                        var temp:[MsgCount] = []
                        
                        for (index: String, subJson: JSON) in data["data"] {
                            //Do something you want
                            temp.append(Mapper<MsgCount>().map(subJson.dictionaryObject)!)
                        }
                        
                        
                        if( Cache.MSGCOUNT?.count>0){
                            var allCount0 = 0
                            if(temp.count > 0){
                                for msgCount in temp {
                                    if msgCount.unreadCount > 0 {
                                        allCount0 += msgCount.unreadCount
                                    }
                                }
                            }
                            
                            
                            var allCount1 = 0
                            
                            for msgCount in Cache.MSGCOUNT {
                                if msgCount.unreadCount > 0 {
                                    allCount1 += msgCount.unreadCount
                                }
                            }
                            
                            if(allCount0>0 && allCount0>allCount1){
                                CommonUtil.playEffect()
                            }
                            
                            
                        }else{
                            //                        CommonUtil.playEffect()
                        }
                        
                        
                        Cache.MSGCOUNT = temp
                        
                        if(Cache.MSGCOUNT?.count > 0){
                            
                            CommonUtil.saveWithNSUserDefaults(Mapper().toJSONArray(Cache.MSGCOUNT), key: "MSG")
                        }else{
                            
                            Cache.MSGCOUNT = []
                        }
                        
                        
                    }else{
                        
                        Cache.MSGCOUNT = []
                        
                        
                    }
                }
                NSNotificationCenter.defaultCenter().postNotificationName("getevents", object: nil)
                
                }, errorHandler: {(data)in
                    
                    
                }, ebickId: Cache.EBICK?.id)
        
        
        //获取报警总数
        //        EventService.sharedEventService.GetEventCountByUserId({(data) -> Void in
        //            if data["status"].int == StatusCode.SystemSC.SYSTEM_OK {
        //
        //
        //                var ebicksEvents:[EbickEvents] = []
        //
        //                var ebicks = data["data"]
        //
        //                //            println(ebicks)
        //
        //                if(ebicks.count > 0 ){
        //
        //                    for var j=0;j<ebicks.count;j++ {
        //
        //
        //                        var ebickeventdata = ebicks[j]
        //
        //                        var ebickEvents:EbickEvents = Mapper<EbickEvents>().map(ebickeventdata.dictionaryObject!)
        //
        //                        ebicksEvents.append(ebickEvents)
        //                    }
        //
        //                }
        //
        //                var ebicksevents = EbicksEvents();
        //                ebicksevents.ebicksEvents=ebicksEvents;
        //                Cache.EBICKSEVENTS=ebicksevents;
        //
        //
        //                CommonUtil.saveWithNSUserDefaults(Mapper().toJSON(Cache.EBICKSEVENTS), key: "EVENT")
        //
        //                NSNotificationCenter.defaultCenter().postNotificationName("getevents", object: nil)
        //
        //            }
        //
        //
        //
        //
        //
        //            }, errorHandler: {(data) -> Void in
        //
        //                //            println(data)
        //
        //        })
        
    }
    
    
    //    static func geteventMessage(ebickid:Int,category:Int,paged:Int,pagesize:Int){
    //
    //        EventService.sharedEventService.GetEventsByUserId({(data) -> Void in
    //            if data["status"].int == StatusCode.SystemSC.SYSTEM_OK {
    //
    //
    //                var events = data["data"]
    //
    //                //                println(events)
    //
    //                var eventMessagePage:EventMessagePage = Mapper<EventMessagePage>().map(events.dictionaryObject!)
    //
    //
    //                Cache.EVENTMESSAGES = eventMessagePage
    //
    //
    //                NSNotificationCenter.defaultCenter().postNotificationName("geteventmessage", object: nil)
    //
    //
    //
    //            }
    //
    //
    //            }, errorHandler: {(data) -> Void in
    //
    //                //                println(data)
    //
    //            },category: category.description, ebickId: ebickid.description, paged: paged.description, pagesize: pagesize.description)
    //
    //
    //
    //
    //
    //    }
    
    
    
    static func getEbickInfo(){
        
        GpsService.sharedGpsService.GetEbickInfo(nil, errorHandler: nil, userId: Cache.USER?.id?.description)
        
        
    }
    
    
    static func getGpsInfo(){
        
        if(Cache.EBICK?.gpsId != nil){
            
            
            CommonUtil.GCDThread({()in
                
                if(Cache.EBICK != nil){
                    
                    GpsService.sharedGpsService.GetGPSInfo({(data)-> Void in
                        
                        
                        if(data["status"].int == StatusCode.SystemSC.SYSTEM_OK){
                            
                            Cache.GPSINFO = Mapper<GpsInfo>().map(data["data"].dictionaryObject!)
                            
                            NSNotificationCenter.defaultCenter().postNotificationName("getGpsInfo", object: nil)
                            
                            
                        }
                        
                        
                        },errorHandler: { (data) -> Void in
                            
                            
                        }, gpsId: Cache.EBICK.gpsId!)
                }
                
                
                }, afterdo: nil)
        }
        
        
    }
    
    
    
    
    
    
    
    
    static func formatDate(time:NSTimeInterval) -> String {
        
        var date = ""
        
        
        if(CommonUtil.complaywithNow(time)){
            
            date =  CommonUtil.FloatToDate(time,format:"HH:mm")
        }else{
            
            date =  CommonUtil.FloatToDate(time,format:"MM-dd HH:mm")
        }
        
        return date
        
    }
    
    
    
    static func imageWithView(view:UIView){
        
        let layer = view.layer
        let scale = UIScreen.mainScreen().scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        
        layer.renderInContext(UIGraphicsGetCurrentContext())
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil)
        
    }
    
    
    
    static func newLineOverlay(color:UInt) -> CAShapeLayer{
        
        var line: CAShapeLayer = {
            var overlay = CAShapeLayer()
            overlay.backgroundColor = UIColor.clearColor().CGColor
            overlay.fillColor       = UIColor.clearColor().CGColor
            overlay.strokeColor     = CommonUtil.UIColorFromRGB(color).CGColor
            overlay.lineWidth       = 2
            //    overlay.lineDashPattern = [7.0, 7.0]
            overlay.lineDashPhase   = 0
            
            return overlay
            }()
        
        return line
        
        
    }
    
    static func newLineOverlay(color:UInt,apache:CFloat) -> CAShapeLayer{
        
        var line: CAShapeLayer = {
            var overlay = CAShapeLayer()
            overlay.backgroundColor = UIColor.clearColor().CGColor
            overlay.fillColor       = UIColor.clearColor().CGColor
            overlay.strokeColor     = CommonUtil.UIColorFromRGBA(color, alpha: apache).CGColor
            overlay.lineWidth       = 2
            //    overlay.lineDashPattern = [7.0, 7.0]
            overlay.lineDashPhase   = 0
            
            return overlay
            }()
        
        return line
        
        
    }
    
    
    static func newLineOverlay(color:UIColor) -> CAShapeLayer{
        
        var line: CAShapeLayer = {
            var overlay = CAShapeLayer()
            overlay.backgroundColor = UIColor.clearColor().CGColor
            overlay.fillColor       = UIColor.clearColor().CGColor
            overlay.strokeColor     = color.CGColor
            overlay.lineWidth       = 2
            //    overlay.lineDashPattern = [7.0, 7.0]
            overlay.lineDashPhase   = 0
            
            return overlay
            }()
        
        return line
        
        
    }
    static func newLineOverlayDefult() -> CAShapeLayer{
        
        var line: CAShapeLayer = {
            var overlay = CAShapeLayer()
            
            overlay.backgroundColor = UIColor.clearColor().CGColor
            overlay.fillColor       = UIColor.clearColor().CGColor
            overlay.strokeColor     = CommonUtil.UIColorFromRGB(0xd9d9d9).CGColor
            overlay.lineWidth       = 1
            //    overlay.lineDashPattern = [7.0, 7.0]
            overlay.lineDashPhase   = 0
            
            return overlay
            }()
        
        return line
        
        
    }
    
    
    static func newLineOverlay() -> CAShapeLayer{
        
        var line: CAShapeLayer = {
            var overlay = CAShapeLayer()
            
            overlay.backgroundColor = UIColor.clearColor().CGColor
            overlay.fillColor       = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).CGColor
            overlay.lineWidth       = 0
            //    overlay.lineDashPattern = [7.0, 7.0]
            overlay.lineDashPhase   = 0
            
            return overlay
            }()
        
        return line
        
        
    }
    
    
    static func setTabBarRed(tabBarController:UITabBarController?,index:Int,num:Int){
        
        
        
        if( tabBarController == nil ) {return}
        
        var temp = false
        
        for view in tabBarController!.tabBar.subviews {
            
            if(view.isKindOfClass(UIImageView)){
                var subView:UIImageView = view as! UIImageView
                
                if (subView.tag == 888+index) {
                    
                    temp = true
                    break;
                }
            }
            
        }
        
        if(temp){
            
            return
        }
        
        CommonUtil.playEffect()
        
        var badgeView = UIImageView()
        
        
        //新建小红点
        
        badgeView.tag = 888 + index;
        
        
        badgeView.image = UIImage(named: "redpoint")
        
        
        var tabFrame = tabBarController?.tabBar.frame
        
        //确定小红点的位置
        var percentX:CGFloat = CGFloat((Double(index) + 0.608) / Double(num));
        var x:CGFloat = percentX * tabFrame!.size.width ;
        var y:CGFloat = 0.1 * tabFrame!.size.height;
        
        
        badgeView.frame = CGRectMake(x, y, 11, 11);
        tabBarController?.tabBar.addSubview(badgeView)
    }
    
    
    static func removeTabBarRed(tabBarController:UITabBarController?,index:Int){
        
        if( tabBarController == nil ) {return}
        
        
        for view in tabBarController!.tabBar.subviews {
            
            if(view.isKindOfClass(UIImageView)){
                var subView:UIImageView = view as! UIImageView
                
                if (subView.tag == 888+index) {
                    
                    subView.removeFromSuperview();
                    
                }
            }
            
        }
    }
    
    
    static func login(){
        
        
        if(Cache.USER == nil || Cache.USER.isloginout)
        {
            
            return
        }
        
        CommonUtil.GCDThread({() in
            
            var user = User();
            user.phone = Cache.USER?.phone
            user.password = Cache.USER?.password
            if ( BaseString.DEVICETOKEN != "" ){
                user.deviceToken = BaseString.DEVICETOKEN
            }else{
                if(Cache.USER != nil && Cache.USER.deviceToken != nil ){
                    user.deviceToken = Cache.USER.deviceToken
                }
            }
            
            
            
            UserService.sharedUserService.Login({ (data) -> Void in
                
                
                if(data["status"].int == StatusCode.SystemSC.SYSTEM_OK){
                    
                    //缓存用户
                    Cache.USER = Mapper<User>().map(data["data"].dictionaryObject!)
                    
                    Cache.USER.isloginout = false
                    
                    CommonUtil.initEffect()
                    
                    //建立websocket
                    //                    WebSocketUtil.sharedWebSocket.connect()
                    
                    //缓存用户
                    CommonUtil.saveWithNSUserDefaults(Mapper().toJSON(Cache.USER), key: "USER")
                    
                    //获取报警数据
                    CommonUtil.getEventData()
                    
                    //发送成功通知
                    NSNotificationCenter.defaultCenter().postNotificationName("loginevent", object: "success")
                    
                    
                    return
                }else {
                    
                    //发生错误
                    
                    NSNotificationCenter.defaultCenter().postNotificationName("loginevent", object: "error")
                    
                }
                
                }, errorHandler: { (data) -> Void in
                    
                }, body: (Mapper().toJSON(user)))
            
            
            
            }, afterdo: nil)
        
        
        
    }
    
    
    static func SetLableTextAttr(num:String,numSize:CGFloat,desc:String,descSize:CGFloat) -> NSMutableAttributedString{
        
        var attributedString = NSMutableAttributedString(string:"")
        var attrs = [NSFontAttributeName : UIFont.systemFontOfSize(numSize)]
        var gString = NSMutableAttributedString(string:num, attributes:attrs)
        attributedString.appendAttributedString(gString)
        attrs = [NSFontAttributeName : UIFont.systemFontOfSize(descSize)]
        gString = NSMutableAttributedString(string:desc, attributes:attrs)
        attributedString.appendAttributedString(gString)
        
        return attributedString
    }
    
    
    
    
    
    
    
    static func getDataSizeString(nSize:Int) -> String
    {
        var string:String
        if (nSize<1024)
        {
            string =  String(format:"%dB", nSize)
        }
        else if (nSize<1048576)
        {
            string = String(format:"%dK", (nSize/1024))
        }
        else if (nSize<1073741824)
        {
            if ((nSize%1048576) == 0 )
            {
                string =  String(format:"%dM", (nSize/1048576))
            }
            else
            {
                var decimal = 0; //小数
                var decimalStr:String?;
                decimal = (nSize%1048576);
                decimal /= 1024;
                
                if (decimal < 10)
                {
                    decimalStr = String(format:"%d", 0)
                }
                else if (decimal >= 10 && decimal < 100)
                {
                    var i = decimal / 10;
                    if (i >= 5)
                    {
                        decimalStr = String(format:"%d", 1)     }
                    else
                    {
                        decimalStr = String(format:"%d", 0)
                    }
                    
                }
                else if (decimal >= 100 && decimal < 1024)
                {
                    var  i = decimal / 100;
                    if (i >= 5)
                    {
                        decimal = i + 1;
                        
                        if (decimal >= 10)
                        {
                            decimal = 9;
                        }
                        
                        decimalStr = String(format:"%d", decimal)
                    }
                    else
                    {
                        decimalStr =  String(format:"%d", i)
                    }
                }
                
                if ((decimalStr == nil)||decimalStr!.isEmpty)
                {
                    string = String(format:"%dMss", nSize/1048576)
                }
                else
                {
                    string = String(format:"%d.%@M", nSize/1048576,decimalStr!)
                }
            }
        }
        else	// >1G
        {
            string = String(format:"%dG", nSize/1073741824)
        }
        
        return string;
    }
    
    
    static func playEffect(){
        if(BaseString.ISSHARK == 1 ){
            
            AudioServicesPlaySystemSound(UInt32(kSystemSoundID_Vibrate));
        }
        
        if(BaseString.ISSOUND == 1){
            
            let fileURL = NSURL(fileURLWithPath: "/System/Library/Audio/UISounds/sms-received1.caf")
            var soundID:SystemSoundID = 0
            AudioServicesCreateSystemSoundID(fileURL, &soundID)
            AudioServicesPlaySystemSound(soundID)
            
        }
        
        
    }
    
    
    static func initEffect(){
        
        if(Cache.USER.iosSetItem != nil){
            if(Cache.USER.iosSetItem=="11"){
                BaseString.ISSHARK = 1
                BaseString.ISSOUND = 1
            }else
                if(Cache.USER.iosSetItem=="10"){
                    BaseString.ISSHARK = 1
                    BaseString.ISSOUND = 0
                    
                }else
                    if(Cache.USER.iosSetItem=="00"){
                        BaseString.ISSHARK = 0
                        BaseString.ISSOUND = 0
                    }else{
                        BaseString.ISSHARK = 0
                        BaseString.ISSOUND = 1
            }
            
        }
        
    }
    
    static func rad(d:Double) -> Double {
        return d * M_PI / 180.0;
    }
    
    static let EARTH_RADIUS:Double = 6378137;// 地球半径
    
    static func  getDistance(var lng1:Double, lat1:Double, lng2:Double,
        lat2:Double) -> Double {
            var radLat1 = rad(lat1);
            var radLat2 = rad(lat2);
            var a = radLat1 - radLat2;
            var b = rad(lng1) - rad(lng2);
            var s = 2 * asin(sqrt(pow(sin(a / 2), 2)
                + cos(radLat1) * cos(radLat2)
                * pow(sin(b / 2), 2)));
            s = s * EARTH_RADIUS;
            s = round(s * 10000) / 10000;
            return s;
    }
    
    
    static func locationisEnable(viewcontroller:UIViewController) -> Bool{
        
        if(!CLLocationManager.locationServicesEnabled() || CLLocationManager.authorizationStatus() ==  CLAuthorizationStatus.Denied || CLLocationManager.authorizationStatus() ==  CLAuthorizationStatus.Restricted){
            
            
            CommonUtil.alertView(viewcontroller, title: "无位置权限", message: "为了您的正常使用，乐行宝需要获取您的位置权限", buttons: [AlertHandler(title: "好", handle: {
                
            })])
            return false
        }
        
        return true
    }
    
    
}

extension String {
    
    func contains(find: String) -> Bool{
        return self.rangeOfString(find) != nil
    }
}

  