//
//  UIActionSheetExt.swift
//  LIC
//
//  Created by 温红权 on 15/5/12.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

typealias sheetbuttonsHandel = () -> Void

class UIActionSheetExt:UIActionSheet {
    
    var handles:[sheetbuttonsHandel]? = []
    
    
}