//
//  EbickInfoTableInfoController.swift
//  LIC
//
//  Created by 温红权 on 15/4/15.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class EbickInfoTableInfoController:BaseTableController{

    
    override func viewDidLoad() {
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        
        self.navigationItem.title = "电动车信息"
        
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        
        
        self.tableView.allowsSelection = true
        self.tableView.scrollEnabled = true
        
        CommonUtil.getEbickInfo()
        
    }
    @IBOutlet weak var ebicknamelable: UILabel!
    
    
    override func webSocketMessageHandler(message: String) {
        if( NSString(string: message).containsString("ebike") || NSString(string: message).containsString("realtimeTrajector")){
            
            CommonUtil.getEbickInfo()
        }
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
    }
    func refreshUI(){
       ebicknamelable.text = Cache.EBICK?.name
    
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshUI()
        CommonUtil.getEbickInfo()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshUI", name: "getebickinfo", object: nil)
        
        if (self.tableView.indexPathForSelectedRow() != nil){
                tableView.deselectRowAtIndexPath(self.tableView.indexPathForSelectedRow()!, animated: false)
        }
        
    }

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 15
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch(indexPath.section){
            
        case 0:
       
            if( indexPath.row == 0 ) {
                
                var sb = UIStoryboard(name: "Main", bundle:nil)
                
                var vc = sb.instantiateViewControllerWithIdentifier("renameEbickController") as!  ReNameEbickController
                
                vc.hidesBottomBarWhenPushed = true
                
                CommonUtil.transitionWithType(kCATransitionMoveIn, withSubType: kCATransitionFromTop, forView: self.view.window!)
                self.navigationController?.pushViewController(vc, animated: false)
                
                
                
            }
            break
        default:break;
        }
    }

}