//
//  EbickbusinessAddr.swift
//  LIC
//
//  Created by 温红权 on 15/6/2.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class EbickbusinessAddr:Mappable {
    
    var id:Int?
    var name:String?
    var province:String?
    var city:String?
    var area:String?
    var address:String?
    var telephone:String?
    var longitude:CLLocationDegrees?
    var latitude:CLLocationDegrees?
    var coordType:Int = 2
    

    required init(){}
    func mapping(map: Map) {
        id <= map["id"]
        province <= map["province"]
        city <= map["city"]
        area <= map["area"]
        name <= map["name"]
        address <= map["address"]
        telephone <= map["telephone"]
        longitude <= map["longitude"]
        latitude <= map["latitude"]
        coordType <= map["coordType"]
    
    }

}