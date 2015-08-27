//
//  CityOfflineMapTableManageCell.swift
//  LIC
//
//  Created by 温红权 on 15/5/13.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class CityOfflineMapTableManageCell: CityOfflineMapTableCell {

    
    @IBOutlet weak var citybackgroundView: UIView!
    var deletehandler:DELETEBUTTONHANDLER?
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        
    }

    
    
}