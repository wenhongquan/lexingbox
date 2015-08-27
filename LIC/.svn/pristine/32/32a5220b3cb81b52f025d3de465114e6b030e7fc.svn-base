//
//  File.swift
//  LIC
//
//  Created by 温红权 on 15/6/17.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class EbickBrandManageTabbarController :BFPaperTabBarController,UITabBarControllerDelegate {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        
        self.navigationItem.title = "我标注的商户"
        
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()

        self.tapCircleColor = CommonUtil.UIColorFromRGBA(0x2bcd9c, alpha: 0.5)
        
        self.backgroundFadeColor = CommonUtil.UIColorFromRGBA(0x2bcd9c, alpha: 0.5)
        
        self.underlineColor = CommonUtil.UIColorFromRGB(0x2bcd9c)
        
       
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
            self.tabBar.frame = CGRectMake(0, 0 , self.tabBar.frame.size.width, self.tabBar.frame.size.height)
    }
    
    
    
    //pragma UITabBarController Delegate
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        return true
    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        
    }
    
    
    func tabBarController(tabBarController: UITabBarController, willBeginCustomizingViewControllers viewControllers: [AnyObject]) {
        
    }
    
    
    func tabBarController(tabBarController: UITabBarController, willEndCustomizingViewControllers viewControllers: [AnyObject], changed: Bool) {
        
    }
    
    
    func tabBarController(tabBarController: UITabBarController, didEndCustomizingViewControllers viewControllers: [AnyObject], changed: Bool) {
        
    }
    
    
    
    

}