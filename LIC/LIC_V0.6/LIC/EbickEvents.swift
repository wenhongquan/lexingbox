//
//  EbickEvents.swift
//  LIC
//
//  Created by 温红权 on 15/4/7.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class EbickEvents:Mappable {

    var id:Int!
    var name:String!
    var eventCountList:[Events]!=[]
    var unreadCount:Int!
    var count:Int!
    var readCount:Int!
    
    required init(){}
    func mapping(map: Map) {
        
        id <= map["id"]
        name <= map["name"]
        eventCountList <= map["eventCountList"]
        count <= map["count"]
        unreadCount <= map["unreadCount"]
        readCount <= map["readCount"]

        
    }

}
