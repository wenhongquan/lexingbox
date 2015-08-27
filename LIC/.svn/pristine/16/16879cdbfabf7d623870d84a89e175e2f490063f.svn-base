//
//  InsuranceInfo.swift
//  LIC
//
//  Created by 温红权 on 15/4/16.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation
//import ObjectMapper

class InsuranceInfo :Mappable{
    required init(){}
    
    var id:Int?
    var type:Int?
    var endTime:NSTimeInterval?
    var startTime:NSTimeInterval?
    var gpsId:Int?
    var insertTime:NSTimeInterval?
    var typeValue:String?
    var insertUserId:Int?
    var insuranceUserId:Int?
    var insuranceEbikeId:Int?
    var insuranceNo:String?
    

    
    func mapping(map: Map) {
        
        id <= map["id"]
        type <= map["type"]
        endTime <= map["endTime"]
        startTime <= map["startTime"]
        gpsId <= map["gpsId"]
        insertTime <= map["insertTime"]
        typeValue <= map["typeValue"]
        insertUserId <= map["insertUserId"]
        insuranceUserId <= map["insuranceUserId"]
        insuranceEbikeId <= map["insuranceEbikeId"]
        insuranceNo <= map["insuranceNo"]

        
    }

}