//
//  CityListTableController.swift
//  LIC
//
//  Created by 温红权 on 15/5/8.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class CityListTableController :BaseTableController {
    
    var currentCity:[BMKOLSearchRecord] = []
    var hotcitys:[BMKOLSearchRecord] = []

    var allProvince:[BMKOLSearchRecord] = []
    var allProvinceSelected:[Bool] = []
    var speacialProvince:[BMKOLSearchRecord] = []
    var displaycitys:[BMKOLSearchRecord] = []
    
    var hasDownload:[BMKOLUpdateElement]? = []
 
    
    
    
    var _arrayHotCityData:NSArray?                     //热门城市
    var _arrayOfflineCityData:NSArray?                 //全国支持离线地图的城市
    var _arraylocalDownLoadMapInfo:NSArray?     //本地下载的离线地图
    
    
    override func viewDidLoad() {
        
        
        OfflineMapDownLoadManage.sharedOfflineMapDownLoadManage.setUp()

        //获取热门城市
        _arrayHotCityData = OfflineMapDownLoadManage.sharedOfflineMapDownLoadManage._offlineMap?.getHotCityList()
        //获取支持离线下载城市列表
        _arrayOfflineCityData = OfflineMapDownLoadManage.sharedOfflineMapDownLoadManage._offlineMap?.getOfflineCityList()
        
        if(_arrayHotCityData?.count > 0){
           hotcitys = []
           hotcitys += _arrayHotCityData as! [BMKOLSearchRecord]
        
        }
        
        
        if(_arrayOfflineCityData?.count>0){
            allProvince = []
            allProvinceSelected = []
            speacialProvince = []
            for var i=0;i<_arrayOfflineCityData!.count;i++ {
                var recode = _arrayOfflineCityData!.objectAtIndex(i) as! BMKOLSearchRecord
                if(recode.cityType == 1){
                   allProvince.append(recode)
                   allProvinceSelected.append(false)
                }else{
                   speacialProvince.append(recode)
                }
            }
            displaycitys = []
            
            displaycitys += speacialProvince
            displaycitys += allProvince
            
        }
        
        
        currentCity = []
        
        var citys = OfflineMapDownLoadManage.sharedOfflineMapDownLoadManage._offlineMap?.searchCity(Cache.USER.userAddr?.city)
        if(citys?.count>0){
            
            currentCity = []
            var recode = citys![0] as! BMKOLSearchRecord
            currentCity.append(recode)
            
            self.tableView.reloadData()
        }

       
        hasDownload = OfflineMapDownLoadManage.sharedOfflineMapDownLoadManage.getlocationDowns()
       
  
      
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

    
    
    override func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
        super.didUpdateBMKUserLocation(userLocation)
        
        var citys = OfflineMapDownLoadManage.sharedOfflineMapDownLoadManage._offlineMap?.searchCity(Cache.USER.userAddr?.city)
        if(citys?.count>0){
            
            currentCity = []
            var recode = citys![0] as! BMKOLSearchRecord
            currentCity.append(recode)
            
            self.tableView.reloadData()
            
            locationManager.stopUserLocationService()
        }
        
        
        
    }
    
    
    
    
    override func viewWillAppear(animated: Bool) {
         super.viewWillAppear(animated)

         NSNotificationCenter.defaultCenter().addObserver(self, selector: "offlineMapStatus:", name: "offlineMapDownLoad", object: nil)
        
        locationManager.startUserLocationService()
        
        hasDownload = OfflineMapDownLoadManage.sharedOfflineMapDownLoadManage.getlocationDowns()
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

    }
    
    
    func  offlineMapStatus(notification:NSNotification){
        var data = notification.object as! NSDictionary
        
        
        hasDownload = OfflineMapDownLoadManage.sharedOfflineMapDownLoadManage.getlocationDowns()
        self.tableView.reloadData()
    }

    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var sectionIndex = section
        
        if(currentCity.count < 1){
            sectionIndex+=1
        }
        switch(sectionIndex){
        case 0:
            return currentCity.count;
        case 1:
            return hotcitys.count;
        case 2:

            return displaycitys.count;
        default:
            break;
        }
        return 0;
    }
    

    
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var header = ""
        
        var sectionIndex = section
        
        if(currentCity.count < 1){
            sectionIndex+=1
        }

        
        switch(sectionIndex){
            case 0:
                header =  "当前城市";
                break
            case 1:
                header =  "热门城市";
                break
            case 2:
                header =  "按省份查找";
                break
            default:
                break;
            }
        
        
        
        
        
        var headerView = UIView(frame: CGRectMake(0, 0, tableView.bounds.size.width, 28))
        
        var headlable:UILabel = UILabel()
        headlable.frame = CGRectMake(10, -2,300, 28);
        headlable.backgroundColor = UIColor.clearColor()
     
        headlable.textColor = CommonUtil.UIColorFromRGB(0x888888);

        headlable.font = UIFont.systemFontOfSize(10)
        
        headlable.text = header
        
        
        headerView.backgroundColor = CommonUtil.UIColorFromRGB(0xefeff4)
        
        headerView.addSubview(headlable)
        
        return headerView;
        
    }
    
    
    
    
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        
        var sectionIndex = section
        
        if(currentCity.count < 1){
            sectionIndex+=1
        }

        
        switch(sectionIndex){
        case 0:
            return 20;
        case 1:
            return 20;
        case 2:
            return 20;
        default:
            break;
        }
        return 0;

    }

    

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if(currentCity.count < 1){
           return 2
        }
        
        return 3
    }
    
    func isDownload(cell:CityOfflineMapTableCell) -> CityOfflineMapTableCell{
    
    
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
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var sectionIndex = indexPath.section
        
        if(currentCity.count < 1){
          sectionIndex+=1
        }
        
        
        switch(sectionIndex){
        case 0:
            var cell = tableView.dequeueReusableCellWithIdentifier("citycell") as! CityOfflineMapTableCell
            cell.cityNameLable.text = currentCity[indexPath.row].cityName
            cell.citySizeLable.text = CommonUtil.getDataSizeString(Int(currentCity[indexPath.row].size))
            cell.setDownloadStatus(0)
            cell.cityId = currentCity[indexPath.row].cityID
            cell = isDownload(cell)
            
            return cell
        case 1:
            var cell = tableView.dequeueReusableCellWithIdentifier("citycell") as! CityOfflineMapTableCell
            cell.cityNameLable.text = hotcitys[indexPath.row].cityName
            cell.citySizeLable.text = CommonUtil.getDataSizeString(Int(hotcitys[indexPath.row].size))
            cell.setDownloadStatus(0)
            cell.cityId = hotcitys[indexPath.row].cityID
            cell = isDownload(cell)
            return cell
        case 2:
            
            
            if displaycitys[indexPath.row].cityType == 1 {
                var cell = tableView.dequeueReusableCellWithIdentifier("provinceTableCell") as! ProvinceTableCell
                cell.provinceLable.text = displaycitys[indexPath.row].cityName
                
                var temp = false
                for var i=0;i<allProvince.count;i++ {
                    if(displaycitys[indexPath.row] == allProvince[i]){
                        if(allProvinceSelected[i]){
                          temp=true
                        }
                        break;
                    }
                }
                if(temp){
                   cell.icoImageView.image = UIImage(named: "up")
                }else{
                   cell.icoImageView.image = UIImage(named: "down")
                }

                
                
                return cell
            
            }else if(displaycitys[indexPath.row].cityType == 0){
            
                var cell = tableView.dequeueReusableCellWithIdentifier("citycell") as! CityOfflineMapTableCell
                cell.cityNameLable.text = displaycitys[indexPath.row].cityName
                cell.citySizeLable.text = CommonUtil.getDataSizeString(Int(displaycitys[indexPath.row].size))
                cell.setDownloadStatus(0)
                
                cell.cityId = displaycitys[indexPath.row].cityID
                cell = isDownload(cell)

                return cell

            }else{
                
                var isin = false
                for recode in speacialProvince {
                    if(displaycitys[indexPath.row] == recode) {
                        isin = true;
                        break;
                    }
                }
                if(isin){
                    var cell = tableView.dequeueReusableCellWithIdentifier("citycell") as! CityOfflineMapTableCell
                    cell.cityNameLable.text = displaycitys[indexPath.row].cityName
                    cell.citySizeLable.text = CommonUtil.getDataSizeString(Int(displaycitys[indexPath.row].size))
                    cell.setDownloadStatus(0)
                    cell.cityId = displaycitys[indexPath.row].cityID
                    cell = isDownload(cell)

                    return cell
                
                }
                var cell = tableView.dequeueReusableCellWithIdentifier("cityProvinceCell") as! CityOfflineMapTableCell
                 cell.cityNameLable.text = displaycitys[indexPath.row].cityName
                cell.citySizeLable.text = CommonUtil.getDataSizeString(Int(displaycitys[indexPath.row].size))
                cell.setDownloadStatus(0)
                cell.cityId = displaycitys[indexPath.row].cityID
                cell = isDownload(cell)

                return cell
            
            }
            
           
            
            
        default:
            break;
        }
        var cell = tableView.dequeueReusableCellWithIdentifier("cityProvinceCell") as! CityOfflineMapTableCell

        return cell


    }
    
    
   
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if(displaycitys[indexPath.row].cityType != 1 || indexPath.section != 2){
           return
        }
        var province = displaycitys[indexPath.row]
        
        displaycitys = []
        displaycitys += speacialProvince
        
        for var i=0;i<allProvince.count;i++ {
            
            displaycitys.append(allProvince[i])
            
            
            if(province == allProvince[i]){
                if(!allProvinceSelected[i]){
            
                   var citys:[BMKOLSearchRecord]? = province.childCities as? [BMKOLSearchRecord]
                   if(citys != nil){
                      displaycitys += citys!
                   }
                }
                allProvinceSelected[i] = allProvinceSelected[i] ? false : true
                
            }else{
                
                if(allProvinceSelected[i]){
                    var citys:[BMKOLSearchRecord]? = allProvince[i].childCities as? [BMKOLSearchRecord]
                    if(citys != nil){
                        displaycitys += citys!
                    }

                }
            
            
            }
            
           
            
            
        }
       
        
        self.tableView.reloadData()
        
    }
    
}