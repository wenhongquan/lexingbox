//
//  DeviceInfoController.swift
//  LIC
//
//  Created by 温红权 on 15/4/13.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation
import AssetsLibrary


class DeviceInfoController: BaseTableController {
    
    @IBOutlet weak var qrImage: UIImageView!
    @IBOutlet weak var linestatuslable: UILabel!
    @IBOutlet weak var lexingcodelable: UILabel!
    @IBOutlet weak var simlable: UILabel!
    
    @IBOutlet weak var remove: UIButton!
    @IBOutlet weak var imageViews: UIView!
    
    
    @IBOutlet weak var gpsStatusCell: UITableViewCell!
    
    @IBOutlet weak var lexingCodeCell: UITableViewCell!
    
    @IBOutlet weak var SimCell: UITableViewCell!
    
    @IBOutlet weak var accCell: UITableViewCell!
    override func viewDidLoad() {
        
        
        var button = UIButton()
        
        button.frame = CGRectMake(0.0, 2.0,40, 34);
        button.titleLabel?.textAlignment = NSTextAlignment.Right
        button.addTarget(self, action: "save:", forControlEvents: UIControlEvents.TouchUpInside)
        button.setTitle("保存", forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(17)
        button.setTitleColor(CommonUtil.UIColorFromRGB(0x01624b), forState: UIControlState.Disabled)
        button.setTitleColor(CommonUtil.UIColorFromRGB(0x2bcd9c), forState: UIControlState.Normal)
        button.setTitleColor(CommonUtil.UIColorFromRGB(0x01624b), forState: UIControlState.Selected)
        button.setTitleColor(CommonUtil.UIColorFromRGB(0x01624b), forState: UIControlState.Highlighted)
        
        //        button.enabled = false
        
        var baritem = UIBarButtonItem(customView: button)
        
        self.navigationItem.rightBarButtonItem = baritem
        
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        
        remove = CommonUtil.buttonSetImage(remove, name: "remove_devicebtn", states: [UIControlState.Normal,UIControlState.Selected,UIControlState.Highlighted])
        remove.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
        remove.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        
        
        self.navigationItem.title = "设备信息"
        
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        
        
        gpsStatusCell.selectionStyle = UITableViewCellSelectionStyle.None
        lexingCodeCell.selectionStyle = UITableViewCellSelectionStyle.None
        SimCell.selectionStyle = UITableViewCellSelectionStyle.None
        accCell.hidden = true
        
//        self.tableView.allowsSelection = false
        self.tableView.scrollEnabled = true
        
        
        imageViews.addLeftBorderWithWidth(3, color: UIColor.blackColor())
        imageViews.addRightBorderWithWidth(3, color: UIColor.blackColor())
        imageViews.addTopBorderWithHeight(3, color: UIColor.blackColor())
        imageViews.addBottomBorderWithHeight(3, color: UIColor.blackColor())
        qrImage.image = {
            var qrCode = QRCode("sdfgbdfghsrdefthgswdfhsadefhsdefhsawdefhrsdfhsdewfthawedhswdgfhsedghswdehgsderthsderth")!
            qrCode.size = self.qrImage.bounds.size
            qrCode.color = CIColor(rgba: "000000")
            qrCode.backgroundColor = CIColor(rgba: "ffffff")
            return qrCode.image
            }()

    }
    
    
    
    func refreshUI(){
        
        if(Cache.GPSINFO != nil){
            qrImage.image = {
                var qrCode = QRCode(Cache.GPSINFO.qrCode!)!
                qrCode.size = self.qrImage.bounds.size
                qrCode.color = CIColor(rgba: "000000")
                qrCode.backgroundColor = CIColor(rgba: "ffffff")
                return qrCode.image
                }()
            
            if(Cache.GPSINFO.status == 1){
              linestatuslable.text = "在线"
            }else{
              linestatuslable.text = "离线"
            }
            
            lexingcodelable.text = Cache.GPSINFO.lexingCode
            
            simlable.text = Cache.GPSINFO.simNo
            
            if(Cache.GPSINFO.accessAccFlag == nil || Cache.GPSINFO.accessAccFlag != 1){
                accCell.hidden=false
 
            }else{
                accCell.hidden=true
            }
            
        }
        
    
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
         refreshUI()

         NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshUI", name: "getGpsInfo", object: nil)
        
        
        CommonUtil.getGpsInfo()
        
        if (self.tableView.indexPathForSelectedRow() != nil){
            tableView.deselectRowAtIndexPath(self.tableView.indexPathForSelectedRow()!, animated: false)
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
  
            return 3

    }
    
    func backtomain(){
        
        self.loading?.dismiss()
        
        CommonUtil.transitionWithType(kCATransitionReveal, withSubType: kCATransitionFromBottom, forView: self.view.window!)
        
        self.navigationController?.popViewControllerAnimated(false)
    }
    
    var loading:JGProgressHUD?
    
    
    func removeDevice(pass:String){
    
        if(pass == Cache.USER.password){
        
            GpsService.sharedGpsService.PutEbickUNCONN({(data)in
                
                if(data["status"].int == StatusCode.SystemSC.SYSTEM_OK){
                    
                    self.loading =  CommonUtil.alertSuccess(self.navigationController!.view!,title:"成功")
                    
                    self.loading?.dismissAfterDelay(1200)
                    
                    NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("backtomain"), userInfo: nil, repeats: false)
                    
                    
                }
                
                
                
                }, errorHandler: {(data) in
                    
                    
                },ebicId:Cache.EBICK.id )
        
        }else{
        
        CommonUtil.alertView(self, title: "删除设备失败", message: "密码错误", buttons: [AlertHandler(title: "确定", handle: {})])
        
        }
    
    }
    
    @IBAction func deletedeviceAction(sender: AnyObject) {
        if ((UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 8.0){
        
            let alertController = UIAlertController(title: "删除乐行宝设备", message: "删除后，你的电动车不再处于监控状态，请输入你的登陆密码。", preferredStyle: .Alert)
            
            let removebtn = UIAlertAction(title: "确定", style: .Default) { (_) in
                
                let passwordTextField = alertController.textFields![0] as! UITextField
                
                self.removeDevice(passwordTextField.text)
            }
            removebtn.enabled = false
            
            
            let cancelAction = UIAlertAction(title: "取消", style: .Cancel) { (_) in }
            
            alertController.addTextFieldWithConfigurationHandler { (textField) in
                textField.placeholder = "请输入登录密码"
                textField.secureTextEntry = true
                NSNotificationCenter.defaultCenter().addObserverForName(UITextFieldTextDidChangeNotification, object: textField, queue: NSOperationQueue.mainQueue()) { (notification) in
                    removebtn.enabled = textField.text != ""
                }
            }
            
            
            alertController.addAction(removebtn)
            alertController.addAction(cancelAction)
            
            self.presentViewController(alertController, animated: true) {
                
                
            }

        
        }else{
        
            let alertView =  UIAlertViewExt(title: "删除乐行宝设备", message: "删除后，你的电动车不再处于监控状态，请输入你的登陆密码。", delegate: IosActionSheetDegetel.sharedIosActionSheetDegetel, cancelButtonTitle: nil, otherButtonTitles:"确定","取消")
    
           alertView.alertViewStyle = UIAlertViewStyle.SecureTextInput;
            
           alertView.textFieldAtIndex(0)?.placeholder = "请输入登录密码"
        
            alertView.handles?.append({()in
                
                let passwordTextField =  alertView.textFieldAtIndex(0)
                
                self.removeDevice(passwordTextField!.text)
            
            })
            
           alertView.show()
            
            
            
            
            
            
        
        }
        

    }
    
    
    func save(sender: UIButton){
    
        
        if ((UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 8.0){
        
            let shareMenu = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
            
            let savetomobile = UIAlertAction(title: "保存二维码至手机", style: .Default ) { (_) in
               
                
                CommonUtil.imageWithView(self.imageViews)
                
                CommonUtil.alertSuccess(self.navigationController!.view!,title:"成功").dismissAfterDelay(3)
                
                return
            }
            let cancelAction = UIAlertAction(title: "取消", style: .Cancel) { (_) in }
            
            shareMenu.addAction(savetomobile)
            
            shareMenu.addAction(cancelAction)
            
            shareMenu.view.tintColor=UIColor.darkGrayColor()
            
            shareMenu.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.allZeros
            
            shareMenu.popoverPresentationController?.sourceView = self.view
            shareMenu.popoverPresentationController?.sourceRect = CGRectMake((self.view.frame.size.width*0.5), (self.view.frame.size.height*0.5), 0, 0);// 显示在中心位置
            
            
            self.presentViewController(shareMenu, animated: true, completion: nil)
            
        }else{
        
            let shareMenu = UIActionSheetExt(title: nil, delegate: IosActionSheetDegetel.sharedIosActionSheetDegetel, cancelButtonTitle: nil, destructiveButtonTitle: nil, otherButtonTitles: "保存二维码至手机","取消")
            
            shareMenu.tag = StatusCode.ActionSheetSC.TEL
            shareMenu.cancelButtonIndex = 1
            shareMenu.handles?.append({()in
                CommonUtil.imageWithView(self.imageViews)
                
                CommonUtil.alertSuccess(self.navigationController!.view!,title:"成功").dismissAfterDelay(3)
            })
            
            if(self.tabBarController != nil){
                shareMenu.showFromTabBar(self.tabBarController?.tabBar)
            }else{
                shareMenu.showInView(self.view)
            }

        
        }
    
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if(indexPath.row == 3){
        
            var sb = UIStoryboard(name: "Main", bundle:nil)
            
            var vc = sb.instantiateViewControllerWithIdentifier("aCCController") as!  ACCController
            
            vc.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(vc, animated: true)

        
        }
      
        
        
        
        
        
        
    }

    
    
    

}