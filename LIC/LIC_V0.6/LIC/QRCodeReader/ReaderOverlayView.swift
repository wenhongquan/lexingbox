/*
* QRCodeReader.swift
*
* Copyright 2014-present Yannick Loriot.
* http://yannickloriot.com
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*
*/

import UIKit

/// Overlay over the camera view to display the area (a square) where to scan the code
final class ReaderOverlayView: UIView {
  private var overlay = CommonUtil.newLineOverlay()
    
     private var line_1 = CommonUtil.newLineOverlay(0x2bcd9c)
     private var line_2 = CommonUtil.newLineOverlay(0x2bcd9c)
     private var line_3 = CommonUtil.newLineOverlay(0x2bcd9c)
     private var line_4 = CommonUtil.newLineOverlay(0x2bcd9c)
     private var line_5 = CommonUtil.newLineOverlay(0x2bcd9c)
     private var line_6 = CommonUtil.newLineOverlay(0x2bcd9c)
     private var line_7 = CommonUtil.newLineOverlay(0x2bcd9c)
     private var line_8 = CommonUtil.newLineOverlay(0x2bcd9c)
    

    
    
    
    
  
  init() {
	super.init(frame: CGRectZero)  // Workaround for init in iOS SDK 8.3
		
    addtoView()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addtoView()
  }

  required init(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
    
    addtoView()
  }
  
  override func drawRect(rect: CGRect) {


    var recttemp:CGRect = CGRect(x:(rect.size.width - 220) / 2, y: 65, width: 220, height: 220)
    overlay.path  = UIBezierPath(roundedRect: recttemp
      , cornerRadius: 0).CGPath
    
    
    var recttemp1:CGRect = CGRect(x:(rect.size.width - 220) / 2, y: 65, width: 16, height: 2)
    line_1.path  = UIBezierPath(roundedRect: recttemp1
        , cornerRadius: 0).CGPath
    
    var recttemp2:CGRect = CGRect(x:(rect.size.width - 220) / 2, y: 65, width: 2, height: 16)
    line_2.path  = UIBezierPath(roundedRect: recttemp2
        , cornerRadius: 0).CGPath
    
    
    
    
    var recttemp3:CGRect = CGRect(x:(rect.size.width - 220) / 2, y: 65+220-16, width: 2, height: 16)
    line_3.path  = UIBezierPath(roundedRect: recttemp3
        , cornerRadius: 0).CGPath
    
    var recttemp4:CGRect = CGRect(x:(rect.size.width - 220) / 2, y: 65+220-2, width: 16, height: 2)
    line_4.path  = UIBezierPath(roundedRect: recttemp4
        , cornerRadius: 0).CGPath
    
    
    
    
    
    var recttemp5:CGRect = CGRect(x:(rect.size.width - 220) / 2  + 220 - 16, y: 65, width: 16, height: 2)
    line_5.path  = UIBezierPath(roundedRect: recttemp5
        , cornerRadius: 0).CGPath
    
    var recttemp6:CGRect = CGRect(x:(rect.size.width - 220) / 2 + 220 - 2, y: 65, width: 2, height: 16)
    line_6.path  = UIBezierPath(roundedRect: recttemp6
        , cornerRadius: 0).CGPath
    
    
    
    
    var recttemp7:CGRect = CGRect(x:(rect.size.width - 220) / 2 + 220 - 2, y: 65+220-16, width: 2, height: 16)
    line_7.path  = UIBezierPath(roundedRect: recttemp7
        , cornerRadius: 0).CGPath
    
    var recttemp8:CGRect = CGRect(x:(rect.size.width - 220) / 2 + 220 - 16, y: 65+220-2, width: 16, height: 2)
    line_8.path  = UIBezierPath(roundedRect: recttemp8
        , cornerRadius: 0).CGPath
    
    
    
  }
    
    
  func addtoView(){
    
       layer.addSublayer(overlay)

    layer.addSublayer(line_1)
    layer.addSublayer(line_2)
    layer.addSublayer(line_3)
    layer.addSublayer(line_4)
    layer.addSublayer(line_5)
    layer.addSublayer(line_6)
    layer.addSublayer(line_7)
    layer.addSublayer(line_8)
    
    
    self.backgroundColor = UIColor.blueColor()
  }
    
    

    
  
    
}
