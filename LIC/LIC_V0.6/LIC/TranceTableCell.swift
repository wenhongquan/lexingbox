//
//  TranceTableCell.swift
//  LIC
//
//  Created by 温红权 on 15/4/23.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class TranceTableCell:UITableViewCell{

    @IBOutlet weak var tranceLengthLable: UILabel!
    @IBOutlet weak var tranceTimeLable: UILabel!
    @IBOutlet weak var tranceStopCount: UILabel!
    @IBOutlet weak var tranceStartTimeLable: UILabel!
    @IBOutlet weak var tanceStopLable: UILabel!
    @IBOutlet weak var tranceBackGroundView: UIView!
    
    @IBOutlet weak var toplineView: UIView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var bottomlineView: UIView!
 
    @IBOutlet weak var bgImage: UIImageView!
    var imagebg:UIImage!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        var top:CGFloat = 32; // 顶端盖高度
        var bottom:CGFloat = 32; // 底端盖高度
        var left:CGFloat = 18; // 左端盖宽度
        var right:CGFloat = 1; // 右端盖宽度
        var insets = UIEdgeInsetsMake(top, left, bottom, right);
        
        imagebg = UIImage(named: "trance_information")
        

        
        imagebg = imagebg?.resizableImageWithCapInsets(insets, resizingMode: UIImageResizingMode.Stretch)

 
       

    }
  

    override func drawRect(rect: CGRect) {
        var rect = lineView.frame
        var gradientLayer = CAGradientLayer(layer: lineView.layer)
        gradientLayer?.frame = CGRect(x: 0, y: 0, width: lineView.frame.size.width, height: lineView.frame.size.height)
        
        gradientLayer?.colors = [UIColor(red: 208/255.0, green: 208/255.0, blue: 208/255.0, alpha: 0).CGColor,UIColor(red: 208/255.0, green: 208/255.0, blue: 208/255.0, alpha: 1).CGColor,UIColor(red: 208/255.0, green: 208/255.0, blue: 208/255.0, alpha: 1).CGColor,UIColor(red: 208/255.0, green: 208/255.0, blue: 208/255.0, alpha: 0).CGColor  ]
        
        gradientLayer?.locations = [0,0.25,0.75,1.0];
        
        gradientLayer?.startPoint = CGPointMake(0, 0);
        gradientLayer?.endPoint = CGPointMake(1, 0);
        lineView.layer.addSublayer(gradientLayer)
        
        
        
        rect = toplineView.frame
        gradientLayer = CAGradientLayer(layer: toplineView.layer)
        gradientLayer?.frame = CGRect(x: 0, y: 0, width: toplineView.frame.size.width, height: toplineView.frame.size.height)
        
        gradientLayer?.colors = [CommonUtil.UIColorFromRGB(0xababab).CGColor, CommonUtil.UIColorFromRGB(0xababab).CGColor ]
        
        gradientLayer?.locations = [0,1];
        
        gradientLayer?.startPoint = CGPointMake(0, 0);
        gradientLayer?.endPoint = CGPointMake(1, 1);
        toplineView.layer.addSublayer(gradientLayer)
        
        
        
        rect = bottomlineView.frame
        gradientLayer = CAGradientLayer(layer: bottomlineView.layer)
        gradientLayer?.frame = CGRect(x: 0, y: 0, width: bottomlineView.frame.size.width, height: bottomlineView.frame.size.height)
        
        gradientLayer?.colors = [CommonUtil.UIColorFromRGB(0xababab).CGColor,CommonUtil.UIColorFromRGB(0xababab).CGColor]
        
        gradientLayer?.locations = [0,1.0];
        
        gradientLayer?.startPoint = CGPointMake(0, 0);
        gradientLayer?.endPoint = CGPointMake(1, 1);
        bottomlineView.layer.addSublayer(gradientLayer)
        
        
        bgImage.image = imagebg
        
    }

    
}