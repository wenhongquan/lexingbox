//
//  UserBase.swift
//  LIC
//
//  Created by 温红权 on 15/6/25.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//


import Foundation

class UserBase : Mappable{
    
    var id : Int!
    var phone : String!
    var password : String!
    var lexingKey : String!
    var name : String!
    var sex : String!
    var setItem : String!
    var email : String!
    var registerTime : NSTimeInterval!
    var lastLoginTime : NSTimeInterval!
    var status : Int!
    var lastLoginType : Int!
    var deleteFlag : Int!
    var longitude : CLLocationDegrees!
    var latitude : CLLocationDegrees!
    var lastModifyTime : NSTimeInterval!
    var version :NSTimeInterval!
    var weixinOpenid :String!
    var code:String!
    var oldPassword:String!
    var deviceToken:String?
    var agentId:Int! = 1
    var clientType:Int! = 0
    var iosSetItem:String?

    
    
    init(phone:String,pass:String){
        self.password=pass;
        self.phone=phone
    }
    
    
    required init(){}
    
    func mapping(map: Map) {
        
        id <= map["id"]
        phone <= map["phone"]
        password <= map["password"]
        lexingKey <= map["lexingKey"]
        name <= map["name"]
        sex <= map["sex"]
        setItem <= map["setItem"]
        email <= map["email"]
        registerTime <= (map["registerTime"])
        lastLoginTime <= (map["lastLoginTime"])
        status <= map["status"]
        lastLoginType <= map["lastLoginType"]
        deleteFlag <= map["deleteFlag"]
        longitude <= map["longitude"]
        latitude <= map["latitude"]
        lastModifyTime <= (map["lastModifyTime"])
        version <= (map["version"])
        weixinOpenid <= map["weixinOpenid"]
        code <= map["code"]
        oldPassword <= map["oldPassword"]
        deviceToken <= map["deviceToken"]
        iosSetItem <= map["iosSetItem"]
        agentId <= map["agentId"]
        clientType <= map["clientType"]
        
    }
    
    
    
    
}