//
//  Cache.swift
//  LIC
//
//  Created by 温红权 on 15/3/25.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation


struct Cache {
    static var USER:User! = User()
    static var EBICK:Ebick!
    static var GPSINFO:GpsInfo!
//    static var EBICKSEVENTS:EbicksEvents!
//    static var EVENTMESSAGES:EventMessagePage!
    
    
    static var MSGCOUNT:[MsgCount]! = []
    
    static var DEVICE_UUID = ""
    
    static let VERSION = 1.2
    
    static var BANNER:Banners?
    
    static var BRANDS:JSON?
    
}