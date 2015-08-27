//
//  NavController.swift
//  LIC
//
//  Created by 温红权 on 15/3/31.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation


protocol BackButtonHandlerProtocol{
    func  navigationShouldPopOnBackButton() -> Bool
}


class NavController:UINavigationController,UINavigationBarDelegate{



    
    

    func navigationBar(navigationBar: UINavigationBar, shouldPopItem item: UINavigationItem) -> Bool {
        
        
        if self.viewControllers.count < navigationBar.items.count {
            
            return true
            
        }
        
        var shouldPop = true
        
        var vc = self.topViewController
        
        if vc.respondsToSelector(Selector("navigationShouldPopOnBackButton")) {
            if( vc is BaseController ){
                
                if(vc is ACCController){
                   shouldPop = ( vc as! ACCController ).navigationShouldPopOnBackButton();
                }else
                
                if (NSClassFromString("WKWebView") != nil) {
                    
                  shouldPop = ( vc as! WebViewController ).navigationShouldPopOnBackButton();
                
                }else{
                  shouldPop = ( vc as! UIWebViewExtController ).navigationShouldPopOnBackButton();
                }
               
            }
            
        }
        
        if(shouldPop){
            
            
            dispatch_async(dispatch_get_main_queue()) {
                
                
                self.popViewControllerAnimated(true)
                
                return
            }
            
            
        }else{
            
            for sub:AnyObject in navigationBar.subviews {
                if(sub is UIView){
                    
                    var subview:UIView = sub as! UIView
                    
                    if(subview.alpha < 1 ){
                        UIView.animateWithDuration(0.25, animations: {
                            subview.alpha=1
                            
                            
                        } )
                        
                    }
                    
                }
                
            }
            
        }
        
        return false
        
        
    }

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
  
    }
    
    //
//    func navigationBar(navigationBar: UINavigationBar, shouldPushItem item: UINavigationItem) -> Bool {
//        println("----------------")
//        return true
//    }
//
//    
//    override func popToViewController(viewController: UIViewController, animated: Bool) -> [AnyObject]? {
//        println("---eee--")
//      return nil
//    }
//
//    
//    override func pushViewController(viewController: UIViewController, animated: Bool) {
//        println("++eeeeeee++")
//        return super.pushViewController(viewController,animated: animated)
//    }
//
//    
//    override func popViewControllerAnimated(animated: Bool) -> UIViewController? {
//         println("-------+")
//        return nil
//    }
//
   
    
   
    


    
    

}

