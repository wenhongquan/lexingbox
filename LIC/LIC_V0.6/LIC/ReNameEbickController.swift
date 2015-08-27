//
//  ReNameEbickController.swift
//  LIC
//
//  Created by 温红权 on 15/4/15.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation


class ReNameEbickController:BaseTableController{

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
        
        ebicknamelable.becomeFirstResponder()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
       
         ebicknamelable.text = Cache.EBICK?.name
        if (self.tableView.indexPathForSelectedRow() != nil){
            tableView.deselectRowAtIndexPath(self.tableView.indexPathForSelectedRow()!, animated: false)
        }
    }
    
    
    @IBOutlet weak var ebicknamelable: UITextField!
    
    
    
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 15
        
    }
    
    func backtomain(){
    
       self.loading?.dismiss()
       
       CommonUtil.transitionWithType(kCATransitionReveal, withSubType: kCATransitionFromBottom, forView: self.view.window!)
        
        self.navigationController?.popViewControllerAnimated(false)
    }
    
    var loading:JGProgressHUD?
    
    func save(sender: UIButton){
        
        if(Cache.EBICK == nil){
           return
        }
        
        var ebick = Ebick()
        ebick.id = Cache.EBICK.id
        ebick.userId = Cache.USER.id
        ebick.name = ebicknamelable.text
        
        GpsService.sharedGpsService.PutEbick({(data)in
        
            if(data["status"].int == StatusCode.SystemSC.SYSTEM_OK){
            
                self.loading =  CommonUtil.alertSuccess(self.navigationController!.view!,title:"成功")
                
                self.loading?.dismissAfterDelay(1200)
                
                NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("backtomain"), userInfo: nil, repeats: false)
                
            
            }
            
            
        
            }, errorHandler: {(data) in
            
            
            }, body: (Mapper().toJSON(ebick)))
        
    }
    
    func clear(sender: UIButton){
        
       
        CommonUtil.transitionWithType(kCATransitionReveal, withSubType: kCATransitionFromBottom, forView: self.view.window!)
        
        self.navigationController?.popViewControllerAnimated(false)
        
    }
    
    
    @IBAction func ebicknameInput(sender: AnyObject) {
        
        if(ebicknamelable.text == ""){
          self.navigationItem.rightBarButtonItem?.enabled = false
        
        }else{
          self.navigationItem.rightBarButtonItem?.enabled = true
        }
        
        var length = 0
        var temp = "";
        for c:Character in ebicknamelable.text {
            
            if((++length) <= 8){
                temp.append(c)
            }
        }
        
        if(length > 8){
          ebicknamelable.text = temp
        
        }
        

        
        
        
    }

    func initUI(){
        
        CommonUtil.setNavigationControllerBackground(self)
        
        self.navigationItem.leftItemsSupplementBackButton = false
        
        self.tableView.scrollEnabled = true
        
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
        
        self.navigationItem.rightBarButtonItem?.enabled = true
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        
        
        
        var item1 = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "clear:")
        item1.tintColor = UIColor.whiteColor()
        self.navigationItem.setLeftBarButtonItems([item1], animated: false)
        
        
        self.navigationItem.title = "电动车名称"
        
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        
        
        self.tableView.allowsSelection = false
        self.tableView.scrollEnabled = true
    }

}