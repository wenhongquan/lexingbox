//
//  BaseService.swift
//  LIC
//
//  Created by 温红权 on 15/3/18.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation


typealias SERVICEHANDLER = (data:JSON)->Void

class BaseService{

    func getUrl(url:String)->String{
        return BaseString.BASEURL+url
    }
    
    func getLexingKey()->String{
        
        if(Cache.USER != nil){
            if(Cache.USER.isloginout==true){
               return ""
            }
        }
    
      return  Cache.USER == nil ? "":(Cache.USER.lexingKey == nil ? "" : Cache.USER.lexingKey)
    }
    

}