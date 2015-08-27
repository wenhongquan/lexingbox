// RMParallax
//
// Copyright (c) 2015 RMParallax
//
// Created by Raphael Miller & Michael Babiy
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

/**
*  Completion handler for dismissal of the parallax view.
*/
typealias RMParallaxCompletionHandler = () -> Void

enum ScrollDirection: Int {
    case Right = 0, Left
}

enum Types: Int {
    case Normal = 0,None,Connect = 2
}


let rm_text_span_width: CGFloat = 320.0
let rm_percentage_multiplier: CGFloat = 0.4
let rm_percentage_multiplier_text: CGFloat = 0.8

let rm_motion_frame_offset: CGFloat = 15.0
let rm_motion_magnitude: CGFloat = rm_motion_frame_offset / 3.0

import UIKit

class RMParallax : UIViewController, UIScrollViewDelegate {
    
    //    var longinHandler: RMParallaxCompletionHandler!
    
    var registerHandler: RMParallaxCompletionHandler!
    
    var loginHandler:RMParallaxCompletionHandler!
    
    var backHandler:RMParallaxCompletionHandler!
    
    var items: [RMParallaxItem]!
    var motion = false
    
    var types:Types = Types.Normal
    
    
    var scrollView: UIScrollView!
    var dismissButton: UIButton!
    
    var loginButton:UIButton!
    
    var registButton:UIButton!
    
    var flowinlexing:UIButton!
    
    var backButton:UIButton!
    
    var lable1:UIImageView!
    var lable2:UIImageView!
    var lable3:UIImageView!
    
    var currentPageNumber = 0
    var otherPageNumber = 0
    var viewWidth: CGFloat = 0.0
    var lastContentOffset: CGFloat = 0.0
    
    var image_white:UIImage! = UIImage(named: "guide_white")
    
    var image_black:UIImage! = UIImage(named: "guide_black")
    
    /**
    *  Designated initializer.
    *
    *  @param items  - an array of RMParallaxItems to page through.
    *  @param motion - if set to TRUE, a very subtle motion effect will be added to the image view.
    */
    required init(items: [RMParallaxItem], motion: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.items = items
        self.motion = motion
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("Use init with items, motion.")
    }
    
    
    
    // MARK : Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRMParallax()
        self.scrollView.scrollsToTop = false;
        //        self.scrollView.directionalLockEnabled = true;
    }
    
    // MARK : Setup
    
    func setupRMParallax() {
        
        if(types == Types.Connect){
            
            image_white = UIImage(named: "guide_white_old")
            image_black = UIImage(named: "guide_black_old")
            
        }
        
        
        self.view.backgroundColor = CommonUtil.UIColorFromRGB(0xfafafa)

        if(types == Types.Connect){
            self.loginButton=UIButton(frame: CGRectMake(self.view.frame.size.width / 2.0 + 10, self.view.frame.size.height - 78, 100, 36))
            self.registButton=UIButton(frame: CGRectMake(self.view.frame.size.width / 2.0 - 110, self.view.frame.size.height - 78, 100, 36))
            
            self.registButton.setTitle("立即购买", forState:UIControlState.Normal)
            self.loginButton.setTitle("首次连接", forState:UIControlState.Normal)
            
            
            loginButton=CommonUtil.buttonSetImage(loginButton,name:"remove_devicebtn",states:[UIControlState.Selected,UIControlState.Normal,UIControlState.Highlighted])
            registButton=CommonUtil.buttonSetImage(registButton,name:"remove_devicebtn",states:[UIControlState.Selected,UIControlState.Normal,UIControlState.Highlighted,UIControlState.Disabled])
            
            loginButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
            loginButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
            registButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
            registButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
            
            loginButton.setTitleColor(CommonUtil.UIColorFromRGB(0x2bcd9c), forState: UIControlState.Normal)
            registButton.setTitleColor(CommonUtil.UIColorFromRGB(0x2bcd9c), forState: UIControlState.Normal)
            
            self.backButton=UIButton(frame: CGRectMake(10, 10, 32, 32))
            
            backButton.setImage(UIImage(named: "launchback"), forState: UIControlState.Normal)
            
            
        }
        
        
        if(types == Types.Connect){
        
            self.lable1=UIImageView(frame: CGRectMake(self.view.frame.size.width / 2.0 - 27, self.view.frame.size.height - 100, 10, 10))
            self.lable2=UIImageView(frame: CGRectMake(self.view.frame.size.width / 2.0 - 5, self.view.frame.size.height - 100, 10, 10))
            self.lable3=UIImageView(frame: CGRectMake(self.view.frame.size.width / 2.0 + 17, self.view.frame.size.height - 100, 10, 10))
        
        }else{
            
            if(self.view.frame.size.height<568){
            
                self.lable2=UIImageView(frame: CGRectMake(self.view.frame.size.width / 2.0 - 7/2.0, self.view.frame.size.height - 32, 7, 7))
                self.lable1=UIImageView(frame: CGRectMake(self.view.frame.size.width / 2.0 - 16 - 7/2.0, self.view.frame.size.height - 32, 7, 7))
                self.lable3=UIImageView(frame: CGRectMake(self.view.frame.size.width / 2.0 + 9 + 7/2.0, self.view.frame.size.height - 32, 7, 7))

            
            }else{
            
                self.lable2=UIImageView(frame: CGRectMake(self.view.frame.size.width / 2.0 - 7/2.0, self.view.frame.size.height - 60, 7, 7))
                self.lable1=UIImageView(frame: CGRectMake(self.view.frame.size.width / 2.0 - 16 - 7/2.0, self.view.frame.size.height - 60, 7, 7))
                self.lable3=UIImageView(frame: CGRectMake(self.view.frame.size.width / 2.0 + 9 + 7/2.0, self.view.frame.size.height - 60, 7, 7))

            }
            
            
        }
        
        
        
        self.lable1.image=image_black
        self.lable2.image=image_white
        self.lable3.image=image_white
        
        if(types == Types.Connect){
            
            
            self.loginButton.addTarget(self, action: "loginButtonSelected:", forControlEvents: UIControlEvents.TouchUpInside)
            self.registButton.addTarget(self, action: "registerButtonSelected:", forControlEvents: UIControlEvents.TouchUpInside)
            
            if(types == Types.Connect){
                self.backButton.addTarget(self, action: "backbuttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            }
            
        }
        
        
        self.scrollView = UIScrollView(frame: self.view.frame)
        self.scrollView.showsHorizontalScrollIndicator = false;
        self.scrollView.pagingEnabled = true;
        self.scrollView.delegate = self;
        self.scrollView.bounces = false;
        
        self.scrollView.backgroundColor = CommonUtil.UIColorFromRGB(0xfafafa)
        
        self.viewWidth = self.view.frame.size.width
        
        self.view.addSubview(self.scrollView)
        
        if(types == Types.Connect){
            
            
            self.view.insertSubview(self.loginButton, aboveSubview: self.scrollView)
            
            self.view.insertSubview(self.registButton, aboveSubview: self.scrollView)
            
            if(types == Types.Connect){
                self.view.insertSubview(self.backButton, aboveSubview: self.scrollView)
                
            }
        }
        self.view.insertSubview(self.lable1, aboveSubview: self.scrollView)
        self.view.insertSubview(self.lable2, aboveSubview: self.scrollView)
        self.view.insertSubview(self.lable3, aboveSubview: self.scrollView)
        
        
        for (index, item) in enumerate(self.items) {
            if(types == Types.Connect){
                self.scrollView.addSubview(getView(index+1,item:item))
            }
            if(types == Types.None||types == Types.Normal){
                self.scrollView.addSubview(getView(index,item:item))
            }
        }
        
        if(types == Types.Connect){
            self.scrollView.addSubview(getView(0,item:items[items.count-1]))
            self.scrollView.addSubview(getView(items.count+1,item:items[0]))
            
            
            self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * CGFloat(self.items.count+2), self.view.frame.size.height)
            
            self.scrollView.scrollRectToVisible(CGRect(x: self.view.frame.size.width, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), animated: false)
        }
        if(types == Types.None||types == Types.Normal){
            
            self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * CGFloat(self.items.count), self.view.frame.size.height)
            
            self.scrollView.scrollRectToVisible(CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), animated: false)
            
        }
    }
    
    
    func getView(index:Int,item:RMParallaxItem) -> UIView{
        
        
        let diff: CGFloat = 0.0
        let frame = CGRectMake((self.view.frame.size.width * CGFloat(index)), 0.0, self.viewWidth, self.view.frame.size.height)
        let subview = UIView(frame: frame)
        
        let internalScrollView = UIScrollView(frame: CGRectMake(diff, 0.0, self.viewWidth - (diff * 2.0), self.view.frame.size.height))
        internalScrollView.scrollEnabled = false
        
        let internalTextScrollView = UIScrollView(frame: CGRectMake(diff, 0.0, self.viewWidth - (diff * 2.0), self.view.frame.size.height))
        internalTextScrollView.scrollEnabled = false
        internalTextScrollView.backgroundColor = UIColor.clearColor()
        
        //
        
        var imageViewFrame = self.motion ?
            CGRectMake(self.view.frame.size.width/2.0 - 270/2.0, 60, 270 , 270 ) :
            CGRectMake(self.view.frame.size.width/2.0 - 270/2.0, 60, 270 , 270 )
        
        if(types == Types.Connect){
            
            
            imageViewFrame = self.motion ?
                CGRectMake(0.0, 0.0, internalScrollView.frame.size.width , self.view.frame.size.height ) :
                CGRectMake(0.0, 0.0, internalScrollView.frame.size.width, self.view.frame.size.height)
        
        }else{
        
            
            if(self.view.frame.size.height<568){
                
                imageViewFrame = self.motion ?
                    CGRectMake(self.view.frame.size.width/2.0 - 270/2.0, 14, 270 , 270 ) :
                    CGRectMake(self.view.frame.size.width/2.0 - 270/2.0, 14, 270 , 270 )
                
            }
        
        }
        
        
        
        
        let imageView = UIImageView(frame: imageViewFrame)
        if self.motion { self.addMotionEffectToView(imageView, magnitude: rm_motion_magnitude) }
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        internalScrollView.tag = (index + 1) * 10
        internalTextScrollView.tag = (index + 1) * 100
        imageView.tag = (index + 1) * 1000
        
        //
        
        let attributes = [NSFontAttributeName : UIFont.systemFontOfSize(30.0)]
        let context = NSStringDrawingContext()
        let rect = (item.text as NSString).boundingRectWithSize(CGSizeMake(rm_text_span_width, CGFloat.max),
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: attributes,
            context: context)
        
        //
        
       
        
        
        var textView = UITextView(frame: CGRectMake(0.0, 330, frame.size.width, 40))
        textView.text = item.text
        textView.textColor = CommonUtil.UIColorFromRGB(0x2bcd9c)
        textView.textAlignment = NSTextAlignment.Center
        textView.backgroundColor = UIColor.clearColor()
        textView.userInteractionEnabled = false
        
        
        var textView1 = UITextView(frame: CGRectMake(0.0, 369, frame.size.width, 30))
        textView1.text = item.text1
        textView1.textColor = CommonUtil.UIColorFromRGB(0x666666)
        textView1.textAlignment = NSTextAlignment.Center
        textView1.backgroundColor = UIColor.clearColor()
        textView1.userInteractionEnabled = false
        
        
        var textView2 = UITextView(frame: CGRectMake(0.0, 392, frame.size.width, 30))
        textView2.text = item.text2
        textView2.textColor = CommonUtil.UIColorFromRGB(0x666666)
        textView2.textAlignment = NSTextAlignment.Center
        textView2.backgroundColor = UIColor.clearColor()
        textView2.userInteractionEnabled = false
        
        
        if(types == Types.Connect){
            
            textView.frame = CGRectMake(0.0, self.view.frame.size.height - 174, frame.size.width, 40)
            textView1.frame = CGRectMake(0.0, self.view.frame.size.height - 137, frame.size.width, 30)
           
        }else{
        
            if(self.view.frame.size.height<568){
        
                textView.frame = CGRectMake(0.0, 298, frame.size.width, 40)
                textView1.frame = CGRectMake(0.0, 328, frame.size.width, 30)
                textView2.frame = CGRectMake(0.0, 347, frame.size.width, 30)
            
            }
        
        
        }
        
        
        
        imageView.image = item.image
        textView.font = UIFont.systemFontOfSize(27)
        textView1.font = UIFont.systemFontOfSize(15)
        textView2.font = UIFont.systemFontOfSize(18)
        if(types == Types.Connect){
            textView.font = UIFont.systemFontOfSize(23)
            textView1.font = UIFont.systemFontOfSize(15)
        }else{
            
            if(self.view.frame.size.height<568){
                textView.font = UIFont.systemFontOfSize(24)
                textView1.font = UIFont.systemFontOfSize(13)
                textView2.font = UIFont.systemFontOfSize(14)
            
            }
            
            internalTextScrollView.addSubview(textView2)
            internalScrollView.bringSubviewToFront(textView2)
        
        }
        
        
        
        internalTextScrollView.addSubview(textView)
        internalScrollView.bringSubviewToFront(textView)
        
        internalTextScrollView.addSubview(textView1)
        internalScrollView.bringSubviewToFront(textView1)
        
        
        
        
        
        if(types == Types.Normal && (index == items.count - 1 )){
           
            self.flowinlexing=UIButton(frame: CGRectMake(self.view.frame.size.width / 2.0 - 115/2.0, self.view.frame.size.height - 85 - 36, 115, 36))
            
            
            if(self.view.frame.size.height<568){
                self.flowinlexing=UIButton(frame: CGRectMake(self.view.frame.size.width / 2.0 - 115/2.0, self.view.frame.size.height - 91, 115, 36))
                
            }
            
            self.flowinlexing.setTitle("立即体验", forState:UIControlState.Normal)
            self.flowinlexing.titleLabel?.font = UIFont.systemFontOfSize(20)
            
            
            flowinlexing=CommonUtil.buttonSetImage(flowinlexing,name:"tiyan",states:[UIControlState.Selected,UIControlState.Normal,UIControlState.Highlighted,UIControlState.Disabled],radio:18)
            
            flowinlexing.setTitleColor(CommonUtil.UIColorFromRGB(0xff4a00), forState: UIControlState.Normal)
            flowinlexing.setTitleColor(CommonUtil.UIColorFromRGB(0xffffff), forState: UIControlState.Selected)
            flowinlexing.setTitleColor(CommonUtil.UIColorFromRGB(0xffffff), forState: UIControlState.Highlighted)
            
            self.flowinlexing.addTarget(self, action: "flowinlexingBox:", forControlEvents: UIControlEvents.TouchUpInside)
            
            internalTextScrollView.addSubview(flowinlexing)
            internalScrollView.bringSubviewToFront(flowinlexing)
            
        }

        
        if(types == Types.None  && index == items.count - 1){
            
            
            self.flowinlexing=UIButton(frame: CGRectMake(self.view.frame.size.width / 2.0 - 100/2.0, self.view.frame.size.height - 85 - 36, 100, 36))
            
            
            if(self.view.frame.size.height<568){
                self.flowinlexing=UIButton(frame: CGRectMake(self.view.frame.size.width / 2.0 - 100/2.0, self.view.frame.size.height - 91, 100, 36))
                
            }
            
            
                self.flowinlexing.setTitle("进入乐行宝", forState:UIControlState.Normal)
                self.flowinlexing.titleLabel?.font = UIFont.systemFontOfSize(14)
                
                
                flowinlexing=CommonUtil.buttonSetImage(flowinlexing,name:"greenbigbtn",states:[UIControlState.Selected,UIControlState.Normal,UIControlState.Highlighted,UIControlState.Disabled])
                
                flowinlexing.setTitleColor(CommonUtil.UIColorFromRGB(0xffffff), forState: UIControlState.Normal)
                
                self.flowinlexing.addTarget(self, action: "flowinlexingBox:", forControlEvents: UIControlEvents.TouchUpInside)
                
                internalTextScrollView.addSubview(flowinlexing)
                internalScrollView.bringSubviewToFront(flowinlexing)
            
        }
        
        
        internalScrollView.addSubview(imageView)
        internalScrollView.addSubview(internalTextScrollView)
        
        subview.addSubview(internalScrollView)
        
        return subview
    }
    
    
    
    
    
    
    // MARK : Action Functions
    
    func loginButtonSelected(sender: UIButton) {
        self.loginHandler()
    }
    
    func backbuttonAction(sender: UIButton) {
        self.backHandler()
    }
    
    func registerButtonSelected(sender: UIButton) {
        self.registerHandler()
    }
    func flowinlexingBox(sender: UIButton){
        if(types == Types.Normal){
            var sb = UIStoryboard(name: "Main", bundle:nil)
            
            var vc = sb.instantiateViewControllerWithIdentifier("maintab") as! UIViewController
            
            CommonUtil.transitionWithType(kCATransitionFade, withSubType: kCATransitionFromLeft, forView: self.view.window!)
            
            self.presentViewController(vc, animated: false, completion: nil)
        }
        
        if(types == Types.None){
            CommonUtil.transitionWithType(kCATransitionFade, withSubType: kCATransitionFromLeft, forView: self.view.window!)
            
            self.dismissViewControllerAnimated(false, completion: nil)
       
        }
    }
    
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        
        
        self.currentPageNumber = Int((scrollView.contentOffset.x+self.view.frame.size.width/2) / scrollView.frame.size.width)
        
        
        
        
        
        self.lable1.image=image_white
        self.lable2.image=image_white
        self.lable3.image=image_white
        
        if(types == Types.None||types == Types.Normal){
            switch(self.currentPageNumber)
            {
            case 0 :
                self.lable1.image=image_black
                
                break;
            case 1 :
                self.lable2.image=image_black
                
                break;
            case 2 :
                self.lable3.image=image_black
                
                break;
                
            default:
                break
                
            }
            
            
        }
        if(types == Types.Connect){
            switch(self.currentPageNumber)
            {
            case 0 :
                self.lable3.image=image_black
                
                break;
            case 1 :
                self.lable1.image=image_black
                
                break;
            case 2 :
                self.lable2.image=image_black
                
                break;
                
            case 3 :
                self.lable3.image=image_black
                
                break;
            case 4 :
                self.lable1.image=image_black
                
                break;
            default:
                break
                
            }
            
        }
        
        
    }
    
    // MARK : UIScrollViewDelegate
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        self.currentPageNumber = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        
        if(types == Types.Normal||types == Types.Connect){
            
            if (currentPageNumber==0)
            {
                var data = CGFloat(self.items.count) * self.view.frame.size.width
                
                var rect = CGRect(x: data, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                
                self.scrollView.scrollRectToVisible(rect, animated: false)
                
            }
            else if (currentPageNumber == (self.items.count+1))
            {
                self.scrollView.scrollRectToVisible(CGRectMake(self.view.frame.size.width,0,self.view.frame.size.width,self.view.frame.size.height), animated: false)
                
            }
            
        }
        
        
        
        
        
        //        var  currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.size.width);
        //    int currentPage_ = (int)self.scrollView.contentOffset.x/320; // 和上面两行效果一样
        //    NSLog(@"currentPage_==%d",currentPage_);
        //        if (currentPage==0)
        //        {
        //            [self.scrollView scrollRectToVisible:CGRectMake(320 * [slideImages count],0,320,460) animated:NO]; // 序号0 最后1页
        //        }
        //        else if (currentPage==([slideImages count]+1))
        //        {
        //            [self.scrollView scrollRectToVisible:CGRectMake(320,0,320,460) animated:NO]; // 最后+1,循环第1页
        //        }
        
        //        println(currentPage)
        //
        
        
        
    }
    
    
    
    // MARK : Motion Effects
    
    func addMotionEffectToView(view: UIView, magnitude: CGFloat) -> Void {
        
        let xMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: UIInterpolatingMotionEffectType.TiltAlongHorizontalAxis)
        let yMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: UIInterpolatingMotionEffectType.TiltAlongVerticalAxis)
        xMotion.minimumRelativeValue = (-magnitude)
        xMotion.maximumRelativeValue = (magnitude)
        yMotion.minimumRelativeValue = (-magnitude)
        yMotion.maximumRelativeValue = (magnitude)
        let motionGroup = UIMotionEffectGroup()
        motionGroup.motionEffects = [xMotion, yMotion]
        view.addMotionEffect(motionGroup)
    }
}
