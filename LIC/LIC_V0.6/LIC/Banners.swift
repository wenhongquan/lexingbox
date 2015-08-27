//
//  Banners.swift
//  LIC
//
//  Created by 温红权 on 15/7/9.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation


class Banners:Mappable{
    
    var status:Int?
    var data:[Banner]=[]
    
    required init(){}
    
    func mapping(map: Map) {
        status <= map["status"]
        data <= map["data"]
    }
    

}