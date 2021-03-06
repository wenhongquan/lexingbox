//
//  Business.swift
//  LIC
//
//  Created by 温红权 on 15/4/30.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class Business: Mappable {
    required init(){}
    
    var id:Int?
    var name:String?
    var province:String?
    var city:String?
    var area:String?
    var address:String?
    var telephone:String?
    ///     107001,107002,107003,107004,107005,107006
    var businessScope:[Int]?
    var businessScopeValue:[String]?
    var photoUrl:String?
    var sPhotoUrl:String?
    var gcj02Point:EbickPoint?
    var bd09Point:EbickPoint?
    var distance:Double?
    /// 维修范围：1.仅维修经营品牌2.维修所有3.不提供维修服务
    var repairScope:String?
    var brandIds:[Int]?
    var brandValue:[String]?
    var lxbDeviceSellFlag:Int?
    
    var refuseReason:String?

    
    func mapping(map: Map) {
        
         id <= map["id"]
         name <= map["name"]
         province <= map["province"]
         city <= map["city"]
         area <= map["area"]
         address <= map["address"]
         telephone <= map["telephone"]
         businessScope <= map["businessScope"]
         businessScopeValue <= map["businessScopeValue"]
         photoUrl <= map["photoUrl"]
         sPhotoUrl <= map["sPhotoUrl"]
         gcj02Point <= map["gcj02Point"]
         bd09Point <= map["bd09Point"]
         distance <= map["distance"]
         repairScope <= map["repairScope"]
        brandIds <= map["brandIds"]
        brandValue <= map["brandValue"]
        lxbDeviceSellFlag <= map["lxbDeviceSellFlag"]
         refuseReason <= map["refuseReason"]
        
    }

}

