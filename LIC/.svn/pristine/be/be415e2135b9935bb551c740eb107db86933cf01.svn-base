//
//  EffectTableController.swift
//  LIC
//
//  Created by 温红权 on 15/5/13.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class EffectTableController:BaseTableController{


    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        
        self.navigationItem.title = "伴随效果"
        
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        
        self.tableView.allowsSelection = false
        
        if(BaseString.ISSOUND == 1){
           soundSwitch.on = true
        }else{
           soundSwitch.on = false
        }
        
        if(BaseString.ISSHARK == 1){
            sharkSwitch.on = true
        }else{
            sharkSwitch.on = false
        }
        
        
    }

    @IBOutlet weak var soundSwitch: UISwitch!
    @IBOutlet weak var sharkSwitch: UISwitch!
    @IBAction func soundAction(sender: AnyObject) {
        if(soundSwitch.on){
            BaseString.ISSOUND = 1
        }else{
            BaseString.ISSOUND = 0
        }
        CommonUtil.GCDThread({()in
            
            UserService.sharedUserService.SetSetting()
        }, afterdo: nil)
        
    }
    
    @IBAction func sharkAction(sender: AnyObject) {
        if(sharkSwitch.on){
            BaseString.ISSHARK = 1
        }else{
            BaseString.ISSHARK = 0
        }
        CommonUtil.GCDThread({()in
            
            UserService.sharedUserService.SetSetting()
            }, afterdo: nil)
    }
  
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 15.0
        
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        self.tableView.tableHeaderView = self.tableView.tableHeaderView;
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        
        var headerView = UIView(frame: CGRectMake(0, 0, tableView.bounds.size.width, 15))
        
        
        return headerView;
        
    }

    
}