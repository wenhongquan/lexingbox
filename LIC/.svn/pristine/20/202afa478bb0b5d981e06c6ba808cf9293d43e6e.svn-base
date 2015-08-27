//
//  Trance.swift
//  LIC
//
//  Created by 温红权 on 15/4/23.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class Trance:Mappable{
    
    var id:Int?
    var parkingTime:NSTimeInterval?
    var temporaryParkingCount:Int?
    var startTime:NSTimeInterval?
    var startLng:CLLocationDegrees?
    var startLat:CLLocationDegrees?
    var startAddr:String?
    var endTime:NSTimeInterval?
    var endLng:CLLocationDegrees?
    var endLat:CLLocationDegrees?
    var endAddr:String?
    var mileage:Double?
    var useTime:NSTimeInterval?
    
    var gpsId:Int?
    var ebikeId:Int?
    

    
    
     required init(){}
    
    func mapping(map: Map) {
        
        id <= map["id"]
        parkingTime <= map["parkingTime"]
        temporaryParkingCount <= map["temporaryParkingCount"]
        startTime <= map["startTime"]
        startLng <= map["startLng"]
        startLat <= map["startLat"]
        startAddr <= map["startAddr"]
        endTime <= map["endTime"]
        endLng <= map["endLng"]
        endLat <= map["endLat"]
        endAddr <= map["endAddr"]
        mileage <= map["mileage"]
        useTime <= map["useTime"]
        gpsId <= map["gpsId"]
        ebikeId <= map["ebikeId"]
    }


}