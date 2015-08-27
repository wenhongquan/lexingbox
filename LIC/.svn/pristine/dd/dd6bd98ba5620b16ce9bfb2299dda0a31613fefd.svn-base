//
//  EventMessagePage.swift
//  LIC
//
//  Created by 温红权 on 15/4/9.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation
//import ObjectMapper

class EventMessagePage: Mappable {
    
    var pageSize:Int!
    var paged:Int!
    var objs:[Msg]!
    var totalPage:Int!
    var totalCount:Int!
    
    
    
    var ebicksEvents:[EbickEvents]!
    
    required init(){}
    
    func mapping(map: Map) {
        
         pageSize <= map["pageSize"]
         paged <= map["paged"]
         objs <= map["objs"]
         totalPage <= map["totalPage"]
         totalCount <= map["totalCount"]
        
    }
}
