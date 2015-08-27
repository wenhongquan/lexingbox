//
//  OrderPay.swift
//  LIC
//
//  Created by 温红权 on 15/7/17.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class OrderPay:Mappable{
    
    var tradeType:String?
    var businessesId:Int?
    var goodsId:Int?
    
    
    
    required init(){}
    
    func mapping(map: Map) {
        
        tradeType <= map["tradeType"]
        businessesId <= map["businessesId"]
        goodsId <= map["goodsId"]
    }
}
