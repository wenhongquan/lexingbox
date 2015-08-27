
//  WebSocketUtil.swift
//  LIC
//
//  Created by 温红权 on 15/3/27.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation


typealias WEBSOCKETHANDLER = (message:String) -> Void

private let sharedInstance = WebSocketUtil()


class WebSocketUtil:WebSocketDelegate{


    class var sharedWebSocket : WebSocketUtil {
        return sharedInstance
    }

    var socket:WebSocket!
    
    
    var handles:[WEBSOCKETHANDLER]!=[]
    
    init(){
        
       socket = WebSocket(url: NSURL(scheme: "ws", host: BaseString.HOST_ADDR, path: "/service/websocket")!)
//       socket = WebSocket(url: NSURL(scheme: "ws", host: "192.168.199.200:8080/lsp", path: "/service/websocket")!)
      
        
       isStart = false
    }
    
    func start(){
       isStart = true
       NSTimer.scheduledTimerWithTimeInterval(1, target: WebSocketUtil.sharedWebSocket, selector:"checkConnect", userInfo: nil, repeats: true)
    }
    
    
    var isStart = false
    
    func connect() {
        
        issendLogin = false
        
        
        if(!isStart){
        
           start()
        }

        
        //网络状态 不通
        if(!BaseString.NetWorkEnable){
            socket.disconnect()
            return
        }
        
        if(socket.isConnected){
            return
        }
        
        
        
        socket.headers[StatusCode.KEY.DEVICE_TOKEN] = UIDevice.currentDevice().identifierForVendor.UUIDString
        socket.headers[StatusCode.CLIENT_VERSION] = "0_1.3_1"
        socket.headers[StatusCode.CLIENT_ID] = Cache.DEVICE_UUID
        
        socket.delegate = self

        
        socket.connect()
        
        
        
        
        
        
//        if(Cache.USER?.lexingKey != nil){
//          
//            
//                //已退出
//                if(Cache.USER.isloginout){
//                
//                    //什么都不做
//                
//                }else{
//                //未退出 //发送乐行key
//                    UserService.sharedUserService.syncDeviceAndUser()
//                    self.sendMessage("{'user':{'lexingKey':'"+Cache.USER.lexingKey+"'}}")
//                
//                }
//            
//            
//        }

    
    }
    
    var issendLogin = false
    
    //检测掉线
    @objc func checkConnect(){
        //退出
//        if(Cache.USER != nil && Cache.USER.isloginout){
//
////            UserService.sharedUserService.LoginOut(nil, errorHandler: nil)
//            
//        }else{
            //登录中
            if self.socket.isConnected {
                //未掉线
            
                if(Cache.USER != nil  && !Cache.USER.isloginout ){
                    if(!issendLogin){
                        UserService.sharedUserService.syncDeviceAndUser()
                       self.sendMessage("{'user':{'lexingKey':'"+Cache.USER.lexingKey+"'}}")
                        issendLogin = true
                    }
                }else{
                
                   issendLogin = false
                }

            }else{
                //掉线  重连
                connect()
            }
//        }
        
    }
    
    
    func disConnection(){
    
       self.socket?.disconnect()
    
    }
    
    func sendMessage(message:String) -> Bool{
    
        if self.socket.isConnected {
            // do cool stuff.
            
            socket.writeString(message)
            
            return true
        }
        return false
    }
    
    
    func websocketDidConnect(socket: WebSocket) {
        println("websocket is connected")
    }

    func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        println("websocket is disconnected: \(error)")
    }
    
    func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        println("got some text: \(text)")
        NSNotificationCenter.defaultCenter().postNotificationName("websocketmessage", object: text)
        
//        if(handles.count>0){
//        
//            for handle:WEBSOCKETHANDLER in handles{
//            
//                handle(message: text)
//            }
//        }
        
    }
    
    func websocketDidReceiveData(socket: WebSocket, data: NSData) {
        println("got some data: \(data.length)")
    }
    
    func addHandle(handler:WEBSOCKETHANDLER) ->Void {
      
        handles.append(handler)
    
    }
    
    func removeHandle() -> Void {
    
        handles.removeAll()
    }

    


}