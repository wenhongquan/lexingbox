//
//  Insurance.swift
//  LIC
//
//  Created by 温红权 on 15/4/16.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation
//import ObjectMapper

class Insurance:Mappable{

    var insuranceUser:InsuranceUser?
    var insuranceEbike:InsuranceEbike?
    var insuranceList:[InsuranceInfo]?=[]
    
    
    
    required init(){}
    func mapping(map: Map) {

        insuranceUser <= map["insuranceUser"]
        insuranceEbike <= map["insuranceEbike"]
        insuranceList <= map["insuranceList"]

        
    }


}
