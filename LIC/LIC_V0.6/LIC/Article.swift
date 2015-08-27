//
//  Article.swift
//  LIC
//
//  Created by 温红权 on 15/5/14.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class Article: Mappable {
    
    //标题
    var title:String!
    //文章地址
    var url:String!
    
    
    required init(){
    
    }
    
    func mapping(map: Map) {
         title <= map["title"]
         url <= map["url"]
    }
}