//
//  FeedBack.swift
//  LIC
//
//  Created by 温红权 on 15/4/6.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation
//import ObjectMapper

class FeedBack:Mappable{
    
    
    var userId:Int!
    var message:String!


    
    required init(){}
  
    func mapping(map: Map) {
        
        userId <= map["userId"]
        message <= map["message"]
        
    }



}