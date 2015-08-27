//
//  BaseEbickAuditTableController.swift
//  LIC
//
//  Created by 温红权 on 15/6/25.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class BaseEbickAuditTableController:BaseTableController{
    
    
    
    override func getevents() {
        
    }
    

    var garageEbicks:[Business] = []
    
    
    
    /// 1.未审核 2.通过 3.拒绝';
    var pageType = 2
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
    }
    
    func refresh(){
       getEbickBusinessByMine(0)
    }
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return true
    }
    
 
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {

        return UITableViewCellEditingStyle.Delete;
      
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return garageEbicks.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell
        
        
        /**
        *  TODO:
             需要把cell抽一下
        */
        if pageType == 2 {
           cell = tableView.dequeueReusableCellWithIdentifier("accessTableCell") as! AccessTableCell
            (cell as! AccessTableCell).titleLable.text = garageEbicks[indexPath.row].name
            (cell as! AccessTableCell).addrLable.text = getaddr(indexPath.row)
        }else if pageType == 3{
           cell = tableView.dequeueReusableCellWithIdentifier("noAccessTableCell") as! NoAccessTableCell
            (cell as! NoAccessTableCell).titleLable.text = garageEbicks[indexPath.row].name
            (cell as! NoAccessTableCell).addrLable.text =  getaddr(indexPath.row)
        }else{
           cell = tableView.dequeueReusableCellWithIdentifier("notAuditTableCell") as! NotAuditTableCell
            (cell as! NotAuditTableCell).titleLable.text = garageEbicks[indexPath.row].name
            (cell as! NotAuditTableCell).addrLable.text = getaddr(indexPath.row)
        }

        
        return cell
        
    }
    
    
    func getaddr(index:Int) -> String{
        var string:String! = ""
        
        
        string = string +  (garageEbicks[index].province == nil ? "" : garageEbicks[index].province!)
        string = string +  (garageEbicks[index].area == nil ? "" : garageEbicks[index].area!)
        string = string +  (garageEbicks[index].address == nil ? "" : garageEbicks[index].address!)
    
        
        return  CommonUtil.StringLimt(20, string:string)
        
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return CGFloat.min
        
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        self.tableView.tableHeaderView = self.tableView.tableHeaderView;
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
            return 65

    }

    
    var loding:JGProgressHUD?
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.Delete){
            
            loding=CommonUtil.alertSuccess(self.navigationController!.view!, title: "成功")
            loding?.dismissAfterDelay(12000)
            
            
            CommonUtil.GCDThread({ () -> Void in
                //删除
                GpsService.sharedGpsService.DeleteEbickBrandByMine({ (data) -> Void in
                    self.loding?.dismissAnimated(true)
                    self.garageEbicks.removeAtIndex(indexPath.row)
                    self.tableView.reloadData()
                    }, errorHandler: { (data) -> Void in
                        self.loding?.dismissAnimated(true)
                    }, businessId: self.garageEbicks[indexPath.row].id!)
            }, afterdo: nil)
            
            
            
            
        }
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var sb = UIStoryboard(name: "Main", bundle:nil)
        
        var vc = sb.instantiateViewControllerWithIdentifier("ebickBrandAddTableController") as!  EbickBrandAddTableController
        
        vc.business = self.garageEbicks[indexPath.row]
        
        vc.pageType = self.pageType
        
        vc.hidesBottomBarWhenPushed = true
        
        CommonUtil.transitionWithType(kCATransitionMoveIn, withSubType: kCATransitionFromTop, forView: self.view.window!)
        self.navigationController?.pushViewController(vc, animated: false)
        
         var timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("unselectCurrentRow"), userInfo: nil, repeats: false)

    }
    
    
    func unselectCurrentRow(){
        self.tableView.deselectRowAtIndexPath(self.tableView.indexPathForSelectedRow()!,animated:true);
        
    }
    
    

    
    var businessPageTemp:BusinessPage?
    
    func getEbickBusinessByMine(paged:Int){
        
        loding=CommonUtil.alertLoding(self, title: "请稍等...")
        loding?.dismissAfterDelay(12000)
        
        if(paged == 0){
            //获取电动车
            GpsService.sharedGpsService.GetEbickBrandByMine({ (data) -> Void in
                 self.loding?.dismiss()
                if(data["status"].int == StatusCode.SystemSC.SYSTEM_OK){
                    
                    var businessPage:BusinessPage? = Mapper<BusinessPage>().map(data["data"].dictionaryObject!)
                    if(businessPage?.objs.count > 0){
                        //有数据  渲染
                        self.businessPageTemp = businessPage!
                        self.garageEbicks = self.businessPageTemp!.objs
                        
                        
                        self.tableView.reloadData()
                        
                        if(businessPage!.totalPage == businessPage!.paged){
                            self.tableView.removeFooter()
                        }else{
                            self.tableView.addLegendFooterWithRefreshingBlock({()->Void in
                                self.getEbickBusinessByMine(self.businessPageTemp!.paged! + 1)
                                
                            })
                        }
                        
                        
                        
                    }else{
                        
                        self.businessPageTemp = nil
                        self.garageEbicks = []
                        self.tableView.reloadData()
                    }
                }
                
                
                }, errorHandler: { (data) -> Void in
                    
                }, type: pageType, paged: "1")
            
        }else{
            
            //定位数据
            GpsService.sharedGpsService.GetEbickBrandByMine({(data)in
                self.loding?.dismiss()
                if(data["status"].int == StatusCode.SystemSC.SYSTEM_OK){
                    
                    var businessPage:BusinessPage = Mapper<BusinessPage>().map(data["data"].dictionaryObject!)
                    if(self.businessPageTemp?.objs.count > 0){
                        //有数据  渲染
                        self.businessPageTemp = businessPage
                        self.garageEbicks += self.businessPageTemp!.objs
                        self.tableView.reloadData()
                        
                        if(businessPage.totalPage == businessPage.paged){
                            self.tableView.removeFooter()
                        }else{
                            self.tableView.addLegendFooterWithRefreshingBlock({()->Void in
                                self.getEbickBusinessByMine(self.businessPageTemp!.paged! + 1)
                                
                            })
                        }
                        
                    }
                }
                
                }, errorHandler: {(data)in
                    
                },type: pageType, paged: paged.description)
            
        }
        
    }


}