//
//  UserService.swift
//  LIC
//
//  Created by 温红权 on 15/3/14.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

private let sharedInstance = UserService()

class UserService:BaseService{

    class var sharedUserService : UserService {
        return sharedInstance
    }
    

    
    /**
    登录
    
    :param: successHandler 成功后的处理函数
    :param: errorHandler   失败后处理函数
    :param: body           传输的httpbody值
    */
    func Login(successHandler:SERVICEHANDLER,errorHandler:SERVICEHANDLER,body:[String:AnyObject])->Void{
        
    
        
        HttpUtil.DoPOST(getUrl(StatusCode.URL.USER_LOGIN), lexingkey: getLexingKey(), body:body){(body:JSON,error:String) in
            
            if( error != ""){
            
                errorHandler(data: body);
                return
            }else{
            
                successHandler(data: body);
                return
            
            }
            
       }
    }
    
    /**
    登出
    
    :param: successHandler 成功后的处理函数
    :param: errorHandler   失败后处理函数
    :param: body           传输的httpbody值
    */
    func LoginOut(successHandler:SERVICEHANDLER?,errorHandler:SERVICEHANDLER?)->Void{
        
        
        
        HttpUtil.DoGet(getUrl(StatusCode.URL.USER_LOGIN_OUT), lexingkey: getLexingKey()){(body:JSON,error:String) in
            
            if( error != ""){
                
                errorHandler?(data: body);
                return
            }else{
                
                successHandler?(data: body);
                return
                
            }
            
        }
    }

    
    
    
    
    /**
    获取用户信息
    
    :param: successHandler 成功后的处理函数
    :param: errorHandler   失败后处理函数
    :param: userId         用户ID
    */
    func GetUserInfo(successHandler:SERVICEHANDLER,errorHandler:SERVICEHANDLER,userId:Int){
    
       
        
        var url = getUrl(StatusCode.URL.F_USER_ID)
        url = url.stringByReplacingOccurrencesOfString("{0}", withString: userId.description, options: nil, range: nil)
        
        HttpUtil.DoGet(url, lexingkey: getLexingKey() ){(body:JSON,error:String) in
            
            if( error != ""){
                
                errorHandler(data: body);
                return
            }else{
                
                successHandler(data: body);
                return
                
            }
            
        }

    }
    
    /**
    用户注册码请求
    
    :param: successHandler 成功后的处理函数
    :param: errorHandler   失败后处理函数
    :param: body           {"phone":"13505159275"}
    */
    func RegisterValidate(successHandler:SERVICEHANDLER,errorHandler:SERVICEHANDLER,body:[String:AnyObject])->Void{
 
        
        HttpUtil.DoPOST(getUrl(StatusCode.URL.USER_REGISTER_VALIDATE), lexingkey: getLexingKey(), body:body){(body,error:String) in
            
            if( error != ""){
                
                errorHandler(data: body);
                return
            }else{
                
                successHandler(data: body);
                return
                
            }
            
        }

    
    }
    
    /**
    注册验证码验证
    
    :param: successHandler 成功后的处理函数
    :param: errorHandler   失败后处理函数
    :param: body           {“phone”:"13505159275","code":"123456"}
    */
    func CodeValidate(successHandler:SERVICEHANDLER,errorHandler:SERVICEHANDLER,body:[String:AnyObject])->Void {

        
        HttpUtil.DoPOST(getUrl(StatusCode.URL.USER_VALIDATE), lexingkey: getLexingKey(), body:body){(body,error:String) in
            
            if( error != ""){
                
                errorHandler(data: body);
                return
            }else{
                
                successHandler(data: body);
                return
                
            }
            
        }

    }
    
    /**
    注册
    
    :param: successHandler 成功后的处理函数
    :param: errorHandler   失败后处理函数
    :param: body           {“phone”:"13505159275","password":"12345678","code":"123456"}
    */
    func Register(successHandler:SERVICEHANDLER,errorHandler:SERVICEHANDLER,body:[String:AnyObject]) -> Void {
    
        HttpUtil.DoPOST(getUrl(StatusCode.URL.USER_REGISTER), lexingkey: getLexingKey(), body:body){(body,error:String) in
            
            if( error != ""){
                
                errorHandler(data: body);
                return
            }else{
                
                successHandler(data: body);
                return
                
            }
            
        }

    }
    
    
    /**
    找回密码--获取验证码
    
    :param: successHandler 成功后的处理函数
    :param: errorHandler   失败后处理函数
    :param: userphone      用户手机号
    */
    func forgotPasswordValidate(successHandler:SERVICEHANDLER,errorHandler:SERVICEHANDLER,userphone:String){
        
        var url = getUrl(StatusCode.URL.F_USER_PASSWORD_FOTGOT_VALIDATE)
        url = url.stringByReplacingOccurrencesOfString("{0}", withString: userphone, options: nil, range: nil)
        
        HttpUtil.DoGet(url, lexingkey: getLexingKey() ){(body:JSON,error:String) in
            
            if( error != ""){
                
                errorHandler(data: body);
                return
            }else{
                
                successHandler(data: body);
                return
                
            }
            
        }

    }
    
    /**
    找回密码--修改密码
    
    :param: successHandler 成功后的处理函数
    :param: errorHandler   失败后处理函数
    :param: body           {“phone”:"13505159275","password":"12345678","code":"123456"}
    */
    func forgotPasswordRePassword(successHandler:SERVICEHANDLER,errorHandler:SERVICEHANDLER,body:[String:AnyObject]){
    
        HttpUtil.DoPUT(getUrl(StatusCode.URL.USER_PASSWORD_FOTGOT), lexingkey: getLexingKey(), body:body){(body,error:String) in
            
            if( error != ""){
                
                errorHandler(data: body);
                return
            }else{
                
                successHandler(data: body);
                return
                
            }
            
        }

    }
    
    /**
    修改密码
    
    :param: successHandler 成功后的处理函数
    :param: errorHandler   失败后处理函数
    :param: body           {“phone”:"13505159275","oldPassword":"12345678","password":"123456"}
    */
    func RePassword(successHandler:SERVICEHANDLER,errorHandler:SERVICEHANDLER,body:[String:AnyObject]){
    
        HttpUtil.DoPUT(getUrl(StatusCode.URL.USER_PASSWORD), lexingkey: getLexingKey(), body:body){(body,error:String) in
            
            if( error != ""){
                
                errorHandler(data: body);
                return
            }else{
                
                successHandler(data: body);
                return
                
            }
            
        }

    
    }
    
    /**
    意见反馈
    
    :param: successHandler 成功后的处理函数
    :param: errorHandler   失败后处理函数
    :param: body           {“userId”:"13505159275","message":"12345678"}
    */
    func FeedBack(successHandler:SERVICEHANDLER,errorHandler:SERVICEHANDLER,body:[String:AnyObject]){
        
        HttpUtil.DoPOST(getUrl(StatusCode.URL.FEEDBACK), lexingkey: getLexingKey(), body:body){(body,error:String) in
            
            if( error != ""){
                
                errorHandler(data: body);
                return
            }else{
                
                successHandler(data: body);
                return
                
            }
            
        }
        
        
    }
    
    /**
    设置信息修改
    
    :param: successHandler 成功后的处理函数
    :param: errorHandler   失败后处理函数
    :param: body           {“userId”:"13505159275","message":"12345678"}
    */
    func SetSetting(){
        
        var user = User()
        user.id = Cache.USER.id
        user.iosSetItem = BaseString.ISSOUND.description+BaseString.ISSHARK.description
        
        HttpUtil.DoPUT(getUrl(StatusCode.URL.USER), lexingkey: getLexingKey(), body:Mapper().toJSON(user)){(body,error:String) in
            
                       
        }
        
        
    }
    
    
    /**
    获取设备唯一标识
    
    :param: successHandler 成功后的处理函数
    :param: errorHandler   失败后处理函数
    :param: body           {“userId”:"13505159275","message":"12345678"}
    */
    func GetDeviceUUID(){
        
        
        var superSecretValue1: String? = KeychainWrapper.stringForKey("device_uuid")
        if(superSecretValue1 != nil){
           Cache.DEVICE_UUID = superSecretValue1!
           return
        }
        

        HttpUtil.DoGet(getUrl(StatusCode.URL.DEVICE_UUID), lexingkey: "") { (body, error) -> Void in
         
            //解析并存储到keychian
            if(body["status"].int == StatusCode.SystemSC.SYSTEM_OK){
                if(body["data"]["clientId"].string != nil){
                    Cache.DEVICE_UUID = body["data"]["clientId"].string!
                    //存储
                   let saveSuccessful: Bool = KeychainWrapper.setString(Cache.DEVICE_UUID, forKey: "device_uuid")
                }
            
            }
            
            
        }

        
    }

    
    /**
    上传用户位置信息
    */
    func UploadUserLocation(){
        
      var userlocation = UserLocation()
        
        userlocation.area = Cache.USER.userAddr?.district
        userlocation.city = Cache.USER.userAddr?.city
        userlocation.province = Cache.USER.userAddr?.province
        //websocket 上传
        WebSocketUtil.sharedWebSocket.sendMessage("{ 'location':" + Mapper().toJSONString(userlocation, prettyPrint: true) + "}")
        HttpUtil.DoPOST(getUrl(StatusCode.URL.USER_LOCATION_UPLOAD), lexingkey: getLexingKey(), body:Mapper().toJSON(userlocation)){(body,error:String) in
            
            if( error != ""){
                return
            }else{
                return
            }
        }
    }
    
    /**
    同步设备与用户的消息
    */
    func syncDeviceAndUser(){

        HttpUtil.DoPOST(getUrl(StatusCode.URL.DEVICE_USER_SYNC), lexingkey: getLexingKey(), body: nil){(body,error:String) in
            
            if( error != ""){
                return
            }else{
                return
            }
        }
    }

    
    
    
    
 
    
    

}