//
//  BusinessPage.swift
//  LIC
//
//  Created by 温红权 on 15/4/30.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class BusinessPage: Mappable {
    required init(){}
    
    var totalCount:Int?
    var paged:Int?
    var pageSize:Int?
    var totalPage:Int?
    var objs:[Business] = []
    
    
    func mapping(map: Map) {
         totalCount <= map["totalCount"]
         paged <= map["paged"]
         pageSize <= map["pageSize"]
         totalPage <= map["totalPage"]
         objs <= map["objs"]
    }
}


