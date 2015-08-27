//
//  SettingIndexController.swift
//  LIC
//
//  Created by 温红权 on 15/3/11.
//  Copyright (c) 2015年 乐行天下. All rights reserved.
//

import UIKit

class SettingIndexController: NavController {
    

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initItem();
        
    
        
    }
    
    
    func initItem(){
        
        //        indexMianItem.barStyle = .BlackTranslucent
        //        indexMianItem.translucent = true;
        //        indexMianItem.tintColor = UIColor.greenColor()
        var image = UIImage(named: "more_unselect");
//        image = CommonUtil.resizeImage(image!,scan: 0.5)
        //设置选中时的图标
        var selectedImage = UIImage(named: "more_select");
//        selectedImage = CommonUtil.resizeImage(selectedImage!,scan: 0.5)
        
        // 声明这张图片用原图(别渲染)
        
        selectedImage = selectedImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
        
        self.tabBarItem.selectedImage=selectedImage;
        
        self.tabBarItem.image=image;
        
        
      
        
        
    }
 

    
}

