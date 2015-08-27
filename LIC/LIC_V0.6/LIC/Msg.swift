//
//  Msg.swift
//  LIC
//
//  Created by 温红权 on 15/5/14.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class Msg:Mappable{


    var id:Double!
    var type:Int!
    var typeValue:String!
    var category:Int!
    var categoryValue:String!
    var categoryDes:String!
    var userId:Double!
    var detailsId:Double!
    var readFlag:Int!
    var insertTime:NSTimeInterval!
    var msgDetails:EventMessage!
    var articles:[Article]!=[]
    var version:NSTimeInterval!
    
    
    required init(){}
    func mapping(map: Map) {
        
        id <= map["id"]
        type <= map["type"]
        typeValue <= map["typeValue"]
        category <= map["category"]
        categoryValue <= map["categoryValue"]
        categoryDes <= map["categoryDes"]
        userId <= map["userId"]
        detailsId <= map["detailsId"]
        readFlag <= map["readFlag"]
        insertTime <= map["insertTime"]
        msgDetails <= map["msgDetails"]
        version <= map["version"]
        articles <= map["articles"]
        
        
    }



}