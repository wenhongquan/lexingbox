//
//  NotAuditViewController.swift
//  LIC
//
//  Created by 温红权 on 15/6/17.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class NotAuditViewController:BaseController{
    
    @IBOutlet weak var topSpace: NSLayoutConstraint!
    @IBOutlet weak var addEbickBrandButton: UIViewTouchView!
    weak var tableControl:NotAuditTableViewController!
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initItem();
    }
    
    override func getevents() {
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableControl.refresh()
    }
    
    func initItem(){
        
        
        self.title = "未审核"
        self.tabBarItem.setTitleTextAttributes([NSFontAttributeName : UIFont.systemFontOfSize(17.0)], forState: UIControlState.Normal)
        self.tabBarItem.setTitlePositionAdjustment(UIOffsetMake(0.0, -15.0))
        
        self.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName : UIColorFromRGB(0x2bcd9c)], forState: UIControlState.Selected)
        
    }
    override func viewDidLoad() {
        topSpace.constant =  self.tabBarController!.tabBar.frame.height
        addEbickBrandButton.clickevnt = { () in
            
            
            var sb = UIStoryboard(name: "Main", bundle:nil)
            
            var vc = sb.instantiateViewControllerWithIdentifier("ebickBrandAddTableController") as!  EbickBrandAddTableController
            
            vc.hidesBottomBarWhenPushed = true
            
            CommonUtil.transitionWithType(kCATransitionMoveIn, withSubType: kCATransitionFromTop, forView: self.view.window!)
            self.navigationController?.pushViewController(vc, animated: false)
            
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "NotAuditViewIDF") {
            tableControl = segue.destinationViewController as! NotAuditTableViewController
        }
    }

}