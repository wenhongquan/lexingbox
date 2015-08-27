//
//  SettingAboutController.swift
//  LIC
//
//  Created by 温红权 on 15/3/13.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import UIKit

class SettingAboutController: BaseTableController {
    
    @IBOutlet weak var fontView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initUI();
    }
    
    
    @IBAction func userdelegateAction(sender: AnyObject) {
        
        CommonUtil.backToWebView(self, name: "webviewcontroller", title: "服务条款", url: BaseString.HTTPADDR+"faq/202001.html")

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 44
        
    }
  
    override func viewDidLayoutSubviews() {
        
        
        
        fontView.frame.size.height = self.view.frame.height - 150 - 45 * 3 - 10
    }
    
    
    override func viewDidAppear(animated: Bool) {
        self.tableView.tableHeaderView =  self.tableView.tableHeaderView
        self.tableView.tableFooterView =  self.tableView.tableFooterView
    }
    
    
    func initUI(){
        
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        
        self.navigationItem.title = "关于乐行宝"
        
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch(indexPath.section){
            
        case 0:
            switch indexPath.row {
                // 欢迎页
            case 0:
                
                
                var sb = UIStoryboard(name: "Main", bundle:nil)
                
                var vc = sb.instantiateViewControllerWithIdentifier("launchView") as! launchview
                vc.type = 2
                
                CommonUtil.transitionWithType(kCATransitionFade, withSubType: kCATransitionFromLeft, forView: self.view.window!)
                
                
                self.presentViewController(vc, animated: false, completion: nil)
                
                break
                // 常见问题
            case 1:
                CommonUtil.backToWebView(self, name: "webviewcontroller", title: "常见问题", url:BaseString.HTTPADDR+"faq")
                //                 CommonUtil.backToWebView(self, name: "webviewcontroller", title: "常见问题", url:"http://lwc.91lexing.com/service/me")
                
                break
                // 吐槽产品经理
            case 2:
                CommonUtil.navToView(self, name: "liuyanviewcontroller")
                break
            default: break
                
            }
            
            break
               default :
            break
        }
        
        
        
        
    }

    
}
