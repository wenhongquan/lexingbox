//
//  SettingTableController.swift
//  LIC
//
//  Created by 温红权 on 15/3/13.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import UIKit
//import ObjectMapper

class SettingTableController: BaseTableController  {
    
    @IBOutlet var table: UITableView!
    
    @IBOutlet weak var usercount: UITableViewCell!
    
    @IBOutlet weak var updatePwdCell: UITableViewCell!
    
    // 0--未登录  1--已登录未连接  2--已登录已连接
    var viewstatus = 0
    
    
    
    
    
    
    
    
    
    @IBOutlet weak var usercountLable: UILabel!
    @IBOutlet weak var usercountLoginLable: UILabel!
    @IBOutlet weak var usercountbackArrowPic: UIImageView!
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        CommonUtil.setNavigationControllerBackground(self)
        
        var rightbar = UIBarButtonItem(image: UIImage(named: "customer_service"), style: UIBarButtonItemStyle.Plain, target: self, action: "customerService")
        
       rightbar.imageInsets = UIEdgeInsets(top: 0, left: -7, bottom: 0, right: 7)
        
        self.navigationItem.title = "更多"

        
        self.navigationItem.setRightBarButtonItem(rightbar, animated: false)
        
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
        
        chageViewStatus(2)
        
        
    }
    
    /**
    改变更多页面状态
    
    :param: status 0--未登录 1--登录未连接 2--登录已连接
    */
    func chageViewStatus(status:Int){
    
        if(status == 0){
            usercount.selectionStyle = UITableViewCellSelectionStyle.Default
            usercountLable.text = Cache.USER.phone
            usercountLable.hidden = true
            usercountLoginLable.hidden = false
            usercountbackArrowPic.hidden = false
            
        }else{
            usercount.selectionStyle = UITableViewCellSelectionStyle.None
            usercountLable.text = Cache.USER.phone
            usercountLable.hidden = false
            usercountLoginLable.hidden = true
            usercountbackArrowPic.hidden = true
        
        }
        
        
        self.viewstatus = status
        self.tableView.reloadData()
    }
    
    
    
    

  
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section){
            //我的账号
            case 0:
                switch(viewstatus){
                case 0:
                    return 1
                case 1:
                    return 2
                case 2:
                    return 2
                default:
                    break
            }
            //效果
            case 1:
                switch(viewstatus){
                case 0:
                    return 0
                case 1:
                    return 0
                case 2:
                    return 1
                default:
                    break
                }
            //我的红包
            case 2:
                switch(viewstatus){
                case 0:
                    return 1
                case 1:
                    return 3
                case 2:
                    return 3
                default:
                    break
                }
            
            //关于
            case 3:
                return 2
            
            //退出
            case 4:
                switch(viewstatus){
                case 0:
                    return 0
                case 1:
                    return 1
                case 2:
                    return 1
                default:
                    break
            }
           
            default:
            break
        
        }
        return 0
    }
    
    
  
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch(section){
        case 0:
            return 15
        case 1:
            switch(viewstatus){
            case 0:
                 break
            case 1:
                 break
            case 2:
                return 20
            default:
                break
            }
        case 2:
            return 20
        case 3:
            return 20
        case 4:
            return 30
        default:
            break
            
        }
        return CGFloat.min
        
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
      
        return CGFloat.min
    }
    

    func customerService(){
        
        CommonUtil.alertCustomService(self)
    }
    
   
        
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        self.navigationItem.backBarButtonItem =  nil
        
        
        if(Cache.USER == nil || Cache.USER.isloginout){
           chageViewStatus(0)
        }else{
        
            if(Cache.EBICK != nil && Cache.EBICK.gpsId != nil){
                chageViewStatus(2)
            }else{
                chageViewStatus(1)
            }
        }
        
        
        
        
    }
    
    
    
    
    override func webSocketMessageHandler(message: String) {
        if(message.contains("msg")){
            var data:JSON = JSON(data:(message as NSString).dataUsingEncoding(NSUTF8StringEncoding)! )
            
            CommonUtil.GCDThread({()in
                //这里写需要放到子线程做的耗时的代码
                CommonUtil.getevents()
                
                }, afterdo:  nil)
            
            
        }
    }
    
    
    
    
    
    
      // 0--未登录  1--已登录未连接  2--已登录已连接
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch(indexPath.section){
        
        //我的账号
        case 0:
            
            if( indexPath.row == 0 && self.viewstatus == 0 ) {
                
                var sb = UIStoryboard(name: "Main", bundle:nil)
                var vc = sb.instantiateViewControllerWithIdentifier("loginView") as!  LoginController
                vc.hidesBottomBarWhenPushed = true
                CommonUtil.transitionWithType(kCATransitionMoveIn, withSubType: kCATransitionFromTop, forView: self.view.window!)
                self.navigationController?.pushViewController(vc, animated: false)
                
                break
            }
            
            //修改密码
            if( indexPath.row == 1 ) {
                
                  CommonUtil.navToView(self, name: "repasswordviewController")
            }
            break
            
        //伴随效果
        case 1:
            //伴随效果
        CommonUtil.navToView(self, name: "effectTableController")
        break
           
            
        case 2:
            switch indexPath.row {
            case 0:
                var sb = UIStoryboard(name: "Main", bundle:nil)
                
                var vc = sb.instantiateViewControllerWithIdentifier("ebickBrandManageTabbarController") as!  EbickBrandManageTabbarController
                
                vc.hidesBottomBarWhenPushed = true
                
                self.navigationController?.pushViewController(vc, animated: true)

                break
            case 1:
                
                var sb = UIStoryboard(name: "Main", bundle:nil)
                
                var vc = sb.instantiateViewControllerWithIdentifier("myRedEnvelopeTableController") as!  MyRedEnvelopeTableController
                
                vc.hidesBottomBarWhenPushed = true
                
                self.navigationController?.pushViewController(vc, animated: true)
                
            break
            case 2:
                
                var sb = UIStoryboard(name: "Main", bundle:nil)
                
                var vc = sb.instantiateViewControllerWithIdentifier("myOrderTableController") as!  MyOrderTableController
                
                vc.hidesBottomBarWhenPushed = true
                
                self.navigationController?.pushViewController(vc, animated: true)
               
            
            break
                
            
            default: break
                
            }
            
            
            
            break
        //关于
        case 3:
            
            switch indexPath.row {
            // 关于乐行宝
            case 1:
                 CommonUtil.navToView(self, name: "aboutviewcontroller")
                break
            // 离线地图
            case 0:
                CommonUtil.navToView(self, name: "offlineMapTab")
                break
            default: break
            }
            
            break
        
            
        case 4:
            //退出
            if( indexPath.row == 0 ) {
                
                if (UIDevice.currentDevice().userInterfaceIdiom == .Phone) {
                    
                   if ((UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 8.0)  {
                    
                    let shareMenu = UIAlertController(title: nil, message: "退出后不会删除任何历史数据，下次登录依然可以使用本账号。", preferredStyle: .ActionSheet)
                    
                    let loginout = UIAlertAction(title: "退出登录", style: .Destructive ) { (_) in
                        
                        self.loginout()
                        
                    }
                    let cancelAction = UIAlertAction(title: "取消", style: .Cancel) { (_) in }
                    
                    shareMenu.addAction(loginout)
                    shareMenu.addAction(cancelAction)
                    
                    shareMenu.view.tintColor=UIColor.darkGrayColor()
                    
                    
                    self.presentViewController(shareMenu, animated: true, completion: nil)
                    
                   
                   }else{
                    

                    let shareMenu = UIActionSheetExt(title: "退出后不会删除任何历史数据，下次登录依然可以使用本账号。", delegate: IosActionSheetDegetel.sharedIosActionSheetDegetel, cancelButtonTitle: "取消", destructiveButtonTitle: "退出登录")
                    
                    shareMenu.tag = StatusCode.ActionSheetSC.LOGINOUT
                    
                    shareMenu.handles?.append({()in
                        self.loginout()
                    })
                    
                    shareMenu.showFromTabBar(self.tabBarController?.tabBar)
                    
                    
                    
                    }
                    
                    
                
                
                }else {
  
                    CommonUtil.alertView(self, title: "", message: "退出后不会删除任何历史数据，下次登录依然可以使用本账号。", buttons: [AlertHandler(title: "确定", handle: { () -> Void in
                         self.loginout()

                    }),AlertHandler(title: "取消", handle: {})])

                    
                    
                    
                }
                
                
                
                
                var timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("unselectCurrentRow"), userInfo: nil, repeats: false)
            }
            break

         default :
            break
        }
        
        
        
        
    }
    
 
 
    
    
    
    
    func unselectCurrentRow(){
        self.tableView.deselectRowAtIndexPath(self.tableView.indexPathForSelectedRow()!,animated:true);
        
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
        
       // self.backLaunch()
        chageViewStatus(0)

    
    }
    
    
//    func backLaunch(){
//        
//        CommonUtil.backToView(self, name: "navlogin", type:kCATransitionMoveIn, subtype: kCATransitionFromTop)
//        
//        return
//        
//        
//    }

    
    
    
    
    
}
