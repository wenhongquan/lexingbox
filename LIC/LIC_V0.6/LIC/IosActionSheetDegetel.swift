//
//  IosActionSheetDegetel.swift
//  LIC
//
//  Created by 温红权 on 15/5/12.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

private let sharedInstance = IosActionSheetDegetel()

class IosActionSheetDegetel:NSObject,UIActionSheetDelegate,UIAlertViewDelegate{

    
    class var sharedIosActionSheetDegetel : IosActionSheetDegetel {
        return sharedInstance
    }

    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        
        var temp = actionSheet as? UIActionSheetExt
        
        if(temp != nil){
            if( temp!.handles?.count>buttonIndex){
                temp!.handles![buttonIndex]()
            }
        }
        
       
    }
    
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        var temp = alertView as? UIAlertViewExt
        
        if(temp != nil){
            if( temp!.handles?.count>buttonIndex){
                temp!.handles![buttonIndex]()
            }
        }
    }

    
    func alertViewShouldEnableFirstOtherButton(alertView: UIAlertView) -> Bool {
        
        return alertView.textFieldAtIndex(0)?.text != ""
        
    }


}