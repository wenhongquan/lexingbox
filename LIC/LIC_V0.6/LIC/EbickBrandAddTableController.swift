//
//  EbickBrandAddTableController.swift
//  LIC
//
//  Created by 温红权 on 15/5/28.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation


struct EbickBrandAddTableData {
    static var EbickBrandLocation:EbickbusinessAddr = EbickbusinessAddr()
}

class EbickBrandAddTableController:BaseTableController,UITextFieldDelegate{
    
    
    @IBOutlet weak var areaButton: UIButton!
    @IBOutlet weak var telphoneTextFiled: UITextField!
    @IBOutlet weak var nameTextFiled: UITextField!
    
    
    var pageType = 0;
    var business:Business?
    
    
    var phone = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        nameTextFiled.delegate = self
    }
    @IBAction func phoneInput(sender: AnyObject) {
        
        telphoneTextFiled.text = CommonUtil.validateNumber(telphoneTextFiled.text,limit:11)
        
        phone = telphoneTextFiled.text
        
        check()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var length = 0
        var temp = "";
        for c:Character in nameTextFiled.text {
            
            if((++length) < 20){
                temp.append(c)
            }
        }
        
        
        if(length>20) {
            
            nameTextFiled.text = temp
            return false
            
        }else{
            return true
        }
    }
    
    @IBAction func nameInput(sender: AnyObject) {
        
        check()
    }
    
    func check(){
        if((phone as NSString).length>=11 && nameTextFiled.text != "" && areaButton.titleLabel?.text != "地区信息" && EbickBrandAddTableData.EbickBrandLocation.address != nil && EbickBrandAddTableData.EbickBrandLocation.address != ""){
            
            EbickBrandAddTableData.EbickBrandLocation.telephone = phone
            EbickBrandAddTableData.EbickBrandLocation.name  = nameTextFiled.text
            
            
            self.navigationItem.rightBarButtonItem?.enabled = true
        }else{
            self.navigationItem.rightBarButtonItem?.enabled = false
        }
        
    }
    
    @IBAction func areaAction(sender: AnyObject) {
        
        self.view.endEditing(true)
        
        var views = UIView.loadFromNibNamedView("AreaSelectView", bundle: nil) as! AreaSelectView
        views.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        views.selecdAction = { (province:String,city:String,area:String,addr:String) in
            self.areaButton.setTitle(addr, forState: UIControlState.Normal)
            self.areaButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            
            EbickBrandAddTableData.EbickBrandLocation.province = province
            EbickBrandAddTableData.EbickBrandLocation.city = city
            EbickBrandAddTableData.EbickBrandLocation.area = area
            
        }
        views.clearAction = {()in
            
            if(self.areaButton.titleLabel?.text == "地区信息"){
                
                self.areaButton.setTitleColor(CommonUtil.UIColorFromRGB(0xc7c7cd), forState: UIControlState.Normal)
                self.check()
            }
            
        }
        
        self.view.addSubview(views)
        self.view.bringSubviewToFront(views)
    }
    
    @IBOutlet weak var locationButton: UIButton!
    
    @IBAction func locationButtonAction(sender: AnyObject) {
        self.view.endEditing(true)
        var sb = UIStoryboard(name: "Main", bundle:nil)
        
        var vc = sb.instantiateViewControllerWithIdentifier("areaSelectMapViewController") as!  AreaSelectMapViewController
        
        vc.hidesBottomBarWhenPushed = true
        
        CommonUtil.transitionWithType(kCATransitionMoveIn, withSubType: kCATransitionFromTop, forView: self.view.window!)
        self.navigationController?.pushViewController(vc, animated: false)
        
    }
    
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 15
    }
    
    
    func initUI(){
        
        CommonUtil.setNavigationControllerBackground(self)
        
        self.navigationItem.leftItemsSupplementBackButton = false
        
        self.tableView.scrollEnabled = true
        
        
        if(business == nil){
            
            var button = UIButton()
            
            button.frame = CGRectMake(0.0, 2.0,40, 34);
            button.titleLabel?.textAlignment = NSTextAlignment.Right
            button.addTarget(self, action: "submit", forControlEvents: UIControlEvents.TouchUpInside)
            button.setTitle("完成", forState: UIControlState.Normal)
            button.titleLabel?.font = UIFont.systemFontOfSize(17)
            button.setTitleColor(CommonUtil.UIColorFromRGB(0x01624b), forState: UIControlState.Disabled)
            button.setTitleColor(CommonUtil.UIColorFromRGB(0x2bcd9c), forState: UIControlState.Normal)
            button.setTitleColor(CommonUtil.UIColorFromRGB(0x01624b), forState: UIControlState.Selected)
            button.setTitleColor(CommonUtil.UIColorFromRGB(0x01624b), forState: UIControlState.Highlighted)
            var baritem = UIBarButtonItem(customView: button)
            self.navigationItem.rightBarButtonItem = baritem
            self.navigationItem.rightBarButtonItem?.enabled = false
        }else{
            
            EbickBrandAddTableData.EbickBrandLocation.address = business?.address
            EbickBrandAddTableData.EbickBrandLocation.area = business?.area
            EbickBrandAddTableData.EbickBrandLocation.province = business?.province
            EbickBrandAddTableData.EbickBrandLocation.telephone = business?.telephone
            EbickBrandAddTableData.EbickBrandLocation.name = business?.name
            EbickBrandAddTableData.EbickBrandLocation.city = business?.city
            EbickBrandAddTableData.EbickBrandLocation.id = business?.id
            phone = (business?.telephone == nil ? "" : business!.telephone!)
            
            
            areaButton.setTitle(getarea(business?.province, city: business?.city, area: business?.area), forState: UIControlState.Normal)
            self.areaButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            telphoneTextFiled.text = business?.telephone
            nameTextFiled.text = business?.name
            locationButton.setTitle(business?.address, forState:  UIControlState.Normal)
            self.locationButton.setTitleColor(CommonUtil.UIColorFromRGB(0x000000), forState: UIControlState.Normal)
            
            if(pageType == 3){
                
                var button = UIButton()
                button.frame = CGRectMake(0.0, 2.0,80, 34);
                button.titleLabel?.textAlignment = NSTextAlignment.Right
                button.addTarget(self, action: "submit", forControlEvents: UIControlEvents.TouchUpInside)
                button.setTitle("重新提交", forState: UIControlState.Normal)
                button.titleLabel?.font = UIFont.systemFontOfSize(17)
                button.setTitleColor(CommonUtil.UIColorFromRGB(0x01624b), forState: UIControlState.Disabled)
                button.setTitleColor(CommonUtil.UIColorFromRGB(0x2bcd9c), forState: UIControlState.Normal)
                button.setTitleColor(CommonUtil.UIColorFromRGB(0x01624b), forState: UIControlState.Selected)
                button.setTitleColor(CommonUtil.UIColorFromRGB(0x01624b), forState: UIControlState.Highlighted)
                var baritem = UIBarButtonItem(customView: button)
                self.navigationItem.rightBarButtonItem = baritem
                self.navigationItem.rightBarButtonItem?.enabled = true
                
                var waringView = UIView.loadFromNibNamedView("NotAccessErrorView", bundle: nil) as! NotAccessErrorView
                
                var texts:String? = CommonUtil.StringLimt(13, string: "未通过的原因：" + (business?.refuseReason == nil ? "" :business!.refuseReason! ))
                
                waringView.warningLable.text = texts
                
                waringView.detailButton=CommonUtil.buttonSetImage(waringView.detailButton,name:"errorbtnnormal",states:[UIControlState.Selected,UIControlState.Normal,UIControlState.Highlighted])
                waringView.clickEvent = {
                    if(self.business?.refuseReason != nil){
                        CommonUtil.alertView(self, title: self.business!.refuseReason!, message:"" , buttons: [AlertHandler(title: "确定", handle: { () -> Void in
                            
                        })])
                    }
                    
                }
                
                waringView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
                waringView.backgroundColor = CommonUtil.UIColorFromRGB(0xFFDEDE)
                
               
                
                self.tableView.tableHeaderView = waringView
                self.tableView.tableHeaderView =  self.tableView.tableHeaderView
                
                
            }
        }
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        var item1 = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "clear:")
        item1.tintColor = UIColor.whiteColor()
        self.navigationItem.setLeftBarButtonItems([item1], animated: false)
        
        
        self.navigationItem.title = "商户标注"
        
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        
        
        self.tableView.allowsSelection = false
        self.tableView.scrollEnabled = false
        
        
    }
    
    func getarea(province:String?,city:String?,area:String?) -> String {
        
        var areas = ""
        
        areas = areas + (province == nil ? "" : province!)
        
        if(province == city ){
            
            if(city != area){
                areas = areas + (area == nil ? "" : (areas == "" ? area! : " "+area!))
            }
        }else{
            
            areas = areas + (city == nil ? "" : (areas == "" ? city! : " "+city!))
            
            if(city != area){
                areas = areas + (area == nil ? "" : (areas == "" ? area! : " "+area!))
            }
            
        }
        
        return areas
        
    }
    
    func clear(sender: UIButton){
        
        CommonUtil.transitionWithType(kCATransitionReveal, withSubType: kCATransitionFromBottom, forView: self.view.window!)
        
        self.navigationController?.popViewControllerAnimated(false)
        
    }
    
    var loading:JGProgressHUD?
    
    func submit(){
        
        
        CommonUtil.GCDThread({ () -> Void in
            
            if(self.pageType == 3){
                GpsService.sharedGpsService.ADDEbickBrand({ (data) -> Void in
                    
                    
                    if(data["status"].int == StatusCode.SystemSC.SYSTEM_OK){
                        self.loading =  CommonUtil.alertSuccess(self.navigationController!.view!,title:"提交成功等待审核")
                        
                        self.loading?.dismissAfterDelay(1200)
                        
                        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("backtomain"), userInfo: nil, repeats: false)
                        
                    }
                    
                    
                    }, errorHandler: { (data) -> Void in
                        
                    }, body: (Mapper().toJSON(EbickBrandAddTableData.EbickBrandLocation)))

            
            }else{
            
            
            GpsService.sharedGpsService.ADDEbickBrand({ (data) -> Void in
                
                
                if(data["status"].int == StatusCode.SystemSC.SYSTEM_OK){
                    self.loading =  CommonUtil.alertSuccess(self.navigationController!.view!,title:"提交成功等待审核")
                    
                    self.loading?.dismissAfterDelay(1200)
                    
                    NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("backtomain"), userInfo: nil, repeats: false)
                    
                }
                
                
                }, errorHandler: { (data) -> Void in
                    
                }, body: (Mapper().toJSON(EbickBrandAddTableData.EbickBrandLocation)))
            
            }
            
            }, afterdo: nil)
    
    }
    
    func backtomain(){
        
        self.loading?.dismissAnimated(false)
        self.loading?.dismiss()
        
        CommonUtil.transitionWithType(kCATransitionReveal, withSubType: kCATransitionFromBottom, forView: self.view.window!)
        
        self.navigationController?.popViewControllerAnimated(false)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if(EbickBrandAddTableData.EbickBrandLocation.address != nil && EbickBrandAddTableData.EbickBrandLocation.address != ""){
            locationButton.setTitle(EbickBrandAddTableData.EbickBrandLocation.address, forState: UIControlState.Normal)
            self.locationButton.setTitleColor(CommonUtil.UIColorFromRGB(0x000000), forState: UIControlState.Normal)
            self.check()
            self.view.endEditing(true)
        }else{
            locationButton.setTitle("请设置详细地址", forState: UIControlState.Normal)
            self.locationButton.setTitleColor(CommonUtil.UIColorFromRGB(0xc7c7cd), forState: UIControlState.Normal)
            
        }
        
    }
    
    
    
    
}