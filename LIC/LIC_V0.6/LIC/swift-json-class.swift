//
//  Serializable.swift
//  LIC
//
//  Created by 温红权 on 15/3/15.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

public class Serializable : NSObject{
    
    func nsValueForAny(anyValue:Any) -> NSObject? {
        switch(anyValue) {
        case let intValue as Int:
            return NSNumber(int: CInt(intValue))
        case let doubleValue as Double:
            return NSNumber(double: CDouble(doubleValue))
        case let stringValue as String:
            return stringValue as NSString
        case let boolValue as Bool:
            return NSNumber(bool: boolValue)
        case let primitiveArrayValue as Array<String>:
            return primitiveArrayValue as NSArray
        case let primitiveArrayValue as Array<Int>:
            return primitiveArrayValue as NSArray
        case let objectArrayValue as Array<Serializable>:
            // this be a tricky one
            return NSNull()
        default:
            return nil
        }
    }
    
    public func toDictionary() -> NSDictionary {
 
        var modelDictionary:NSMutableDictionary=NSMutableDictionary()
        
        let mirror = reflect(self)
        let count = mirror.count
        
        for var index=0;index<count;index++ {
            let key = mirror[index].0
            let value=reflect(self)[index].1.value
            // "super" refers to super class if any.
            if key == "super" && index == 0 {
                continue
            }
            
            if let nsValue=nsValueForAny(value) {
                
                modelDictionary.setValue(nsValue, forKey: key)
                
            }
        }
        
        return modelDictionary
    }
 
    
    public func toJson() -> NSData! {
        var dictionary = self.toDictionary()
        //println(dictionary)
        var err: NSError?
        return NSJSONSerialization.dataWithJSONObject(dictionary, options:NSJSONWritingOptions(0), error: &err)
    }
    
    public func toJsonString() -> NSString! {
        return NSString(data: self.toJson(), encoding: NSUTF8StringEncoding)
    }
    
    
        
    
    
}