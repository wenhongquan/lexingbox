//
//  UImapChangeView.swift
//  LIC
//
//  Created by 温红权 on 15/5/14.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

typealias CLOSEACTION = () -> Void

typealias CHANGEACTION = (index:Int) -> Void

class UImapChangeView:UIView{


    @IBOutlet weak var topSpace: NSLayoutConstraint!

    @IBOutlet weak var closeButton: UIButton!
    
    
    @IBOutlet weak var statelliteMap: UIButton!
    
    @IBOutlet weak var Map3d: UIButton!
    @IBOutlet weak var Map2d: UIButton!
    
    var closeAction:CLOSEACTION?
    var changeIndex:CHANGEACTION?
    
    var slectedIndex = 1
    
    @IBAction func closeButtonAction(sender: AnyObject) {
        
        closeAction?()
        
    }
    @IBAction func statelliteMapAction(sender: AnyObject) {
        changeIndex?(index: 0)
        setSelectedImage(0)
    }
    
    @IBAction func Map2dAction(sender: AnyObject) {
        changeIndex?(index: 1)
        setSelectedImage(1)
    }
    
    @IBAction func Map3dAction(sender: AnyObject) {
        changeIndex?(index: 2)
        setSelectedImage(2)
    }
    
    func getColor(index:Int)->CGColor{
        if(slectedIndex == index){
            
           return CommonUtil.UIColorFromRGB(0x4584ff).CGColor
        }
        return CommonUtil.UIColorFromRGB(0xf1f1f1).CGColor
    }
    
    
    func setSelectedImage(index:Int){
    
        slectedIndex = index
        drawborder()
    
    }
    
    func drawborder(){
    
        statelliteMap?.layer.cornerRadius = 2
        statelliteMap?.layer.borderColor = getColor(0)
        statelliteMap?.layer.borderWidth = 2
        statelliteMap?.layer.masksToBounds = true
        
        Map3d?.layer.cornerRadius = 2
        Map3d?.layer.borderColor = getColor(2)
        Map3d?.layer.borderWidth = 2
        Map3d?.layer.masksToBounds = true
        
        Map2d?.layer.cornerRadius = 2
        Map2d?.layer.borderColor = getColor(1)
        Map2d?.layer.borderWidth = 2
        Map2d?.layer.masksToBounds = true
    }
    
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.removeFromSuperview()
    }
    
    
    
    override func drawRect(rect: CGRect) {
        drawborder()
    }
}