//
//  AppDelegate.swift
//  LIC
//
//  Created by 温红权 on 15/3/11.
//  Copyright (c) 2015年 乐行天下. All rights reserved.
//

import UIKit
//import ObjectMapper


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,WXApiDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        var bundledPath = NSBundle.mainBundle().resourcePath?.stringByAppendingPathComponent("imagecache")
        SDImageCache.sharedImageCache().addReadOnlyCachePath(bundledPath)
        
        if ((UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 8.0) {
            UIApplication.sharedApplication().registerForRemoteNotifications()
            UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes:UIUserNotificationType.Badge|UIUserNotificationType.Sound|UIUserNotificationType.Alert, categories: nil))
        }
        else {
            UIApplication.sharedApplication().registerForRemoteNotificationTypes(.Alert | .Sound | .Badge)
        }
        
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)
        let baidumanager=BMKMapManager()
        baidumanager.start("G4kyw1AfYgltiS0OjoGQ93rE", generalDelegate: nil)
        
        
        
        //微信支付

        WXApi.registerApp("wx2398d00a22c0a31c", withDescription: "乐行宝")
        
        
        //获取DEVICE_UUID
        UserService.sharedUserService.GetDeviceUUID()
        
        
        
        //读取数据
        var data: AnyObject? = CommonUtil.readWithNSUserDefaults("USER")
        
        var datas: AnyObject? = CommonUtil.readWithNSUserDefaults("MSG")
        if(datas != nil){
            Cache.MSGCOUNT = Mapper <MsgCount>().mapArray(JSON(datas!).dictionaryObject)
        }
        
        
        
        
        
        //如果有数据则直接跳转到主界面
        if data != nil {
            
            Cache.USER = Mapper<User>().map(JSON(data!).dictionaryObject)
            
            
            
            if(Cache.USER != nil ){

                if(!Cache.USER.isloginout){
                
                   CommonUtil.getEbickInfo()
                }
                
                if(Cache.USER.appversion == nil){
                    Cache.USER.appversion = Cache.VERSION
                    //保存version
                    CommonUtil.saveWithNSUserDefaults(Mapper().toJSON(Cache.USER), key: "USER")
                }
                
                
                //版本更新
                if( Cache.USER.appversion < Cache.VERSION ){
                    return true
                }
                
            }
            
            
            if(launchOptions != nil){
                //跳消息页
                var sb = UIStoryboard(name: "Main", bundle:nil)
                var view = sb.instantiateViewControllerWithIdentifier("maintab") as? UITabBarController
                view?.selectedIndex=2
                self.window?.rootViewController = view;
                self.window?.makeKeyAndVisible()
                
            }else{
                
                var sb = UIStoryboard(name: "Main", bundle:nil)
                self.window?.rootViewController = sb.instantiateViewControllerWithIdentifier("maintab") as? UIViewController;
                self.window?.makeKeyAndVisible()
                
            }
            
            
            
            
            
        }else{ //无消息 直接跳到欢迎页
            Cache.USER.appversion = Cache.VERSION
            
            //保存version
            CommonUtil.saveWithNSUserDefaults(Mapper().toJSON(Cache.USER), key: "USER")
        
        
        }
        
       
        
        
        
        return true
    }
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        
        
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        
        if(url.description.contains("lexingbox://safepay")){
            AlipaySDK.defaultService().processOrderWithPaymentResult(url, standbyCallback: { (result) -> Void in
                println(result)
            })
        }
        if(url.description.contains("wx2398d00a22c0a31c")){
           WXApi.handleOpenURL(url, delegate: self)
        }
       
        
        return true
    }
    
    
    
    func onResp(resp: BaseResp!) {
        
    }
    
    
    
    
    
    

    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        if ( Cache.USER != nil){
            //建立连接
            WebSocketUtil.sharedWebSocket.connect()
            
            //获取报警数据
            //           CommonUtil.getEventData()
        }
        
        
        
        //        println("我变为前台应用了")
        
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData){
        
        BaseString.DEVICETOKEN = deviceToken.description
        if ( Cache.USER != nil){
            
            Cache.USER.deviceToken = BaseString.DEVICETOKEN
        }
        println(BaseString.DEVICETOKEN)
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        println(error)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        
        CommonUtil.getevents()
        //       UIApplication.sharedApplication().applicationIconBadgeNumber  =  100;
    }
    
    
    func applicationDidReceiveMemoryWarning(application: UIApplication) {
        //        println(application)
    }
    
}

