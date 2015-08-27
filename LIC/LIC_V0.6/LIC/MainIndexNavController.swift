//
//  MainIndexNavController.swift
//  LIC
//
//  Created by 温红权 on 15/4/11.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class MainIndexNavController :NavController{
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initItem();
    }
  
    func initItem(){
        var image = UIImage(named: "service_disselect")
        //        image = CommonUtil.resizeImage(image!,scan: 0.5)
        //设置选中时的图标
        var selectedImage = UIImage(named: "service_select")
        //        selectedImage = CommonUtil.resizeImage(selectedImage!,scan: 0.5)
        // 声明这张图片用原图(别渲染)
        selectedImage = selectedImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        self.tabBarItem.selectedImage=selectedImage
        self.tabBarItem.image=image
    }

}