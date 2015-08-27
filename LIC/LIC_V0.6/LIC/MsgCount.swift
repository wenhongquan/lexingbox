//
//  MsgCount.swift
//  LIC
//
//  Created by 温红权 on 15/5/14.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation


class MsgCount: Mappable {
    
    var count:Int!
    var readCount:Int!
    var unreadCount:Int!
    var readFlag:Int!
    var type:Int!
    var typeValue:String!
    var lastMsg:Msg!
    
    required init(){}
    func mapping(map: Map) {
         count <= map["count"]
         readCount <= map["readCount"]
         unreadCount <= map["unreadCount"]
         readFlag <= map["readFlag"]
         type <= map["type"]
         typeValue <= map["typeValue"]
         lastMsg <= map["lastMsg"]
    }
    
    
  
    
}