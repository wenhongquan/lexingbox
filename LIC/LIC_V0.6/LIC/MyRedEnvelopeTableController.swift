//
//  MyRedEnvelopeTableController.swift
//  LIC
//
//  Created by 温红权 on 15/7/21.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation


class MyRedEnvelopeTableController:BaseTableController{


    override func viewDidLoad() {
        super.viewDidLoad()
        CommonUtil.setNavigationControllerBackground(self)
        self.navigationItem.title = "我的红包"
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
     var redEnvelopes:[Int] = [1,1,1]
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return redEnvelopes.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 110
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("redEnvelopetableCell") as! RedEnvelopetableCell

        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
        
    }

    
}