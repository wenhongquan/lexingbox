//
//  EbickIndexController.swift
//  LIC
//
//  Created by 温红权 on 15/3/11.
//  Copyright (c) 2015年 乐行天下. All rights reserved.
//

import UIKit

class EbickIndexNavController: NavController {


    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initItem();
    }

 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
    }
    
    override func viewWillLayoutSubviews() {
       
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initItem(){
        
        //        indexMianItem.barStyle = .BlackTranslucent
        //        indexMianItem.translucent = true;
        //        indexMianItem.tintColor = UIColor.greenColor()
        var image = UIImage(named: "index_ebick");
        //        image = CommonUtil.resizeImage(image!,scan: 0.5)
        //设置选中时的图标
        var selectedImage = UIImage(named: "index_ebick_selected");
        //        selectedImage = CommonUtil.resizeImage(selectedImage!,scan: 0.5)
        
        // 声明这张图片用原图(别渲染)
        
        selectedImage = selectedImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
        
        self.tabBarItem.selectedImage=selectedImage;
        
        self.tabBarItem.image=image;
        
    }


}

