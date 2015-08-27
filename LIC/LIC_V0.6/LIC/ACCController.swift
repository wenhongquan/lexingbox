//
//  ACCController.swift
//  LIC
//
//  Created by 温红权 on 15/5/15.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class ACCController:BaseController,BackButtonHandlerProtocol{


    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var start1Button: UIButton!
    @IBOutlet weak var start2Button: UIButton!
    @IBOutlet weak var checkingNextButton: UIButton!
    @IBOutlet weak var error1Button: UIButton!
    @IBOutlet weak var error2Button: UIButton!
    @IBOutlet weak var error2TelButton: UIButton!
    @IBOutlet weak var successButton: UIButton!
    
    
    @IBOutlet weak var startView: UIView!
    @IBOutlet weak var start1View: UIView!
    @IBOutlet weak var start2View: UIView!
    @IBOutlet weak var checkingView: UIView!
    @IBOutlet weak var error1View: UIView!
    @IBOutlet weak var error2View: UIView!
    @IBOutlet weak var successView: UIView!
    
    
    @IBOutlet weak var start1Image: UIImageView!
    @IBOutlet weak var start2Image: UIImageView!
    @IBOutlet weak var checkingImage: UIImageView!
    
    @IBOutlet weak var start1Lable1: UILabel!
    @IBOutlet weak var start1Lable2: UILabel!
    @IBOutlet weak var start2Lable1: UILabel!
    @IBOutlet weak var start2Lable2: UILabel!
    
    
    private var start1ViewLayer:UIView?
    private var start2ViewLayer:UIView?
    private var checkingViewLayer:UIView?
    
    private var start1ViewLayerheader:CAGradientLayer?
    private var start2ViewLayerheader:CAGradientLayer?
    private var checkingViewLayerheader:CAGradientLayer?

    
    var appearViews:[UIView] = []
    var looper:CADisplayLink?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()

    }
    
    var  duration:CFTimeInterval?;
    var  timeOffset:CFTimeInterval?;
    var  lastStep:CFTimeInterval?;
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        appearViews.append(startView)
        
        backup = false
        
        looper?.invalidate()
        looper = CADisplayLink(target: self, selector: Selector("drawLine:"))
        looper?.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
        lastStep = CACurrentMediaTime()
        
        if(Cache.GPSINFO.status == 0 || !BaseString.NetWorkEnable){
            errorIndex = 1
        }
        
        isstart = false
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        appearViews = []
        
        looper?.invalidate()
    }
    
    override func networkDisable() {
        super.networkDisable()
        errorIndex = 1
        
        if(isstart){
            appearView(error1View)
        }
        
    }
    
    override func webSocketMessageHandler(message: String) {
        super.webSocketMessageHandler(message)
        if( message.contains("gpsStatus")){
            
            var data:JSON = JSON(data:(message as NSString).dataUsingEncoding(NSUTF8StringEncoding)! )
        
                if(data["gpsStatus"]["id"].int == Cache.EBICK.gpsId){
                    //离线
                    if(data["gpsStatus"]["status"].int == 0){
                       
                        errorIndex = 1
                        
                        if(isstart){
                           appearView(error1View)
                        }
                    }
                    
                    if(data["gpsStatus"]["status"].int == 1){
                    
                      errorIndex = 2
                    }
                }
        }
        
        if( message.contains("gps")){
            
            var data:JSON = JSON(data:(message as NSString).dataUsingEncoding(NSUTF8StringEncoding)! )
            
            if(data["gps"]["accessAccFlag"].int == 1 ){
                errorIndex = 0
                
                if(appearViews[appearViews.count-1] == checkingView){
                
                    if(isstart){
                        appearView(successView)
                    }
                }
            }
        }
        

    }
    
    var errorIndex = 2 // 0--success  1--error1  2--error2

    var isstart = false
    
    
    func appearView(view:UIView){
    
        if(appearViews.count <= 2){
          appearViews.append(view)
        }
        if(appearViews.count > 2){
            
            for var i = 0;i<appearViews.count-2;i++ {
                appearViews.removeAtIndex(0)
            }
        }
        
        //隐藏所有view
        startView.hidden = true
        start1View.hidden = true
        start2View.hidden = true
        checkingView.hidden = true
        error1View.hidden = true
        error2View.hidden = true
        successView.hidden = true

       
        
        if(appearViews[0] != start1View ){
        
            self.start1ViewLayer?.frame.size.width = 0
            self.start1ViewLayerheader?.position.x = 0
            start1Image.layoutIfNeeded()
            start1Lable2.text = "数据传输中..."
            
            self.start1Lable1.hidden = false
            self.start1Lable2.hidden = true
            self.start1Button.enabled = true
        }
        
        if(appearViews[0] != start2View ){
            self.start2ViewLayer?.frame.size.width = 0
            self.start2ViewLayerheader?.position.x = 0
            start2Image.layoutIfNeeded()
            start2Lable2.text = "数据传输中..."
            
            self.start2Lable1.hidden = false
            self.start2Lable2.hidden = true
            self.start2Button.enabled = true
            
        }
        
        if(appearViews[0] != checkingView ){
            self.checkingViewLayer?.frame.size.width = 0
            self.checkingViewLayerheader?.position.x = 0
            checkingImage.layoutIfNeeded()
           
            
        }
        
        if( view == checkingView ){
            checkingOn = true
            checkingLineWidth = 0
            self.checkingViewLayer?.frame.size.width = 0
            self.checkingViewLayerheader?.position.x = 0
        }
        
        self.view.sendSubviewToBack(appearViews[0])
        self.view.bringSubviewToFront(view)
       
        //显示view
        for view:UIView in appearViews {
            view.hidden = false
        }

        //跳转
        CommonUtil.transitionWithType(kCATransitionMoveIn, withSubType: kCATransitionFromRight, forView: view)
        
        
        
    }

    
    var start1LineWidth:CGFloat = 0
    var start2LineWidth:CGFloat = 0
    var checkingLineWidth:CGFloat = 0
    
    var start1On = false
    var start2On = false
    var checkingOn = false
    
    func backToview(){
        if(appearViews[0] == startView){
           appearView(start2View)
           return
        }
        
        if(appearViews[0] == start1View){
            
            appearView(checkingView)
            return
        }
        
        if(appearViews[0] == start2View){
            if(errorIndex == 0){
             appearView(successView)
            }else{
                if(errorIndex == 1){
                  appearView(error1View)
                }else{
                  appearView(error2View)
                }
            
            }
           return
        }

    }
    
    
    func drawLine(link:CADisplayLink) -> Void {
        
        var thisStep = CACurrentMediaTime()
        var stepDuration1 = thisStep - self.lastStep!;
        self.lastStep = thisStep;
        
        // 一直绘制
    
        if(start1On){
            
            start1LineWidth = start1LineWidth + ( CGFloat(stepDuration1 / (20.0)) ) * start1Image.frame.width
            
            CATransaction.begin()
            CATransaction.setAnimationDuration(0)
            self.start1ViewLayer?.frame.size.width = start1LineWidth
            self.start1ViewLayerheader?.position.x = start1LineWidth
            start1Image.layoutIfNeeded()
            CATransaction.commit()
            
            if( start1LineWidth >= start1Image.frame.width ){
              start1On = false
              start1LineWidth = 0
              start1Lable2.text = "完成，正在进入下一步..."
                
              // 达到累计量跳转
              NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("backToview"), userInfo: nil, repeats: false)
            }
            

        }
        
        if(start2On){
            
            start2LineWidth = start2LineWidth + ( CGFloat(stepDuration1 / (20.0)) ) * start2Image.frame.width
            
            CATransaction.begin()
            CATransaction.setAnimationDuration(0)
            self.start2ViewLayer?.frame.size.width = start2LineWidth
            self.start2ViewLayerheader?.position.x = start2LineWidth
            start2Image.layoutIfNeeded()
            CATransaction.commit()
            
            if( start2LineWidth >= start2Image.frame.width ){
                start2On = false
                start2LineWidth = 0
                start2Lable2.text = "完成，正在进入下一步..."
                // 达到累计量跳转
                NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("backToview"), userInfo: nil, repeats: false)
            }
            
        }
        
        
        if(checkingOn){
            if(errorIndex != 2){
               checkingLineWidth = checkingLineWidth + ( CGFloat(stepDuration1 / (5.0)) ) * checkingImage.frame.width
            }else{
               checkingLineWidth = checkingLineWidth + ( CGFloat(stepDuration1 / (60.0)) ) * checkingImage.frame.width
            }
            
            
            CATransaction.begin()
            CATransaction.setAnimationDuration(0)
            self.checkingViewLayer?.frame.size.width = checkingLineWidth
            self.checkingViewLayerheader?.position.x = checkingLineWidth
            checkingImage.layoutIfNeeded()
            CATransaction.commit()
            
            if( checkingLineWidth >= checkingImage.frame.width ){
                checkingOn = false
                checkingLineWidth = 0
                // 达到累计量跳转
                
               NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("backToview"), userInfo: nil, repeats: false)
                
                
            }

        }
        
        
        
        
        
        
    }
    
    
   
    @IBAction func startAction(sender: AnyObject) {
    
        isstart = true
        if(errorIndex == 1){
           appearView(error1View)
           return
        }
        
        if(errorIndex == 0){
            appearView(successView)
            return
        }
        
       GpsService.sharedGpsService.SetGPSACC(Cache.GPSINFO.id!,status:1)
       appearView(start1View)
    }
    @IBAction func start1buttonActon(sender: AnyObject) {
        start1On = true
        start1LineWidth = 0
        self.start1ViewLayer?.frame.size.width = 0
        self.start1ViewLayerheader?.position.x = 0
       
        self.start1Lable1.hidden = true
        self.start1Lable2.hidden = false
        self.start1Button.enabled = false
        
    }
    @IBAction func start2buttonAction(sender: AnyObject) {
        start2On = true
        start2LineWidth = 0
        self.start2ViewLayer?.frame.size.width = 0
        self.start2ViewLayerheader?.position.x = 0
        
        self.start2Lable1.hidden = true
        self.start2Lable2.hidden = false
        self.start2Button.enabled = false
    }
    @IBAction func error1buttonAction(sender: AnyObject) {
       isstart = false
       appearView(startView)
    }
    @IBAction func error2buttonAction(sender: AnyObject) {
       isstart = false
       appearView(startView)
    }
    @IBAction func successButtonAction(sender: AnyObject) {
        self.close()
    }
    @IBAction func error2buttonTelAction(sender: AnyObject) {
        CommonUtil.alertCustomService(self)
    }

    
    func initUI(){
    
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        
        startButton=CommonUtil.buttonSetImage(startButton,name:"greenbigbtn1",states:[UIControlState.Selected,UIControlState.Normal,UIControlState.Highlighted,UIControlState.Disabled])
        start1Button=CommonUtil.buttonSetImage(start1Button,name:"greenbigbtn1",states:[UIControlState.Selected,UIControlState.Normal,UIControlState.Highlighted,UIControlState.Disabled])
        start2Button=CommonUtil.buttonSetImage(start2Button,name:"greenbigbtn1",states:[UIControlState.Selected,UIControlState.Normal,UIControlState.Highlighted,UIControlState.Disabled])
        checkingNextButton=CommonUtil.buttonSetImage(checkingNextButton,name:"greenbigbtn1",states:[UIControlState.Selected,UIControlState.Normal,UIControlState.Highlighted,UIControlState.Disabled])
        error1Button=CommonUtil.buttonSetImage(error1Button,name:"whritebutton",states:[UIControlState.Selected,UIControlState.Normal,UIControlState.Highlighted])
        error2Button=CommonUtil.buttonSetImage(error2Button,name:"whritebutton",states:[UIControlState.Selected,UIControlState.Normal,UIControlState.Highlighted])
        error2TelButton=CommonUtil.buttonSetImage(error2TelButton,name:"whritebutton",states:[UIControlState.Selected,UIControlState.Normal,UIControlState.Highlighted])
        successButton=CommonUtil.buttonSetImage(successButton,name:"greenbigbtn1",states:[UIControlState.Selected,UIControlState.Normal,UIControlState.Highlighted,UIControlState.Disabled])
        
        
        
        
        
        start1ViewLayer = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 180))
        start1ViewLayer?.backgroundColor = CommonUtil.UIColorFromRGBA(0x2bcd9c, alpha: 0.6)
        
        start2ViewLayer = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 180))
        start2ViewLayer?.backgroundColor = CommonUtil.UIColorFromRGBA(0x2bcd9c, alpha: 0.6)

        
        
        checkingViewLayer = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 180))
        checkingViewLayer?.backgroundColor = CommonUtil.UIColorFromRGBA(0x2bcd9c, alpha: 0.6)
        
        
        start1Image?.addSubview(start1ViewLayer!)
        start2Image?.addSubview(start2ViewLayer!)
        checkingImage?.addSubview(checkingViewLayer!)
        
        
        start1ViewLayerheader = CAGradientLayer(layer: start1Image?.layer)
        start1ViewLayerheader?.frame = CGRect(x:0, y: 0, width: 2, height: 180 )
        start1ViewLayerheader?.locations = [0,0.5,1.0];
        start1ViewLayerheader?.startPoint = CGPointMake(0, 0);
        start1ViewLayerheader?.endPoint = CGPointMake(1, 0);
        start1ViewLayerheader?.colors = [CommonUtil.UIColorFromRGBA(0xffffff, alpha: 0).CGColor,CommonUtil.UIColorFromRGBA(0xffffff, alpha: 1).CGColor,CommonUtil.UIColorFromRGBA(0xffffff, alpha: 0).CGColor  ]
        
        start2ViewLayerheader = CAGradientLayer(layer: start2Image?.layer)
        start2ViewLayerheader?.frame = CGRect(x:0, y: 0, width: 2, height: 180 )
        start2ViewLayerheader?.locations = [0,0.5,1.0];
        start2ViewLayerheader?.startPoint = CGPointMake(0, 0);
        start2ViewLayerheader?.endPoint = CGPointMake(1, 0);
        start2ViewLayerheader?.colors = [CommonUtil.UIColorFromRGBA(0xffffff, alpha: 0).CGColor,CommonUtil.UIColorFromRGBA(0xffffff, alpha: 1).CGColor,CommonUtil.UIColorFromRGBA(0xffffff, alpha: 0).CGColor  ]
        
        
        checkingViewLayerheader = CAGradientLayer(layer: checkingImage.layer)
        checkingViewLayerheader?.frame = CGRect(x:0, y: 0, width: 2, height: 180 )
        checkingViewLayerheader?.locations = [0,0.5,1.0];
        checkingViewLayerheader?.startPoint = CGPointMake(0, 0);
        checkingViewLayerheader?.endPoint = CGPointMake(1, 0);
        checkingViewLayerheader?.colors = [CommonUtil.UIColorFromRGBA(0xffffff, alpha: 0).CGColor,CommonUtil.UIColorFromRGBA(0xffffff, alpha: 1).CGColor,CommonUtil.UIColorFromRGBA(0xffffff, alpha: 0).CGColor  ]
        
        
        start1Image.layer.addSublayer(start1ViewLayerheader)
        start2Image.layer.addSublayer(start2ViewLayerheader)
        checkingImage.layer.addSublayer(checkingViewLayerheader)
        
        
        
        
        
        
       
        
        
        self.navigationItem.title = "开关安全检测"
        
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        
        
        self.navigationItem.leftItemsSupplementBackButton = true
        self.navigationController?.interactivePopGestureRecognizer.delegate = nil

    }
    
    var backup = false
    
    
    func close(){
    
      GpsService.sharedGpsService.SetGPSACC(Cache.GPSINFO.id!,status:2)
        
      self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    func navigationShouldPopOnBackButton() -> Bool {
        
        if(!backup){
            
            if(appearViews[appearViews.count-1] == start1View || appearViews[appearViews.count-1] == start2View||appearViews[appearViews.count-1] == checkingView){
        
            CommonUtil.alertView(self, title: "确定要中止正在进行的开关监控功能检测？", message: "", buttons: [AlertHandler(title: "取消", handle: {}),AlertHandler(title: "中止", handle: {
                self.backup = true
                
                self.close()

                
            })])
            }else{
            
               self.backup = true
            }

        
        
        }
        
        
        
        return backup
    }
    
}