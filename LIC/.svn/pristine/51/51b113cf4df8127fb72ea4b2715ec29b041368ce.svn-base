//
//  NetworkEnable.swift
//  LIC
//
//  Created by 温红权 on 15/5/19.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

private let sharedInstance = NetworkEnable()

class NetworkEnable {
    
    class var sharedNetworkEnable : NetworkEnable {
        return sharedInstance
    }

    var internetConnectionReach:Reachability?
    
    func checkNet(){
        if(internetConnectionReach == nil){
            self.internetConnectionReach = Reachability(hostName: BaseString.HOST_ADDR)
            self.internetConnectionReach?.startNotifier()
        }
    }
    
    
}