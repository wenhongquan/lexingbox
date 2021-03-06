//
//  BaseString.swift
//  LIC
//
//  Created by 温红权 on 15/3/15.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

struct BaseString {
    
    static var ISTEST = false
    
    static var USERPHONE:String?=""
    
//    static let HOST_ADDR="open.91lexing.com"
//    static let HTTP_HOST_ADDR="www.91lexing.com"
//
    static let HOST_ADDR="test.open.91lexing.com"
    static let HTTP_HOST_ADDR="test.www.91lexing.com"
    
//    static let HOST_ADDR="192.168.199.200:8080/lsp"
//    static let HTTP_HOST_ADDR="test.www.91lexing.com"
    
    static let BASEURL="http://"+HOST_ADDR+"/service"

    static let HTTPADDR="http://"+HTTP_HOST_ADDR+"/"

    static var DEVICETOKEN = ""

    static let MOBILEREG = Regex("^(0|86|17951)?(13[0-9]|15[012356789]|18[0-9]|17[0-9]|14[57])[0-9]{8}$")
    
    static var ISSHARK = 1
    static var ISSOUND = 1
    
    static var NetWorkEnable = true

}

class Regex {
    let internalExpression: NSRegularExpression
    let pattern: String
    
    init(_ pattern: String) {
        self.pattern = pattern
        var error: NSError?
        self.internalExpression = NSRegularExpression(pattern: pattern, options: .CaseInsensitive, error: &error)!
    }
    
    func test(input: String) -> Bool {
        let matches = self.internalExpression.matchesInString(input, options: nil, range:NSMakeRange(0, count(input)))
        return matches.count > 0
    }
}
