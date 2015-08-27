//
//  HttpUtil.swift
//  LIC
//
//  Created by 温红权 on 15/3/14.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//
import Foundation

//import Alamofire

typealias Handle = (body:JSON,error:String) -> Void

struct HttpUtil {
    


    
    static func DoGet(url:String,lexingkey:String,complete:Handle) -> Void{
        
        
   
        
        
        var headers = Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders ?? [:]

        headers["LEXING-KEY"] = lexingkey
        headers["Content-Type"] = "application/json"
        headers["CLIENT-ID"] = Cache.DEVICE_UUID
//        println(lexingkey)
        NSURLCache.sharedURLCache().removeAllCachedResponses()
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = headers
        
        var urltemp = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        configuration.timeoutIntervalForResource = 20
        
        Manager(configuration: configuration)
            .request(.GET,urltemp)
            .responseJSON { (request, response, json, error) in
                if(error != nil){
                    
                }else{
//                    println(request)
                    complete(body:JSON(json!),error:"")
                }
        }

        
    }
    
    static func DoPOST(url:String,lexingkey:String,body:[String:AnyObject]?,complete:Handle) -> Void{
         NSURLCache.sharedURLCache().removeAllCachedResponses()
        
        var headers = Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders ?? [:]
        headers["LEXING-KEY"] = lexingkey
        headers["Content-Type"] = "application/json"
        headers["CLIENT-ID"] = Cache.DEVICE_UUID
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = headers
        configuration.timeoutIntervalForResource = 20
//        
//        println(body)
//        
//        println(lexingkey)
//        
//        println(url)
        
        
            Manager(configuration: configuration)
            .request(.POST, url, parameters:body, encoding: .JSON)
           .responseJSON { (request, response, json, error) in
            if(error != nil){
//                println(error)
            }else{
//                println(json)
                complete(body:JSON(json!),error:"")
            }
        }
        

    
    }

    static func DoPUT(url:String,lexingkey:String,body:[String:AnyObject]?,complete:Handle) -> Void{
         NSURLCache.sharedURLCache().removeAllCachedResponses()
        var headers = Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders ?? [:]
        headers["LEXING-KEY"] = lexingkey
        headers["Content-Type"] = "application/json"
        headers["CLIENT-ID"] = Cache.DEVICE_UUID
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = headers
        configuration.timeoutIntervalForResource = 20
        
        
            Manager(configuration: configuration)
            .request(.PUT, url, parameters:body, encoding: .JSON)
            .responseJSON { (request, response, json, error) in
                if(error != nil){
                    
                }else{
                    complete(body:JSON(json!),error:"")
                }
        }

        
    }

    static func DoDelete(url:String,lexingkey:String,complete:Handle) -> Void{
         NSURLCache.sharedURLCache().removeAllCachedResponses()
        var headers = Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders ?? [:]
        headers["LEXING-KEY"] = lexingkey
        headers["Content-Type"] = "application/json"
        headers["CLIENT-ID"] = Cache.DEVICE_UUID
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = headers
        configuration.timeoutIntervalForResource = 20
        
        
            Manager(configuration: configuration)
            .request(.DELETE, url)
            .responseJSON { (request, response, json, error) in
                if(error != nil){
                    
                }else{
                    complete(body:JSON(json!),error:"")
                }
        }

    }

    
}



