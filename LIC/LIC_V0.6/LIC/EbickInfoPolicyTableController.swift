//
//  EbickInfoPolicyTableController.swift
//  LIC
//
//  Created by 温红权 on 15/4/15.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class EbickInfoPolicyTableController :BaseTableController{

    override func viewDidLoad() {
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        
        self.navigationItem.title = "电动车信息"
        
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        
        
        self.tableView.allowsSelection = true
        self.tableView.scrollEnabled = true
    }
    
    @IBOutlet weak var ebickNamelable: UILabel!
    
    @IBOutlet weak var ebickoutTimeLable: UILabel!
    @IBOutlet weak var ebickmotorNolable: UILabel!
    @IBOutlet weak var ebickcodelable: UILabel!
    @IBOutlet weak var ebickmodellable: UILabel!
    @IBOutlet weak var ebickColorLable: UILabel!
    @IBOutlet weak var ebickLogolable: UILabel!
    
    @IBOutlet weak var insuranceName: UILabel!
    @IBOutlet weak var insuranceCodelable: UILabel!
    @IBOutlet weak var insuranceStartTimeLable: UILabel!
    @IBOutlet weak var insuranceEndTimelable: UILabel!
    
    override func webSocketMessageHandler(message: String) {
        if( message.contains("ebike") || message.contains("realtimeTrajector")){
            
            CommonUtil.getEbickInfo()
        }
        
    }
    
    func refreshUI(){
        ebickNamelable.text = Cache.EBICK?.name
        
        ebickoutTimeLable.text = CommonUtil.FloatToDate(Cache.EBICK.insurance?.insuranceEbike?.factoryTime,format:"yyyy-MM-dd HH:mm")
        ebickmotorNolable.text = Cache.EBICK.insurance?.insuranceEbike?.motorNo
        ebickcodelable.text = Cache.EBICK.insurance?.insuranceEbike?.code
        ebickmodellable.text = Cache.EBICK.insurance?.insuranceEbike?.model
        ebickColorLable.text = Cache.EBICK.insurance?.insuranceEbike?.color
        ebickLogolable.text = Cache.EBICK.insurance?.insuranceEbike?.brand
        
        if(Cache.EBICK.insurance?.insuranceList?.count>0){
            var insurance:InsuranceInfo = Cache.EBICK.insurance!.insuranceList![0]
            insuranceName.text = insurance.typeValue
            insuranceCodelable.text = insurance.insuranceNo
            insuranceStartTimeLable.text = CommonUtil.FloatToDate(insurance.startTime,format:"yyyy-MM-dd HH:mm")
            insuranceEndTimelable.text = CommonUtil.FloatToDate(insurance.endTime,format:"yyyy-MM-dd HH:mm")
        }

    
    
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
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
    
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if(section == 1){
             return 15
        }else{
            return 0

        }
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch(indexPath.section){
            
        case 0:
            //修改密码
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