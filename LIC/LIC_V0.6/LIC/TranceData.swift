//
//  TranceData.swift
//  LIC
//
//  Created by 温红权 on 15/4/25.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class TranceData :Mappable{

   
    var trajectory:[EbickPoint] = []
    var mbr:[EbickPoint] = []
    
    
    required init(){}
    
    func mapping(map: Map) {
        
        trajectory <= map["trajectory"]
        mbr <= map["mbr"]
        
    }

}