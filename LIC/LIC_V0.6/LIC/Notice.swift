//
//  Notice.swift
//  LIC
//
//  Created by 温红权 on 15/5/15.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class Notice: Mappable {
    var picName:String?
    var title:String?
    var des:String?
    
    
    required init(){}
    func mapping(map: Map) {
         picName <= map["picName"]
         title <= map["title"]
         des <= map["des"]
    
    }
}