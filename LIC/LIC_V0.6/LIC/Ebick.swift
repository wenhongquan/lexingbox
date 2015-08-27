//
//  Ebick.swift
//  LIC
//
//  Created by 温红权 on 15/3/25.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class Ebick : Mappable{
    
    
    
    var name:String!
    var totalMileage:Double!
    var id:Int!
    var version:NSTimeInterval!
    var todayMUseTime:NSTimeInterval!
    var weight:Int!
    var insertTime:NSTimeInterval!
    var userId:Int!
    var lastModifyTime:NSTimeInterval!
    var unconnTime:NSTimeInterval!
    var periodList:[AnyObject]!
    var connTime:NSTimeInterval!
    var todayMileage:Double!
    var insertType:Int!
    var totalMUseTime:NSTimeInterval!
    var insurance:Insurance?
    var gpsId:Int?
    var firstUseTime:NSTimeInterval?
    var qrCode:String?
    var status:Int?
    var speed:Double?
    var bdAddr:String?
    var locationTime:NSTimeInterval?
    var armingFlag:Int?


    
   required init(){}
    
    func mapping(map: Map) {
        
        name <= map["name"]
        totalMileage <= map["totalMileage"]
        id <= map["id"]
        version <= map["version"]
        todayMUseTime <= map["todayMUseTime"]
        weight <= map["weight"]
        insertTime <= map["insertTime"]
        userId <= map["userId"]
        lastModifyTime <= map["lastModifyTime"]
        unconnTime <= map["unconnTime"]
        periodList <= map["periodList"]
        connTime <= map["connTime"]
        todayMileage <= map["todayMileage"]
        insertType <= map["insertType"]
        totalMUseTime <= map["totalMUseTime"]
        insurance <= map["insurance"]
        gpsId <= map["gpsId"]
        firstUseTime <= map["firstUseTime"]
        qrCode <= map["qrCode"]
        status <= map["status"]
        speed <= map["speed"]
        bdAddr <= map["bdAddr"]
        locationTime <= map["locationTime"]
        armingFlag <= map["armingFlag"]
        
        
    }
    
    
    
    
}