//
//  TableCellController.swift
//  LIC
//
//  Created by 温红权 on 15/4/7.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class TableCellController:UITableViewCell{

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBOutlet weak var numberButton: UIButton!
    @IBOutlet weak var discribtionLable: UILabel!
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var images: UIImageView!
    @IBOutlet weak var buttonWidth: NSLayoutConstraint!
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
 
    override func drawRect(rect: CGRect) {
        
        var context = UIGraphicsGetCurrentContext();
//        CGContextFillRect(context, rect);
        CGContextSetStrokeColorWithColor(context, CommonUtil.UIColorFromRGB(0xd9d9d9).CGColor);
        CGContextStrokeRect(context, CGRectMake(10, rect.size.height, rect.size.width - 10, 1));
    }


}