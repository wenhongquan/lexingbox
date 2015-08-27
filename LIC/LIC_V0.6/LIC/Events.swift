//
//  Events.swift
//  LIC
//
//  Created by 温红权 on 15/4/7.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class Events: Mappable {

    var category:Int!
    var lastEvent:[EventMessage]!=[]
    var count:Int!
    var unreadCount:Int!
    var readCount:Int!
    
    required init(){}
    func mapping(map: Map) {
    
       category <= map["category"]
       lastEvent <= map["lastEvent"]
       count <= map["count"]
       unreadCount <= map["unreadCount"]
       readCount <= map["readCount"]
        
    }

}

