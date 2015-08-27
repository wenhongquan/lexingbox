//
//  EbickPoint.swift
//  LIC
//
//  Created by 温红权 on 15/3/26.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation
//import ObjectMapper

class EbickPoint : Mappable{
    
    
    
    var lng:CLLocationDegrees!
    var lat:CLLocationDegrees!
    var bdAddr:String!
    var type:Int!
    var time:NSTimeInterval!
    var locationTime:NSTimeInterval!
    
    required init(){}
    func mapping(map: Map) {
        
        lng <= map["lng"]
        lat <= map["lat"]
        bdAddr <= map["bdAddr"]
        type <= map["type"]
        time <= map["time"]
        locationTime <= map["locationTime"]
        
        
    }
    
    
    
    
}