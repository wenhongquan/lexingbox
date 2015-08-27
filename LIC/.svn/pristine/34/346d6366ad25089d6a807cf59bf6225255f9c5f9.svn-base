  
//
//  ReadQrCodeController.swift
//  LIC
//
//  Created by 温红权 on 15/4/14.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation
import AVFoundation
import QuartzCore
//import ObjectMapper

class ReadQrCodeController: BaseController {
    
    
//    private var cameraView = ReaderOverlayView()
    private var codeReader: QRCodeReader?

    @IBOutlet weak var lexingcodeButton: UIButton!
    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var textLable1: UILabel!
    @IBOutlet weak var textLable2: UILabel!
    

    @IBOutlet weak var top2: NSLayoutConstraint!
    @IBOutlet weak var top3: NSLayoutConstraint!

    var looper:CADisplayLink?
    
    private var line_1 = CommonUtil.newLineOverlay(0x2bcd9c)
    private var line_2 = CommonUtil.newLineOverlay(0x2bcd9c)
    private var line_3 = CommonUtil.newLineOverlay(0x2bcd9c)
    private var line_4 = CommonUtil.newLineOverlay(0x2bcd9c)
    private var line_5 = CommonUtil.newLineOverlay(0x2bcd9c)
    private var line_6 = CommonUtil.newLineOverlay(0x2bcd9c)
    private var line_7 = CommonUtil.newLineOverlay(0x2bcd9c)
    private var line_8 = CommonUtil.newLineOverlay(0x2bcd9c)
    
    private var gradientLayer:CAGradientLayer?

    func backtomain(){
        
        self.loading?.dismissAnimated(false)
        self.loading?.dismiss()
        
        CommonUtil.transitionWithType(kCATransitionReveal, withSubType: kCATransitionFromBottom, forView: self.view.window!)
        
        self.navigationController?.popViewControllerAnimated(false)
    }
    
    var loading:JGProgressHUD?
    
    var top:CGFloat = 0
    
    override func viewDidLoad() {

        
        lexingcodeButton = CommonUtil.buttonSetImage(lexingcodeButton, name: "remove_devicebtn", states: [UIControlState.Normal,UIControlState.Selected,UIControlState.Highlighted])
        lexingcodeButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
        lexingcodeButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        
        self.navigationItem.title = "连接乐行宝设备"
        
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        
        
        var status = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
        
        
        
        
        
        
        
        
       
        
        if(status !=  AVAuthorizationStatus.Authorized ){
          
            AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo, completionHandler: { (access) -> Void in
                if(access){
                    self.viewDidLoad()
                }else{
                    
                    CommonUtil.alertView(self, title: "相机无权限", message: "乐行宝需要获取您的相机权限", buttons: [AlertHandler(title: "试试乐行码", handle: {
                        
                        // 跳转至输入乐行码界面
                        var sb = UIStoryboard(name: "Main", bundle:nil)
                        
                        var vc = sb.instantiateViewControllerWithIdentifier("inputlexingcodeController") as!  InputLexingCodeTableController
                        
                        vc.hidesBottomBarWhenPushed = true
                        
                        CommonUtil.transitionWithType(kCATransitionMoveIn, withSubType: kCATransitionFromTop, forView: self.view.window!)
                        self.navigationController?.pushViewController(vc, animated: false)
                        
                    }),AlertHandler(title: "好", handle: {
                        
                        //               self.navigationController?.popViewControllerAnimated(true)
                        
                    })])
                    
                    
                }
            })

            return
        
        }
        
        
        
        
        
        let reader = QRCodeReader(metadataObjectTypes: [AVMetadataObjectTypeQRCode])

        codeReader           = reader
        view.backgroundColor = UIColor.blackColor()
        
        codeReader?.completionBlock = { [unowned self] (resultAsString) in
            
//            var string:String = (resultAsString as String)
            
            
            if(resultAsString != nil){
                
                var myStringArr:[String] = resultAsString!.componentsSeparatedByString("/")
                
                if( myStringArr.count > 0 ){
                    
                    var context = myStringArr[myStringArr.count-1]
                    
                    var gps = GpsInfo()
                    gps.ebikeId = Cache.EBICK.id
                    gps.userId = Cache.USER.id
                    gps.qrCode = context
                    GpsService.sharedGpsService.PutEbickCONN({(data) in
                        if(data["status"].int == StatusCode.SystemSC.SYSTEM_OK){
                        
                            self.loading =  CommonUtil.alertSuccess(self.navigationController!.view!,title:"成功")
                            
                            self.loading?.dismissAfterDelay(1200)
                            
                            NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("backtomain"), userInfo: nil, repeats: false)
                        
                        }else
                        if(data["status"].int == StatusCode.GpsSC.GPS_ALREADY_OTHERS_BIND){
                            CommonUtil.alertView(self, title: "连接失败", message: "该设备已被使用", buttons: [AlertHandler(title: "确定", handle: {
                                self.codeReader?.startScanning()
                                
                            })])
                        }else
                        
                        if(data["status"].int == StatusCode.GpsSC.GPS_ALREADY_SELF_BIND){
                            CommonUtil.alertView(self, title: "连接失败", message: "您已经连接了乐行宝设备", buttons: [AlertHandler(title: "确定", handle: {
                            self.codeReader?.startScanning()})])
                        }else
                        if(data["status"].int == StatusCode.GpsSC.GPS_NOT_EXIST){
                            CommonUtil.alertView(self, title: "连接失败", message: "请扫描乐行宝设备上的二维码", buttons: [AlertHandler(title: "确定", handle: {
                            self.codeReader?.startScanning()})])
                        }else
                        if(data["status"].int == StatusCode.GpsSC.NOT_FOUND_GPS){
                                CommonUtil.alertView(self, title: "连接失败", message: "请扫描乐行宝设备上的二维码", buttons: [AlertHandler(title: "确定", handle: {
                                self.codeReader?.startScanning()})])
                        }
                    
                        }, errorHandler: {(data) in
                    
                    
                    }, body: (Mapper().toJSON(gps)))
                    
                    
                    
                    
                }
            
            }
            
           
            
            
    
            
        }
        
        setupUIComponentsWithCancelButtonTitle()
        
//        setupAutoLayoutConstraints()
        
        topview.layer.insertSublayer(codeReader!.previewLayer, atIndex: 0)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "orientationDidChanged:", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        
        
        
        
        
        
        
        
        top = (65 / 1136.0) * UIScreen.mainScreen().bounds.height
        top2.constant = ((30)/1136.0) * UIScreen.mainScreen().bounds.height
        top3.constant = ((31)/1136.0) * UIScreen.mainScreen().bounds.height
        
        
        let shapeLayer = CommonUtil.newLineOverlay()
        shapeLayer.frame = view.layer.frame
        var recttemp:CGRect = CGRect(x:(view.layer.frame.size.width - 220) / 2, y: top, width: 220, height: 220)
        var path:UIBezierPath = UIBezierPath(roundedRect: recttemp
            , cornerRadius: 0)
        
        shapeLayer.masksToBounds = true
        
        var rect = view.layer.frame
        
        path.appendPath(UIBezierPath(rect: rect))
        shapeLayer.path = path.CGPath
        shapeLayer.fillRule = kCAFillRuleEvenOdd
        
        let overlay = CommonUtil.newLineOverlayDefult()
        overlay.path = UIBezierPath(roundedRect: recttemp
            , cornerRadius: 0).CGPath
        
        
        topview.layer.addSublayer(shapeLayer)
        topview.layer.addSublayer(overlay)
        
        
        
        
        var recttemp1:CGRect = CGRect(x:(rect.size.width - 220) / 2, y: top, width: 16, height: 2)
        line_1.path  = UIBezierPath(roundedRect: recttemp1
            , cornerRadius: 0).CGPath
        
        var recttemp2:CGRect = CGRect(x:(rect.size.width - 220) / 2, y: top, width: 2, height: 16)
        line_2.path  = UIBezierPath(roundedRect: recttemp2
            , cornerRadius: 0).CGPath
        
        
        
        
        var recttemp3:CGRect = CGRect(x:(rect.size.width - 220) / 2, y: top+220-16, width: 2, height: 16)
        line_3.path  = UIBezierPath(roundedRect: recttemp3
            , cornerRadius: 0).CGPath
        
        var recttemp4:CGRect = CGRect(x:(rect.size.width - 220) / 2, y: top+220-2, width: 16, height: 2)
        line_4.path  = UIBezierPath(roundedRect: recttemp4
            , cornerRadius: 0).CGPath
        
        
        
        
        
        var recttemp5:CGRect = CGRect(x:(rect.size.width - 220) / 2  + 220 - 16, y: top, width: 16, height: 2)
        line_5.path  = UIBezierPath(roundedRect: recttemp5
            , cornerRadius: 0).CGPath
        
        var recttemp6:CGRect = CGRect(x:(rect.size.width - 220) / 2 + 220 - 2, y: top, width: 2, height: 16)
        line_6.path  = UIBezierPath(roundedRect: recttemp6
            , cornerRadius: 0).CGPath
        
        
        
        
        var recttemp7:CGRect = CGRect(x:(rect.size.width - 220) / 2 + 220 - 2, y: top+220-16, width: 2, height: 16)
        line_7.path  = UIBezierPath(roundedRect: recttemp7
            , cornerRadius: 0).CGPath
        
        var recttemp8:CGRect = CGRect(x:(rect.size.width - 220) / 2 + 220 - 16, y: top+220-2, width: 16, height: 2)
        line_8.path  = UIBezierPath(roundedRect: recttemp8
            , cornerRadius: 0).CGPath
        
        
        
        
        
        
        gradientLayer = CAGradientLayer(layer: topview.layer)
        gradientLayer?.frame = CGRect(x:(rect.size.width - 220) / 2, y: top, width: 220, height: 2 )
        
        gradientLayer?.colors = [UIColor(red: 43/255.0, green: 205/255.0, blue: 156/255.0, alpha: 0).CGColor,UIColor(red: 43/255.0, green: 205/255.0, blue: 156/255.0, alpha: 1).CGColor,UIColor(red: 43/255.0, green: 205/255.0, blue: 156/255.0, alpha: 0).CGColor  ]
        
        gradientLayer?.locations = [0,0.5,1.0];
        
        gradientLayer?.startPoint = CGPointMake(0, 0);
        gradientLayer?.endPoint = CGPointMake(1, 0);
        
        
        //        line_9.addSublayer(gradientLayer)
        
        topview.layer.addSublayer(gradientLayer)
        
        
        
        addtoView()

        
        
        
//        let maskLayer = CALayer()
//        maskLayer.frame = view.frame
//        maskLayer.backgroundColor = UIColor.blackColor().CGColor
//        maskLayer.opacity = 0.6
        
        
        
        
    }
    
    
    
    
    @IBAction func connectLexingAction(sender: AnyObject) {
        
        // 跳转至输入乐行码界面
        var sb = UIStoryboard(name: "Main", bundle:nil)
        
        var vc = sb.instantiateViewControllerWithIdentifier("inputlexingcodeController") as!  InputLexingCodeTableController

        vc.hidesBottomBarWhenPushed = true

        CommonUtil.transitionWithType(kCATransitionMoveIn, withSubType: kCATransitionFromTop, forView: self.view.window!)
        self.navigationController?.pushViewController(vc, animated: false)

        
        
    }
    func addtoView(){
        
        topview.layer.addSublayer(line_1)
        topview.layer.addSublayer(line_2)
        topview.layer.addSublayer(line_3)
        topview.layer.addSublayer(line_4)
        topview.layer.addSublayer(line_5)
        topview.layer.addSublayer(line_6)
        topview.layer.addSublayer(line_7)
        topview.layer.addSublayer(line_8)
  
    }

    var dotimeer = true
    var _y:CGFloat = 0
    
    
    var  duration:CFTimeInterval?;
    var  timeOffset:CFTimeInterval?;
    var  lastStep:CFTimeInterval?;

    

    
    func chageline(link:CADisplayLink) -> Void {
        
        

        
        if(_y>=(220)){
            _y = 0
        }
        
       
        CATransaction.begin()
        CATransaction.setAnimationDuration(0)
         self.gradientLayer?.position.y =  top + _y
        CATransaction.commit()
        
       
        
//        self.gradientLayer?.frame.origin.y = 65 + _y
        
        
        var thisStep = CACurrentMediaTime()
        
        var stepDuration1 = thisStep - self.lastStep!;
        
        self.lastStep = thisStep;
        
//        if(_y > 0 && _y < 10){
//        
//           _y = _y + CGFloat(10 * (stepDuration1))
//          return
//        }
//        
//        if(_y > 210 && _y < 220){
//            
//            _y = _y + CGFloat(10 * (stepDuration1))
//            return
//        }
        
         _y = _y + CGFloat(100 * (stepDuration1))
        
     
        
        
        
        
        
    }
    
    
    deinit {
        codeReader?.stopScanning()
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidAppear(animated: Bool) {
        
        
        

    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        

        
        if(codeReader == nil){
           return
        }
        
        
        
        
        dotimeer = true
        looper?.invalidate()
        looper = CADisplayLink(target: self, selector: Selector("chageline:"))
        looper?.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
        lastStep = CACurrentMediaTime()

        
        codeReader?.startScanning()
    }
    
    override func viewWillDisappear(animated: Bool) {
        codeReader?.stopScanning()
        
        dotimeer = false
        
        looper?.invalidate()
        
        super.viewWillDisappear(animated)
    }

    
   
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        codeReader?.previewLayer.frame = view.bounds
        
        self.view.bringSubviewToFront(topview)
        self.topview.bringSubviewToFront(self.textLable1)
        self.topview.bringSubviewToFront(self.textLable2)
        self.topview.bringSubviewToFront(self.lexingcodeButton)

    }
    
    
    // MARK: - Managing the Orientation
    
    func orientationDidChanged(notification: NSNotification) {
        topview.setNeedsDisplay()
        
        if codeReader?.previewLayer.connection != nil {
            let orientation = UIApplication.sharedApplication().statusBarOrientation
            
            codeReader?.previewLayer.connection.videoOrientation = QRCodeReader.videoOrientationFromInterfaceOrientation(orientation)
        }
    }
    
    // MARK: - Initializing the AV Components
    
    private func setupUIComponentsWithCancelButtonTitle() {
//        topview.clipsToBounds = true
//        topview.setTranslatesAutoresizingMaskIntoConstraints(false)
//        view.addSubview(topview)
        
//        if let _codeReader = codeReader {
//            _codeReader.previewLayer.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)
//            
//            if _codeReader.previewLayer.connection.supportsVideoOrientation {
//                let orientation = UIApplication.sharedApplication().statusBarOrientation
//                
//                _codeReader.previewLayer.connection.videoOrientation = QRCodeReader.videoOrientationFromInterfaceOrientation(orientation)
//            }
//            
//        }

    }
    
    private func setupAutoLayoutConstraints() {
        let views: [NSObject: AnyObject] = ["cameraView": topview]
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[cameraView]|", options: .allZeros, metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[cameraView]|", options: .allZeros, metrics: nil, views: views))

        
        //    if let _switchCameraButton = switchCameraButton {
        //      let switchViews: [NSObject: AnyObject] = ["switchCameraButton": _switchCameraButton]
        //
        //      view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[switchCameraButton(50)]", options: .allZeros, metrics: nil, views: switchViews))
        //      view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[switchCameraButton(70)]|", options: .allZeros, metrics: nil, views: switchViews))
        //    }
    }
    
    
    
    

    
    
    
    
}