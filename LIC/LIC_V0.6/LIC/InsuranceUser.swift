//
//  InsuranceUser.swift
//  LIC
//
//  Created by 温红权 on 15/4/16.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation
//import ObjectMapper

class InsuranceUser:Mappable{
    required init(){}
    
    var address:String?
    var id:Int?
    var name:String?
    var phone:String?
    var gpsId:Int?
    var userId:Int?
    var insertTime:NSTimeInterval?
    var idCard:String?
    var insertUserId:Int?

    
    func mapping(map: Map) {
        
         address <= map["address"]
         id <= map["id"]
         name <= map["name"]
         phone <= map["phone"]
         gpsId <= map["gpsId"]
         userId <= map["userId"]
         insertTime <= map["insertTime"]
         idCard <= map["idCard"]
         insertUserId <= map["insertUserId"]
        
        
    }


}