//
//  HYPageControlView.swift
//  ScrollViewDemo
//
//  Created by Harry Yan on 15/1/20.
//  Copyright (c) 2015年  Harry Yan. All rights reserved.
//

import UIKit

class HYPageControlView: UIView {
    
    var pageIndex: Int = 0
    var progress: CGFloat = 0.0
    var numberOfPages: Int = 0
    var pageCount: Int {
        get{
            return numberOfPages
        }
        
        set{
            if numberOfPages != newValue {
                numberOfPages = newValue
                self.setNeedsLayout()
            }
        }
    }
    
    var pageImages:[UIImageView] = []
    
    func setPageNumber(pageCount:Int){
        
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        
        pageImages = []
        for(var i=0;i<pageCount;i++){
            
            var imageView = UIImageView()
            var imageViewY:CGFloat = self.frame.height/2.0 - 3
            var imageViewW:CGFloat = 6;
            var imageViewH:CGFloat = 6;
            var imageViewX:CGFloat = 5 + CGFloat(i) * imageViewW + 9 * CGFloat(i);
            
            imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH)
            
            self.addSubview(imageView)
            if(i==0){
                imageView.image = UIImage(named: "pageControllerPoint")
            }else{
                imageView.image = UIImage(named: "pageControllerOtherPoint")
            }
            pageImages.append(imageView)
            
        }
        
        self.frame.size.width = 10 + CGFloat((pageCount-1)*9) + CGFloat(pageCount*6);
        
        self.frame.origin.x = UIScreen.mainScreen().bounds.width/2  - self.frame.size.width/2;
        
        self.layoutIfNeeded()
        
    }
    
    func setCurrentPage(page:Int){
        var pagecount = page
        
        
        
        if(pagecount < 0 || pagecount > pageImages.count - 1){
            return
        }
        
        for image in pageImages{
            image.image = UIImage(named: "pageControllerOtherPoint")
        }
        
        pageImages[pagecount].image = UIImage(named: "pageControllerPoint")
    }
    
    
    //MARK: Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(white: 0, alpha: 0.3)
        self.layer.cornerRadius = 2
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not suppport")
    }
    
    
    override func layoutSubviews() {
        if (1 >= self.numberOfPages) {
            self.hidden = true;
            return;
        }
        if(numberOfPages > pageImages.count){
            setPageNumber(numberOfPages)
            
        }
        
    }
    
    //MARK: Public
    
    func slideWithProgress(progress: CGFloat) {
        self.progress = progress
        
        var index = self.progress*CGFloat(numberOfPages)
        
        setCurrentPage(index - CGFloat(Int(index)) > 0.5 ? Int(index)+1 : Int(index) )
        
    }
    
    
    
}
