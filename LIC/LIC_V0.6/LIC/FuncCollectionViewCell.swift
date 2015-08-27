//
//  FuncCollectionViewCell.swift
//  LIC
//
//  Created by 温红权 on 15/4/29.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class FuncCollectionViewCell :UICollectionViewCell {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var pointView: UIView?
    var disLable: UILabel?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        pointView = UIView()
        pointView?.frame = CGRect(origin: CGPoint(x: 0, y: (frame.size.height/2.0)-2.5), size: CGSize(width: 5, height: 5))
        pointView?.backgroundColor = CommonUtil.UIColorFromRGB(0x2bcd9c)
        pointView?.layer.masksToBounds = true;
        pointView?.layer.cornerRadius = 5.0;
        
        disLable = UILabel()
        disLable?.text = "电动车销售"
        disLable?.font = UIFont.systemFontOfSize(12)
        var size = CGRect();
        var size2 = CGSize();
        size =  disLable!.text!.boundingRectWithSize(size2, options: NSStringDrawingOptions.UsesFontLeading, attributes: nil, context: nil);
        disLable?.frame = CGRect(origin: CGPoint(x: pointView!.frame.size.width + 4, y: (frame.size.height/2.0) - size.height/2.0), size: CGSize(width: size.width, height: size.height) )
        contentView.addSubview(disLable!)
        contentView.addSubview(pointView!)
        
      
        
       
    }
    
    func setDisLableText(text:String){
        var texts = text as NSString
        if(texts as NSString).length>7{
           texts = texts.substringToIndex(5) 
        }
        
        disLable?.text = texts as String
        disLable?.font = UIFont.systemFontOfSize(12)
        var size = CGRect();
        var size2 = CGSize();
        size =  disLable!.text!.boundingRectWithSize(size2, options: NSStringDrawingOptions.UsesFontLeading, attributes: nil, context: nil);
        disLable?.frame = CGRect(origin: CGPoint(x: pointView!.frame.size.width + 4, y: (frame.size.height/2.0) - size.height/2.0), size: CGSize(width: size.width, height: size.height) )
        
        self.frame.size.width = self.pointView!.frame.width + self.disLable!.frame.width + 4
        
        self.frame.size.height = self.disLable!.frame.height
    
    }

   

}