//
//  MainIndexController.swift
//  LIC
//
//  Created by 温红权 on 15/3/11.
//  Copyright (c) 2015年 乐行天下. All rights reserved.
//

import UIKit
//import ObjectMapper
//import CoreLocation




class MainIndexController: BaseController,BMKMapViewDelegate,BMKRouteSearchDelegate,UIGestureRecognizerDelegate {
    
    @IBOutlet weak var nodeviceViewTop: NSLayoutConstraint!

    @IBOutlet weak var nodiviceView: UIView!
    @IBOutlet weak var connectDeviceButton: UIButton!
    @IBOutlet weak var tiptopspace: NSLayoutConstraint!
    @IBOutlet weak var topspace: NSLayoutConstraint!
    @IBOutlet weak var lineview: UIView!
    @IBOutlet weak var mapview: UIView!
    var mpview:BMKMapView?
    var size:CGRect!
    var _routesearch:BMKRouteSearch?
    
    @IBOutlet weak var leftspace: NSLayoutConstraint!
    @IBOutlet weak var alarmView: UIView!
    
    @IBOutlet weak var tipboard: UIViewTouchView!
    @IBOutlet weak var tipstartLable: UILabel!
    @IBOutlet weak var tipstartTimeLable: UILabel!
    @IBOutlet weak var tipcurrentTimelable: UILabel!
    
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var tipcurrentlable: UILabel!
    @IBOutlet weak var mapchangeButton: UIButton!

    @IBOutlet weak var rangingButton: UIButton!
    
    @IBOutlet weak var errorbutton: UIButton!
    var ebickPoints:[EbickPoint]!
    
     var polylines = [String:BMKPolyline]()
    
    var selected = 1;
    
    @IBAction func connectDeviceButtonActtion(sender: AnyObject) {
        
        self.ispop = false
        var sb = UIStoryboard(name: "Main", bundle:nil)
        
        var vc = sb.instantiateViewControllerWithIdentifier("launchView") as! launchview
        vc.type = 1
        
        CommonUtil.transitionWithType(kCATransitionFade, withSubType: kCATransitionFromLeft, forView: self.view.window!)
        
        
        self.navigationController?.pushViewController(vc, animated: false)
        
        
    }
    
    var startRanging = false
    
    @IBAction func rangingButtonAction(sender: AnyObject) {
        
  
        
        if(!CommonUtil.locationisEnable(self)){
        
            return
        }
        
        
        if(startRanging){
           startRanging = false
           rangingButton.setImage(UIImage(named: "ranging_close"), forState: UIControlState.Normal)
           hiddleWalkingRanging()
           if(mineannotation != nil){
                mpview?.removeAnnotation(mineannotation)
           }
           mpview?.addAnnotation(mineannotation)
            
        }else{
           startRanging = true
            rangingButton.setImage(UIImage(named: "ranging_open"), forState: UIControlState.Normal)
        }
        
    }
    
    
    func hiddleWalkingRanging(){
    
        var polylinetemp:BMKPolyline? = polylines["walking"]
        
        if(polylinetemp != nil ){
            mpview?.removeOverlay(polylinetemp!)
        }
    }
    
    
    
    @IBAction func mapchangeAction(sender: AnyObject) {

        
        var views = UIView.loadFromNibNamed("MapChangeView", bundle: nil)!
        
        var yNavBar = self.navigationController!.navigationBar.frame.height
        //        // yStatusBar indicates the height of the status bar
        var yStatusBar = UIApplication.sharedApplication().statusBarFrame.size.height
        //        // Set the size and the position in the screen of the tab bar
        
        views.topSpace.constant +=  yNavBar+yStatusBar
        
        views.frame = UIScreen.mainScreen().bounds
        
        views.closeAction = {()in
           views.removeFromSuperview()
        }
        views.changeIndex = {(index:Int)in
        
           self.selected = index
            
            if(index == 1){
              self.mpview?.mapType = UInt(BMKMapTypeStandard)
              self.mpview?.overlooking = 0;
            }
            if(index == 0){
                self.mpview?.mapType = UInt(BMKMapTypeSatellite)
                self.mpview?.overlooking = 0;
            }
            if(index == 2){
                self.mpview?.mapType = UInt(BMKMapTypeStandard)
                self.mpview?.overlooking = -45;
            }
            
           
        
        }
        
        
        

        
        views.setSelectedImage(selected)
        
        UIApplication.sharedApplication().windows.last?.addSubview(views)

        
    }

    
    @IBAction func tel(sender: AnyObject) {
        
        CommonUtil.alertCustomService(self)
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        mpview?.delegate=nil
        
        
        _routesearch?.delegate = nil
        
        isfist = true
        islocationfist = true
        
    }

    var isMobileLocationButtonHasPressed = true
    
    @IBAction func locationActon(sender: AnyObject) {
        
        if( (Cache.EBICK == nil || (Cache.EBICK != nil && Cache.EBICK!.gpsId == nil) || (Cache.USER == nil) || (Cache.USER.isloginout == true))||isMobileLocationButtonHasPressed){
            if(!CommonUtil.locationisEnable(self)){
                mpview?.setCenterCoordinate(CLLocationCoordinate2D(latitude: 32.085013, longitude: 118.911739), animated: true)
                return
            }
            
            
            isMobileLocationButtonHasPressed = false
            locationButton.setImage(UIImage(named: "mobile_location"), forState: UIControlState.Normal)
            
            
            if(Cache.EBICK != nil && Cache.EBICK!.gpsId != nil){
                
                mpview?.setCenterCoordinate(CLLocationCoordinate2D(latitude:ebickPoints[ebickPoints.count-1].lat, longitude: ebickPoints[ebickPoints.count-1].lng), animated: true)
  
            }else{
                if(Cache.EBICK != nil && Cache.EBICK!.gpsId == nil && ebickPoints.count>0){
                       mpview?.setCenterCoordinate(CLLocationCoordinate2D(latitude:ebickPoints[ebickPoints.count-1].lat, longitude: ebickPoints[ebickPoints.count-1].lng), animated: true)
                }else{
                    
                    if(Cache.USER.latitude == nil){
                        mpview?.setCenterCoordinate(CLLocationCoordinate2D(latitude: 32.085013, longitude: 118.911739), animated: true)
                    }else{
                        mpview?.setCenterCoordinate(CLLocationCoordinate2D(latitude: Cache.USER.latitude, longitude:  Cache.USER.longitude), animated: true)
                    }
                
                }
                
                
             

            }
        }else{
            isMobileLocationButtonHasPressed = true
            locationButton.setImage(UIImage(named: "ebick_location"), forState: UIControlState.Normal)
            if(Cache.USER?.latitude != nil){
            
                mpview?.setCenterCoordinate(CLLocationCoordinate2D(latitude: Cache.USER.latitude, longitude: Cache.USER.longitude), animated: true)
                
            }
        
        }
        
        
        
    }
    
    @IBAction func messageLostAction(sender: AnyObject) {
        
                
        CommonUtil.backToWebView(self, name: "webviewcontroller", title: "常见问题", url: BaseString.HTTPADDR+"faq/201005.html")

    }
    
    func  enterForegroundNotification(){
        
    
        getebickinfo()
    
    }

    
    override func viewDidLayoutSubviews() {
        mpview!.frame=self.mapview.frame;
        
        mpview?.showMapScaleBar = true
        //自定义比例尺的位置
        mpview?.mapScaleBarPosition = CGPointMake(3, self.mapview.frame.size.height-76)
        
        
        lineview.frame = CGRect(origin: lineview.frame.origin, size: CGSize(width: 0.8, height: 60))

    }
   
    
    func willStartLocatingUser() {
        
    }
    
    func didStopLocatingUser() {
        
    }
    func didUpdateUserHeading(userLocation: BMKUserLocation!) {
        
    }
    
    func didFailToLocateUserWithError(error: NSError!) {
        
    }
    
    override func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
        super.didUpdateBMKUserLocation(userLocation)
        
        if(self.ebickPoints==nil||self.ebickPoints?.count==0){
        
            mpview?.removeOverlays(mpview?.overlays)
            mpview?.removeAnnotations(mpview?.annotations)

            if(Cache.EBICK == nil || (Cache.EBICK != nil && Cache.EBICK!.gpsId == nil) || (Cache.USER == nil) || (Cache.USER.isloginout == true)){
                if(self.islocationfist){
                    mpview?.setCenterCoordinate( userLocation.location.coordinate, animated: true)
                    self.islocationfist = false
                }
            }else{
               mpview?.setCenterCoordinate( userLocation.location.coordinate, animated: true)
            }
            
            
        }
        
       
        if(Cache.USER?.longitude != nil){
            
            
            if(mineannotation != nil){
                mpview?.removeAnnotation(mineannotation)
            }
            
            let point = CLLocationCoordinate2D(latitude:Cache.USER.latitude, longitude: Cache.USER.longitude)
            
            
            if( self.ebickPoints?.count > 0 && startRanging){
                
                let start = BMKPlanNode()
                start.pt = point
                let end = BMKPlanNode()
                end.pt = CLLocationCoordinate2D(latitude:self.ebickPoints[self.ebickPoints.count - 1].lat, longitude: self.ebickPoints[self.ebickPoints.count - 1].lng)
                let walkingRouteSearchOption = BMKWalkingRoutePlanOption()
                walkingRouteSearchOption.from = start
                walkingRouteSearchOption.to = end
                _routesearch?.walkingSearch(walkingRouteSearchOption)
                
            }
            
            if(mineannotation==nil){
            
                mineannotation=BMKPointAnnotationExt();
                mineannotation!.pointindex = StatusCode.CURRENT_MY_LOCATION;
                mineannotation!.pointtype =  StatusCode.CURRENT_MY_LOCATION;

            }
            mineannotation!.coordinate = point;
            mpview?.addAnnotation(mineannotation!);
        }

 
    }
    var mineannotation:BMKPointAnnotationExt?
    
    var isfist = true
    var islocationfist = true

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
  
        
        isfist = true
        islocationfist = true
        self.ispop = false
        
        mpview?.delegate=self;
      
     
         _routesearch?.delegate = self
        
        topspace.constant = -alarmView.frame.size.height
        tiptopspace.constant = -tipboard.frame.size.height
        
        nodeviceViewTop.constant = -nodiviceView.frame.height
        
        errorbutton=CommonUtil.buttonSetImage(errorbutton,name:"errorbtnnormal",states:[UIControlState.Selected,UIControlState.Normal,UIControlState.Highlighted])
        
        nodiviceView.addViewBackedBottomBorderWithHeight(0.1, color:CommonUtil.UIColorFromRGB(0xd9d9d9))
        
        self.view.bringSubviewToFront(self.alarmView)
        self.view.bringSubviewToFront(self.tipboard)
        self.view.bringSubviewToFront(self.locationButton)
        self.view.bringSubviewToFront(self.mapchangeButton)
        self.view.bringSubviewToFront(self.nodiviceView)
         self.view.bringSubviewToFront(self.rangingButton)
 
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "enterForegroundNotification", name: UIApplicationWillEnterForegroundNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "getebickinfo", name: "getebickinfo", object: nil)
        
       
        
        //获取电动车信息
        CommonUtil.getEbickInfo()
        CommonUtil.login()
        

        locationManager.startUserLocationService()

        disableNetWork = true
        if(BaseString.NetWorkEnable){
            networkEnable()
        }else{
            networkDisable()
        }
        

    }
    
    
    
    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
       self.tiptopspace.constant = -self.tipboard.frame.height
        
    }
    
    override func webSocketMessageHandler(message: String) {
        if(  message.contains("realtimeTrajector")){
            CommonUtil.getEbickInfo()

        }else{
        
            if( message.contains("gpsStatus")){
                
                var data:JSON = JSON(data:(message as NSString).dataUsingEncoding(NSUTF8StringEncoding)! )
                
//                println(data)
                
                if(data["gpsStatus"]["id"].int == Cache.EBICK.gpsId){
                    if(data["gpsStatus"]["status"].int == 0){
                        showErrorView();

                    }
                    
                    if(data["gpsStatus"]["status"].int == 1){
                        hideErrorView()
                        
                    }
                
                
                }
        
            }else{

            
            }
        
        }
    }


    var ispop = false
    
    //获取电动车信息
    func getebickinfo(){
        
        if(Cache.EBICK == nil || (Cache.EBICK != nil && Cache.EBICK!.gpsId == nil) || (Cache.USER == nil) || (Cache.USER.isloginout == true)){
            
            mpview?.setCenterCoordinate(CLLocationCoordinate2D(latitude: 32.085013, longitude: 118.911739), animated: true)
            
            if(!self.ispop){
            
             self.ispop = true
                
                    UIView.animateWithDuration(0.4, animations: {
                        if(BaseString.NetWorkEnable){
                        
                            self.nodeviceViewTop.constant = 0
                        }else{
                        
                            self.nodeviceViewTop.constant = 44
                        }
                        
                        self.nodiviceView.layoutIfNeeded()
                    })
                
                //隐藏测距
                rangingButton.hidden = true
                
                
            }
        
        }else{
            rangingButton.hidden = false
            
            CommonUtil.GCDThread({()in
                //这里写需要放到子线程做的耗时的代码
                CommonUtil.getevents()
                
                }, afterdo:  nil)

            
            if(Cache.EBICK?.status == 0){
                showErrorView();
            
            }
            
            if(Cache.EBICK?.status == 1){
                hideErrorView()
                
            }
            
           self.getRealtimeTrajector()
        
        }
    
       
    
    
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initUI();
        
        self.tipstartLable.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.tipstartLable.numberOfLines = 0
        
        connectDeviceButton = CommonUtil.buttonSetImage(connectDeviceButton, name: "remove_devicebtn", states: [UIControlState.Normal,UIControlState.Selected,UIControlState.Highlighted])
        connectDeviceButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
        connectDeviceButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)

        
        self.tipcurrentlable.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.tipcurrentlable.numberOfLines = 0
       
        tipboard.clickevnt = {()in
        
            var sb = UIStoryboard(name: "Main", bundle:nil)
            var vc = sb.instantiateViewControllerWithIdentifier("trackThePlaybackController") as!  TrackThePlaybackController
            
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
              
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func networkEnable() {
        super.networkEnable()
        
        if(self.nodeviceViewTop.constant != -self.nodiviceView.frame.height){
            
            UIView.animateWithDuration(0.4, animations: {
                
                self.nodeviceViewTop.constant = 0
                self.nodiviceView.layoutIfNeeded()
            })
        
        }
        
        //error显示
        if(self.topspace.constant != -self.alarmView.frame.size.height){
            
            UIView.animateWithDuration(0.4, animations: {
                self.topspace.constant = 0
                //显示信息
                if(self.tiptopspace.constant != -self.tipboard.frame.size.height){
                    
                    self.tiptopspace.constant = self.alarmView.frame.size.height
                    self.tipboard.layoutIfNeeded()
                }
                self.alarmView.layoutIfNeeded()
            })
            
        }else{
             //error不显示

            if(self.tiptopspace.constant != -self.tipboard.frame.size.height){
                UIView.animateWithDuration(0.4, animations: {
                    self.tiptopspace.constant = 0
                    self.tipboard.layoutIfNeeded()
                })
            }
            
            
        }
        
       
        
        
    }
    
    override func networkDisable() {
        super.networkDisable()
        
        if(self.nodeviceViewTop.constant != -self.nodiviceView.frame.height){
            
            UIView.animateWithDuration(0.4, animations: {
                
                self.nodeviceViewTop.constant = 44
                self.nodiviceView.layoutIfNeeded()
            })
            
        }
        
        //error显示
        if(self.topspace.constant != -self.alarmView.frame.size.height){
            
            UIView.animateWithDuration(0.4, animations: {
                self.topspace.constant = -self.alarmView.frame.size.height
                if(self.tiptopspace.constant != -self.tipboard.frame.size.height){
                    
                    self.tiptopspace.constant =  44
                    self.tipboard.layoutIfNeeded()
                }
                self.alarmView.layoutIfNeeded()
            })
            
        }else{
            //error不显示
            if(self.tiptopspace.constant != -self.tipboard.frame.size.height){
                UIView.animateWithDuration(0.4, animations: {
                    self.tiptopspace.constant = 44
                    self.tipboard.layoutIfNeeded()
                })
            }
            
            
        }

    }
    

    
    func getRealtimeTrajector(){
        if( Cache.EBICK != nil ){
            
            GpsService.sharedGpsService.GetEbickRealtimeTrajectory({(data) in
                
//                println(data)
                
                if(data["status"].int == StatusCode.SystemSC.SYSTEM_OK){
                    
                    if(data["data","trajectory"].arrayObject?.count > 0){
                    
                    self.ebickPoints = Mapper<EbickPoint>().mapArray(data["data","trajectory"].arrayObject!)
                    self.drawMapPoint(self.ebickPoints);

                        if(self.isfist){
                          self.didSelectAnnotationView(true)
                            self.isfist = false
                        }
                        
                    
                    
                   }
                }
                
                
                }, errorHandler: {(data) in }, userId: Cache.USER.id, ebickId: Cache.EBICK.id)
            
        }

    
    }
    
    
    override func viewDidAppear(animated: Bool) {

  
    }
    
    
 
    
    
    func drawMapPoint(points:[EbickPoint]) -> Void {
        
        
        if(points.count > 0){
            var polylinetemp:BMKPolyline? = polylines["point"]
            
            if(polylinetemp != nil ){
                mpview?.removeOverlay(polylinetemp!)
            }
            
            
            
            if(mpview?.annotations.count > 0){
                for animator in mpview!.annotations {
                    if animator is BMKPointAnnotationExt {
                        var temp:BMKPointAnnotationExt = animator as! BMKPointAnnotationExt
                        if temp.pointtype != StatusCode.CURRENT_MY_LOCATION {
                            mpview?.removeAnnotation(temp)
                        }
                        
                    }
                }
            }
            
            
            var coors:[CLLocationCoordinate2D] = [];
            // 1起始点 2停顿点 3结束点
            for (index,ebickpoint:EbickPoint) in enumerate(points) {
                if points.count == 1 {
                  ebickpoint.type = StatusCode.CURRENT_PO
                
                }
                self.setBMKPointAnnotation(index,ebickpoint:ebickpoint)
                coors.append( CLLocationCoordinate2D(latitude:ebickpoint.lat, longitude: ebickpoint.lng))
            }
            
            var polyline = BMKPolyline(coordinates: &coors, count: UInt(coors.count))
            
            polylines["point"] = polyline
      
            mpview?.addOverlay(polyline);
            mpview?.setCenterCoordinate(coors[coors.count-1], animated: true)
            mpview?.viewForOverlay(polyline);
            
        }
        
        
    }
    
    
    func onGetWalkingRouteResult(searcher: BMKRouteSearch!, result: BMKWalkingRouteResult!, errorCode error: BMKSearchErrorCode) {
        
        hiddleWalkingRanging()

        
        if (error.value == BMK_SEARCH_NO_ERROR.value) {
            
            var plan: BMKWalkingRouteLine = result.routes[0] as! BMKWalkingRouteLine
            var size = plan.steps.count
            var planPointCounts:Int32 = 0
            
            if(startRanging){
                if(plan.distance>=1000){
                    mineannotation?.title = "与车的步行距离" + String(format: "%.1f", Double(plan.distance) / 1000.0) + "公里"
                }else{
                    mineannotation?.title = "与车的步行距离" + String(format: "%.0f", Double(plan.distance) ) + "米"
                }
                
                
               
            }else{
               mineannotation?.title = ""
            }
            

            for (var i = 0; i < size; i++) {
                
                var transitStep:BMKWalkingStep = plan.steps[i] as! BMKWalkingStep

                //轨迹点总数累计
                planPointCounts += transitStep.pointsCount;
            }
            
            //轨迹点
            var temppoints:[BMKMapPoint] = [];
            var i = 0;
            for (var j = 0; j < size; j++) {
                
                var transitStep:BMKWalkingStep = plan.steps[j] as! BMKWalkingStep
                var k:Int32=0
                for(k=0; k < transitStep.pointsCount; k++) {
                    
                    BMKMapPoint(x: transitStep.points[Int(k)].x, y: transitStep.points[Int(k)].y)
                    temppoints.append(BMKMapPoint(x: transitStep.points[Int(k)].x, y: transitStep.points[Int(k)].y))
                    i++;
                }
                
            }
            // 通过points构建BMKPolyline
            var polyLine = BMKPolyline(points: &temppoints, count: UInt(planPointCounts))
            
              polylines["walking"] = polyLine
            
            mpview?.addOverlay(polyLine) // 添加路线overlay
            
            
            
        }
        
        
    }
    
    
    
    
    

    
    func mapView(mapView: BMKMapView!, viewForOverlay overlay: BMKOverlay!) -> BMKOverlayView! {
        if(overlay.isKindOfClass(BMKPolyline)){
            
            let temp = overlay as! BMKPolyline
            
            let polyLine1:BMKPolyline? =  polylines["walking"]
            let polyLine2:BMKPolyline? =  polylines["point"]
            
            if(temp == polyLine1){
                let polylineView=BMKPolylineView(overlay: overlay);
//                polylineView.strokeColor = CommonUtil.UIColorFromRGB(0xff4a00).colorWithAlphaComponent(1);
                polylineView.lineWidth = 10.0;
//                polylineView.lineDash = true
                
                
                polylineView.loadStrokeTextureImage(UIImage(named: "dian.png"))
                
                return polylineView;
            }
            
            if(temp == polyLine2){
                let polylineView=BMKPolylineView(overlay: overlay);
                polylineView.strokeColor = CommonUtil.UIColorFromRGB(0x3cc1fc).colorWithAlphaComponent(1);
                polylineView.lineWidth = 4.0;
                return polylineView;
            }
            
            
        }
        
        
        
        return nil;
    }

    
    func mapView(mapView: BMKMapView!, viewForAnnotation annotation: BMKAnnotation!) -> BMKAnnotationView! {
        if  (annotation.isKindOfClass(BMKPointAnnotationExt)) {
            
            var newAnnotationView = BMKPinAnnotationViewExt(annotation: annotation, reuseIdentifier: "myAnnotation"); //(); alloc] initWithAnnotation:annotation reuseIdentifier:@ "myAnnotation" ];
            var annotationtemp = annotation as! BMKPointAnnotationExt
            
            newAnnotationView.index = annotationtemp.pointindex
            
            newAnnotationView.pointType = annotationtemp.pointtype
            
            newAnnotationView = setBMKPinAnnotationView(annotationtemp.pointtype,view:newAnnotationView)
            
            return  newAnnotationView;
        }
        return  nil;
    }
    
    func mapView(mapView: BMKMapView!, didAddAnnotationViews views: [AnyObject]!) {
      
        if(mineannotation != nil){
 
             mpview?.selectAnnotation(self.mineannotation, animated: false)
        
        }
    }
    
    
    func mapView(mapView: BMKMapView!, didDeselectAnnotationView view: BMKAnnotationView!) {
//        if(mineannotation != nil){
//            
//            mpview?.selectAnnotation(self.mineannotation, animated: false)
//            
//        }
    }
    
    
    func initUI(){
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        
        self.navigationItem.title = "实时位置"
        
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        
        
         CommonUtil.setNavigationControllerBackground(self)
        
        self.mpview = BMKMapView();
        self.mapview.addSubview(self.mpview!)
        mpview?.delegate=self;
        mpview?.zoomLevel = 16
        
        var tapGesture = UITapGestureRecognizer(target: self, action: "tapGesture:")
        tapGesture.delegate = self
        self.mpview?.addGestureRecognizer(tapGesture)
        
        
        
        _routesearch = BMKRouteSearch()
        _routesearch?.delegate = self
        
        
        
        if (Cache.EBICK == nil || (Cache.EBICK != nil && Cache.EBICK!.gpsId == nil) || (Cache.USER == nil) || (Cache.USER.isloginout == true))  {
        
        
            if(!CommonUtil.locationisEnable(self)){
                
                return
            }
            
            
            isMobileLocationButtonHasPressed = false
            locationButton.setImage(UIImage(named: "mobile_location"), forState: UIControlState.Normal)
            
            
            if(Cache.EBICK != nil && Cache.EBICK!.gpsId == nil){
                
                mpview?.setCenterCoordinate(CLLocationCoordinate2D(latitude: 32.085013, longitude: 118.911739), animated: true)
            }else{
                
                if(Cache.EBICK != nil && Cache.EBICK!.gpsId != nil){
                    
                    if ebickPoints?.count>0 {
                        
                        mpview?.setCenterCoordinate(CLLocationCoordinate2D(latitude:ebickPoints[ebickPoints.count-1].lat, longitude: ebickPoints[ebickPoints.count-1].lng), animated: true)
                        
                    }
                    
                }else{
                    
                }
            }

        }
        
        
    }
    
    
    func tapGesture(gesture:UITapGestureRecognizer){
        
        
        
    }
    
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        
        var touchClassName = NSStringFromClass(touch.view.classForCoder)
        
        if(touch.view.isKindOfClass(BMKPinAnnotationViewExt)){
            
            var views = touch.view as! BMKPinAnnotationViewExt
            if(views.pointType == StatusCode.CURRENT_MY_LOCATION){
               return false
            }
            
            
            if(self.tipisopen){
             self.didDeselectAnnotationView(false)
            }else{
             self.didSelectAnnotationView(false)
            }
            
           
            
        }else{
            
            //self.didDeselectAnnotationView()
        }
        
        
        
        return false
    }

    
    
    func setBMKPinAnnotationView(type:Int,view:BMKPinAnnotationViewExt) -> BMKPinAnnotationViewExt {
        
        var imageName = ""
        var img:UIImage!
        
        view.canShowCallout = false
        
        switch type {
            
        case StatusCode.START_PO:
            
            imageName = "start"
            
            img = UIImage(named: imageName)
            view.image=img;
            view.centerOffset = CGPointMake((view.frame.size.width * 0.01), -(view.frame.size.height * 0.35));
            view.title = "起点"
            break;
        case StatusCode.END_PO:
            imageName = "current"
            
            img = UIImage(named: imageName)
            view.image=img;
            view.centerOffset = CGPointMake((view.frame.size.width * 0.01), -(view.frame.size.height * 0.5));
            view.title = "当前位置"
            
            break;
        case StatusCode.STOP_PO:
            imageName = "stop"
            
            img = UIImage(named: imageName)
            view.image=img;
            view.centerOffset = CGPointMake(0, 0);
            view.title = "中途停车位置"
            
            break;
        case StatusCode.CURRENT_PO:
            imageName = "current"
            
            img = UIImage(named: imageName)
            view.image=img;
            view.centerOffset = CGPointMake((view.frame.size.width * 0.01), -(view.frame.size.height * 0.5));
            view.title = "当前位置"
            
            break;
            
        case StatusCode.CURRENT_MY_LOCATION:
            imageName = "my_location"
            if(startRanging){
                 view.canShowCallout = true
            }
            
          
            img = UIImage(named: imageName)
            view.image=img;
            view.centerOffset = CGPointMake((view.frame.size.width * 0.0), -(view.frame.size.height * 0));
            view.title = "离车12.5公里"
    
            
            break;
       
        default:
            
            break;
            
        }
        return view
    }

 
    
    func setBMKPointAnnotation(index:Int,ebickpoint:EbickPoint){
        if(ebickpoint.type == nil ){
            return
        }
        var point = CLLocationCoordinate2D(latitude:ebickpoint.lat, longitude: ebickpoint.lng)
        var annotation=BMKPointAnnotationExt();
        annotation.coordinate = point;
        annotation.title = "\(ebickpoint.type)"
        annotation.pointindex = index
        annotation.pointtype = ebickpoint.type
        mpview?.addAnnotation(annotation);
        
    }


    func didDeselectAnnotationView(){
       

        self.close++
        if(open == close){
        
            self.tipisopen = false
            self.tipboard.layoutIfNeeded()
            UIView.animateWithDuration(0.4, animations: {
                self.tiptopspace.constant = -self.tipboard.frame.height
                self.tipboard.layoutIfNeeded()
            })

        
        }
        
    }
    
    func didDeselectAnnotationView(autoClose:Bool){
            
            self.tipisopen = false
            self.tipboard.layoutIfNeeded()
            UIView.animateWithDuration(0.4, animations: {
                self.tiptopspace.constant = -self.tipboard.frame.height
                self.tipboard.layoutIfNeeded()
            })

    }
    
    var open = 0;
    var close = 0;
    var entCount = 0;
    
    var tipisopen = false;
    
    
    func didSelectAnnotationView(autoClose:Bool){
        
        
        if(ebickPoints?.count > 0){
        
            
            self.tipstartLable.text = ebickPoints[0].bdAddr
            self.tipcurrentlable.text = ebickPoints[ebickPoints.count-1].bdAddr
            
            tipstartTimeLable.text = CommonUtil.FloatToDate(ebickPoints[0].time,format:"HH:mm")
            tipcurrentTimelable.text = CommonUtil.FloatToDate(ebickPoints[ebickPoints.count-1].time,format:"HH:mm")
            
            self.tipboard.layoutIfNeeded()
            
            UIView.animateWithDuration(0.4,animations: { () -> Void in
                
       
                self.tipisopen = true
                //error未弹出
                if(self.topspace.constant == -self.alarmView.frame.height  ){
                    
                    if(BaseString.NetWorkEnable){
                        
                        if(self.tiptopspace.constant != 0){
                            self.tiptopspace.constant = 0
                        }
                        
                    }else{
                        if(self.tiptopspace.constant != 44){
                            self.tiptopspace.constant = 44
                        }

                        
                    }
                    
                    if(autoClose){
                        self.open++
                        NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("didDeselectAnnotationView"), userInfo: nil, repeats: false)
                    }

                    
                    
                
                }else{
                    //error弹出
                    
                    if(BaseString.NetWorkEnable){
                         self.tiptopspace.constant = self.alarmView.frame.height
                    }else{
                    
                        self.tiptopspace.constant = self.alarmView.frame.height + 44
                    }
                    
                 
                    
                 
                    if(autoClose){

                       NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("didDeselectAnnotationView"), userInfo: nil, repeats: false)
                    }
                    
                
                }
                self.tipboard.layoutIfNeeded()
                
            })
            
            
        }
        
    }
    
    
    func showErrorView(){
        self.alarmView.layoutIfNeeded()
        self.tipboard.layoutIfNeeded()
        
        
        if(BaseString.NetWorkEnable){
        
            UIView.animateWithDuration(0.4, animations: {
                
                self.topspace.constant = 0
                if(self.tiptopspace.constant == 0){
                    
                    self.tiptopspace.constant = self.alarmView.frame.height
                    self.tipboard.layoutIfNeeded()
                }
                self.alarmView.layoutIfNeeded()
            })
        
        }else{
        
        
            UIView.animateWithDuration(0.4, animations: {
                
                self.topspace.constant = -self.alarmView.frame.size.height
                if(self.tiptopspace.constant == self.alarmView.frame.size.height){
                    
                    self.tiptopspace.constant = self.alarmView.frame.height+44
                    self.tipboard.layoutIfNeeded()
                }
                self.alarmView.layoutIfNeeded()
            })
        
        }
        
        
        
    
    }
    
    
    func hideErrorView(){
         self.alarmView.layoutIfNeeded()
         self.tipboard.layoutIfNeeded()
        
        if(BaseString.NetWorkEnable){
        
            UIView.animateWithDuration(0.4, animations: {
                self.topspace.constant = -self.alarmView.frame.size.height
                if(self.tiptopspace.constant != -self.tipboard.frame.size.height){
                    
                    self.tiptopspace.constant = 0
                    self.tipboard.layoutIfNeeded()
                }
                self.alarmView.layoutIfNeeded()
            })

        
        
        }else{
        
            UIView.animateWithDuration(0.4, animations: {
                self.topspace.constant = -self.alarmView.frame.size.height
                if(self.tiptopspace.constant != -self.tipboard.frame.size.height){
                    
                    self.tiptopspace.constant = 44
                    self.tipboard.layoutIfNeeded()
                }
                self.alarmView.layoutIfNeeded()
            })

        }
        
        
        
    }
    
    
    
    
    
    
    
    
    
}




