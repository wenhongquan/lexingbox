//
//  DownloadTableController.swift
//  LIC
//
//  Created by 温红权 on 15/5/8.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class DownloadTableController:BaseTableController {
    
     var hasDownload:[BMKOLUpdateElement]? = []
    
    override func viewDidLoad() {
        hasDownload = OfflineMapDownLoadManage.sharedOfflineMapDownLoadManage.getlocationDowns()
        self.tableView.reloadData()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "offlineMapStatus:", name: "offlineMapDownLoad", object: nil)
        hasDownload = OfflineMapDownLoadManage.sharedOfflineMapDownLoadManage.getlocationDowns()
        
        
        if(hasDownload?.count>0){
        
            self.tableView.allowsSelection = true
            self.tableView.scrollEnabled = true
        }else{
            self.tableView.allowsSelection = false
            self.tableView.scrollEnabled = false
        
        }
        
        
        self.tableView.reloadData()
        
        
   
       
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func getevents(){
        if(Cache.MSGCOUNT == nil){
            return
        }
        
        if(Cache.MSGCOUNT != nil ){
            //取一个电动车
            if( Cache.MSGCOUNT.count>0){
                
                var hasNoRead = false
                
                var allCount = 0
                
                for msgCount in Cache.MSGCOUNT {
                    if msgCount.unreadCount > 0 {
                        hasNoRead = true;
                        allCount += msgCount.unreadCount
                    }
                    
                }
                if(!hasNoRead){
                    
                   // CommonUtil.removeTabBarRed(self.tabBarController, index: 2)
                    UIApplication.sharedApplication().applicationIconBadgeNumber = 0
                    
                }else{
                    
                    UIApplication.sharedApplication().applicationIconBadgeNumber = allCount
                   // CommonUtil.setTabBarRed(self.tabBarController, index: 2, num: 4)
                }
                
            }else{
               // CommonUtil.removeTabBarRed(self.tabBarController, index: 2)
                UIApplication.sharedApplication().applicationIconBadgeNumber = 0
            }
            
        }
        
    }

    
    override func viewDidAppear(animated: Bool) {
       
    }
    
    var editeable = true
    
    
    func  offlineMapStatus(notification:NSNotification){
        var data = notification.object as! NSDictionary
        
        
        hasDownload = OfflineMapDownLoadManage.sharedOfflineMapDownLoadManage.getlocationDowns()
        
        editeable = true
        if(self.hasDownload != nil){
            for bMKOLUpdateElement:BMKOLUpdateElement in self.hasDownload! {
                if(bMKOLUpdateElement.status == 1){
                    editeable = false
                    break
                }
                
            }
        }else{
          hasDownload = []
        }
       
        
        if(hasDownload?.count>0){
            
            self.tableView.allowsSelection = true
            self.tableView.scrollEnabled = true
        }else{
            self.tableView.allowsSelection = false
            self.tableView.scrollEnabled = false
            
        }
        
        self.tableView.reloadData()
    }
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return !(hasDownload == nil || hasDownload?.count<1)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.Delete){
        
           OfflineMapDownLoadManage.sharedOfflineMapDownLoadManage.removeDownLoadCity(hasDownload![indexPath.row].cityID)
            hasDownload = OfflineMapDownLoadManage.sharedOfflineMapDownLoadManage.getlocationDowns()
            
            if(hasDownload?.count>0){
                
                self.tableView.allowsSelection = true
                self.tableView.scrollEnabled = true
            }else{
                self.tableView.allowsSelection = false
                self.tableView.scrollEnabled = false
                
            }
            self.tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        if(editeable){
           return UITableViewCellEditingStyle.Delete;
        }else{
           return UITableViewCellEditingStyle.None;
        }
    }
    
    func isDownload(cell:CityOfflineMapTableManageCell) -> CityOfflineMapTableManageCell{
        
        
        if( self.hasDownload == nil || cell.cityId == nil) {
            return cell
        }
        
        for bMKOLUpdateElement:BMKOLUpdateElement in self.hasDownload! {
            
            if(bMKOLUpdateElement.cityID == cell.cityId!){
                if(bMKOLUpdateElement.status == 4 || bMKOLUpdateElement.status == 10){
                    cell.setDownloadStatus(3)
                }else{
                    //下载状态, -1:未定义 1:正在下载　2:等待下载　3:已暂停　4:完成 5:校验失败 6:网络异常 7:读写异常 8:Wifi网络异常 9:未完成的离线包有更新包 10:已完成的离线包有更新包 11:没有完全下载完成的省份 12:该省份的所有城市都已经下载完成 13:该省份的部分城市需要更新
                    
                    // 0--未下载 1--正在下载  2--暂停  3--完成
                    if(bMKOLUpdateElement.status == 3){
                        cell.setDownloadStatus(2)
                        cell.setprecess(CGFloat(bMKOLUpdateElement.ratio))
                    }else
                        if(bMKOLUpdateElement.status == 1 || bMKOLUpdateElement.status == 2 ||  bMKOLUpdateElement.status == 9){
                            cell.setDownloadStatus(1)
                            cell.setprecess(CGFloat(bMKOLUpdateElement.ratio))
                        }
                            
                        else{
                            cell.setDownloadStatus(0)
                            cell.setprecess(CGFloat(bMKOLUpdateElement.ratio))
                    }
                    
                    
                    
                    
                    
                }
                
                
                break;
            }
            
        }
        
        return cell
        
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (hasDownload == nil || hasDownload?.count<1)  ? 1 : hasDownload!.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if(hasDownload == nil || hasDownload?.count<1){
            var cell = tableView.dequeueReusableCellWithIdentifier("offlinemapNoneCell") as! UITableViewCell
            
            return cell

        
        }
        
        
        
            var cell = tableView.dequeueReusableCellWithIdentifier("cityOfflineMapTableManageCell") as! CityOfflineMapTableManageCell
            cell.cityNameLable.text = hasDownload![indexPath.row].cityName
            cell.citySizeLable.text = CommonUtil.getDataSizeString(Int(hasDownload![indexPath.row].size))
            cell.setDownloadStatus(0)
            cell.cityId = hasDownload![indexPath.row].cityID
            cell = isDownload(cell)
            
            return cell
        
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      
        return CGFloat.min
        
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
          self.tableView.tableHeaderView = self.tableView.tableHeaderView;
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(hasDownload == nil || hasDownload?.count<1){
            
            return self.tableView.frame.height
        }else{
            
           
                return 44
            
        }
    }

    
    
    
    




    
}