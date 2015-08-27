//
//  User.swift
//  LIC
//
//  Created by 温红权 on 15/3/15.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class User : UserBase{

  
    var isloginout:Bool = true
    
    var userAddr:BMKAddressComponent?

    var appversion:Double?
    
     override func mapping(map: Map) {
        super.mapping(map)
        isloginout <= map["isloginout"]
        userAddr <= map["userAddr"]
        appversion <= map["appversion"]
    }



    
}