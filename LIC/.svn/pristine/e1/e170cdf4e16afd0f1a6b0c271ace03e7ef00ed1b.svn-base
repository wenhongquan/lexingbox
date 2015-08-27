//
//  OfflineMapDownLoadManage.swift
//  LIC
//
//  Created by 温红权 on 15/5/9.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation


private let sharedInstance = OfflineMapDownLoadManage()


class OfflineMapDownLoadManage:NSObject,BMKOfflineMapDelegate {
    
    var _offlineMap:BMKOfflineMap?
    
    class var sharedOfflineMapDownLoadManage: OfflineMapDownLoadManage {
        return sharedInstance
    }
    
    override init(){
       _offlineMap = BMKOfflineMap()
    }
    
    
    func setUp(){
        if(_offlineMap?.delegate==nil){
           _offlineMap?.delegate = self
        }
    }
    
    
    func startDownLoadCity(cityId:Int32){
        _offlineMap?.start(cityId)

    }
    
    func pauseDownLoadCity(cityId:Int32){
        _offlineMap?.pause(cityId)
    }
    
    
    func removeDownLoadCity(cityId:Int32){
        _offlineMap?.remove(cityId)
    }
    
    func getlocationDowns() -> [BMKOLUpdateElement]?{
       
        var citys:[BMKOLUpdateElement]? = _offlineMap?.getAllUpdateInfo() as? [BMKOLUpdateElement]
        return citys
    }
    
    
    
    
    
    func onGetOfflineMapState(type: Int32, withState state: Int32) {
        
        var obj:NSDictionary = [
            "type":Int(type),
            "state":Int(state)
        ]
        
        NSNotificationCenter.defaultCenter().postNotificationName("offlineMapDownLoad", object: obj)
        
//        if (Int(type) == TYPE_OFFLINE_UPDATE ) {
//            //id为state的城市正在下载或更新，start后会毁掉此类型
//            //            BMKOLUpdateElement* updateInfo;
//            //            updateInfo = [_offlineMap getUpdateInfo:state];
//            //            NSLog(@"城市名：%@,下载比例:%d",updateInfo.cityName,updateInfo.ratio);
//        }
//        if (Int(type) == TYPE_OFFLINE_NEWVER) {
//            //id为state的state城市有新版本,可调用update接口进行更新
//            //            BMKOLUpdateElement* updateInfo;
//            //            updateInfo = [_offlineMap getUpdateInfo:state];
//            //            NSLog(@"是否有更新%d",updateInfo.update);
//        }
//        if (Int(type) == TYPE_OFFLINE_UNZIP) {
//            //正在解压第state个离线包，导入时会回调此类型
//        }
//        if (Int(type) == TYPE_OFFLINE_ZIPCNT) {
//            //检测到state个离线包，开始导入时会回调此类型
//            //            NSLog(@"检测到%d个离线包",state);
//            //            if(state==0)
//            //            {
//            //                [self showImportMesg:state];
//            //            }
//        }
//        if (Int(type) == TYPE_OFFLINE_ERRZIP) {
//            //有state个错误包，导入完成后会回调此类型
//            //            NSLog(@"有%d个离线包导入错误",state);
//        }
//        if (Int(type) == TYPE_OFFLINE_UNZIPFINISH) {
//            //            NSLog(@"成功导入%d个离线包",state);
//            //导入成功state个离线包，导入成功后会回调此类型
//            //            [self showImportMesg:state];
//        }
        
    }
}