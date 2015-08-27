//
//  TranceRePlayController.swift
//  LIC
//
//  Created by 温红权 on 15/4/24.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation


class TranceRePlayController: BaseController,BMKMapViewDelegate,UIGestureRecognizerDelegate {
    
    @IBOutlet weak var processLineBgImageView: UIImageView!
    @IBOutlet weak var processLineBgView: UIView!
    
    @IBOutlet weak var currentProcessView: UIView!
    @IBOutlet weak var currentProcessLineView: UIView!
    @IBOutlet weak var currentProcessLineImageview: UIImageView!
    @IBOutlet weak var currentProcessButton: UIButtonTouch!
    @IBOutlet weak var currentProcessViewWidthSpace: NSLayoutConstraint!
    
    
    @IBOutlet weak var currentTimeLableLeftSpace: NSLayoutConstraint!
    @IBOutlet weak var currentProcessTimeLable: UILabel!
    @IBOutlet weak var currentProcessStartTimeLable: UILabel!
    @IBOutlet weak var currentProcessEndTimeLable: UILabel!
    
    @IBOutlet weak var playview: UIView!
    @IBOutlet weak var mapview: UIView!
    var mpview:BMKMapView?
    
    @IBOutlet weak var tapview: UIView!
    
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var normalButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    
    var processBGImage:UIImage!
    var processCurrentImage:UIImage!
    
    var selectedButtonImage:UIImage!
    var disselectButtonImage:UIImage!
    
    var startButtonImage:UIImage!
    var stopButtonImage:UIImage!
    
    
    var startTime:NSTimeInterval!
    var endTime:NSTimeInterval!
    
    var currentDate:String!
    
    
    var isShowStop = false
    var allPoints:[EbickPoint]! = []
    var currentPoints:[EbickPoint]! = []
    
    var currentOverlys:[BMKPolyline]! = []
    
    var currentProcess:CGFloat = 0
    
    var looper:CADisplayLink?
    
    var  duration:CFTimeInterval?;
    var  timeOffset:CFTimeInterval?;
    var  lastStep:CFTimeInterval?;
    
    
    
    override func viewDidLoad() {
        var top:CGFloat = 1; // 顶端盖高度
        var bottom:CGFloat = 1; // 底端盖高度
        var left:CGFloat = 1; // 左端盖宽度
        var right:CGFloat = 1; // 右端盖宽度
        var insets = UIEdgeInsetsMake(top, left, bottom, right);
        
        processBGImage = UIImage(named: "speed_bg")
        processBGImage = processBGImage?.resizableImageWithCapInsets(insets, resizingMode: UIImageResizingMode.Stretch)
        
        processCurrentImage = UIImage(named: "speed_current")
        processCurrentImage = processCurrentImage?.resizableImageWithCapInsets(insets, resizingMode: UIImageResizingMode.Stretch)
        
        
        
        processLineBgImageView.image = processBGImage
        currentProcessLineImageview.image = processCurrentImage
        
        selectedButtonImage = UIImage(named: "speed_slect")
        disselectButtonImage = UIImage(named: "speed_unslect")
        
        
        startButtonImage = UIImage(named: "play_start")
        stopButtonImage = UIImage(named: "play_stop")
        
        
        var recognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        
        recognizer.delegate = self
        self.currentProcessButton.addGestureRecognizer(recognizer)
        
        
        var taprecognizer = UITapGestureRecognizer(target: self, action: "tapGesture:")
        taprecognizer.delegate = self
        
        self.tapview.addGestureRecognizer(recognizer)
        
        playview.addTopBorderWithHeight(1, color: CommonUtil.UIColorFromRGBA(0xababab, alpha: 0.3))
        
        var temp = CommonUtil.FloatToDate(self.startTime,format:"yyyy-MM-dd")
        
        if(temp == currentDate || currentDate == "今日"){
            
            currentProcessStartTimeLable.text = CommonUtil.FloatToDate(self.startTime,format:"HH:mm")
        }else{
            
            currentProcessStartTimeLable.text = CommonUtil.FloatToDate(self.startTime,format:"yy/MM/dd HH:mm")
        }
        
        
        currentProcessEndTimeLable.text = CommonUtil.FloatToDate(self.endTime,format:"HH:mm")
        
        
        initUI()
        
        GetTrance()
        
    }
    
    
    func GetTrance(){
        
        CommonUtil.GCDThread({()in
            
            GpsService.sharedGpsService.GetEbickTranceHistoryRecords({(data)in
                if(data["status"].int == StatusCode.SystemSC.SYSTEM_OK){
                    
                    println(data)
                    
                    var tranceData:TranceData = Mapper<TranceData>().map(data["data"].dictionaryObject!)
                    
                    self.allPoints = self.addpoint(tranceData.trajectory)
                    
                    self.clearmapPoints()
                    
                    self.drawMapPoint(self.allPoints)
                    
                    
                    self.drawMapPoint(self.allPoints)
                    
                    self.setCurrnetProcess(self.currentProcess)
                    
                    var coordinate = CLLocationCoordinate2D(latitude: (tranceData.mbr[0].lat + tranceData.mbr[1].lat + tranceData.mbr[2].lat + tranceData.mbr[3].lat) / 4, longitude: (tranceData.mbr[0].lng + tranceData.mbr[1].lng + tranceData.mbr[2].lng + tranceData.mbr[3].lng) / 4)
                    
                    
                    
                    
                    func getMaxAbs() -> CLLocationCoordinate2D{
                        
                        //                        var a = CLLocationCoordinate2D(latitude: 0, longitude: 0)
                        //                        var b = CLLocationCoordinate2D(latitude: 0, longitude: 0)
                        //
                        //                        BMKMapPoint point1 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(39.915,116.404));
                        //                        BMKMapPoint point2 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(38.915,115.404));
                        //                        CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
                        
                        var lat:Double = 0
                        var lng:Double = 0
                        
                        for var i = 0; i < tranceData.mbr.count; i++
                        {
                            
                            
                            var temp1 = tranceData.mbr[i].lat - coordinate.latitude
                            var temp2 = tranceData.mbr[i].lng - coordinate.longitude
                            
                            if(i == 0){
                                lat = fabs(temp1)
                                lng = fabs(temp2)
                                continue
                            }
                            
                            
                            if temp1 < 0 {
                                temp1 = -temp1
                            }
                            
                            if(temp1 > lat){
                                
                                lat = temp1
                            }
                            
                            
                            if temp2 < 0 {
                                temp2 = -temp2
                            }
                            
                            if(temp2 > lng){
                                
                                lng = temp2
                            }
                            
                        }
                        
                        return CLLocationCoordinate2D(latitude: lat, longitude: lng)
                    }
                    
                    var max = CLLocationCoordinate2D(latitude: 0, longitude: 0)
                    var min = CLLocationCoordinate2D(latitude: 0, longitude: 0)
                    
                    for var i = 0; i < tranceData.mbr.count; i++
                    {
                        var temp = tranceData.mbr[i]
                        
                        if(i == 0){
                            max = CLLocationCoordinate2D(latitude: temp.lat, longitude: temp.lng)
                            min = CLLocationCoordinate2D(latitude: temp.lat, longitude: temp.lng)
                            continue
                        }
                        
                        if(temp.lat >= max.latitude){
                            max.latitude = temp.lat
                        }
                        
                        if(temp.lat <= min.latitude){
                            min.latitude = temp.lat
                        }
                        
                        if(temp.lng >= max.longitude){
                            max.longitude = temp.lng
                        }
                        
                        if(temp.lng <= min.longitude){
                            min.longitude = temp.lng
                        }
                        
                    }
                    
                    
                    var xdis = BMKMetersBetweenMapPoints(BMKMapPointForCoordinate(CLLocationCoordinate2DMake(min.latitude,min.longitude)),BMKMapPointForCoordinate(CLLocationCoordinate2DMake(max.latitude,min.longitude)));
                    
                    var ydis = BMKMetersBetweenMapPoints(BMKMapPointForCoordinate(CLLocationCoordinate2DMake(min.latitude,min.longitude)),BMKMapPointForCoordinate(CLLocationCoordinate2DMake(min.latitude,max.longitude)));
                    
                    
                    
                    
                    var region = BMKCoordinateRegionMakeWithDistance(coordinate, xdis, ydis+400)
                    
                    var  adjustedRegion = self.mpview!.regionThatFits(region)
                    
                    //                    var temp:CLLocationCoordinate2D = getMaxAbs()
                    //
                    //                    region.center = coordinate;//中心点
                    //                    region.span.latitudeDelta = temp.latitude + 0.01;//经度范围（设置为0.1表示显示范围为0.2的纬度范围）
                    //                    region.span.longitudeDelta = temp.longitude;//纬度范围
                    
                    
                    
                    self.mpview?.setRegion(adjustedRegion, animated: true)
                    
                    //
                    //
                    //
                    //                    MKCoordinateRegion用来设置坐标显示范围。
                    //                    包括两部分：Center（CLLocationCoordinate2D struct，包括latitude和longitude），坐标中心
                    //                    和Span（MKCoordinateSpan struct，包括latitudeDelta和longitudeDelta），缩放级别
                    //                    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(center,2000, 2000);
                    //                    以上代码创建一个以center为中心，上下各1000米，左右各1000米得区域，但其是一个矩形，不符合MapView的横纵比例
                    //                    MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];
                    //                    以上代码创建出来一个符合MapView横纵比例的区域
                    //                    [mapView setRegion:adjustedRegion animated:YES];
                    
                    //                    self.mpview?.regionThatFits(region)
                    
                    
                    
                }
                
                }, errorHandler: {(data)in
                    
                    
                }, startTime: String(format:"%.0f", self.startTime)
                , endTime: String(format:"%.0f", self.endTime), ebickId: Cache.EBICK.id.description)
            
            
            
            }, afterdo: nil)
        
    }
    
    var currentSpeend = 20.0
    
    
    
    func initUI(){
        
        self.mpview = BMKMapView();
        self.mapview.addSubview(self.mpview!)
        mpview?.delegate=self;
        
        
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        
        self.navigationItem.title = "轨迹回放"
        
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        
        
        
        var button = UIButton()
        
        var size = CGRect();
        var size2 = CGSize();
        size =  self.currentDate!.boundingRectWithSize(size2, options: NSStringDrawingOptions.UsesFontLeading, attributes: nil, context: nil);
        
        
        
        button.frame = CGRectMake(0.0, 0,size.width, size.height);
        button.titleLabel?.textAlignment = NSTextAlignment.Right
        button.setTitle(self.currentDate, forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(10)
        
        button.setTitleColor(CommonUtil.UIColorFromRGB(0xffffff), forState: UIControlState.Normal)
        
        
        //        button.enabled = false
        
        var baritem = UIBarButtonItem(customView: button)
        
        self.navigationItem.rightBarButtonItem = baritem
        
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        mpview?.delegate=self;
        
        
        looper?.invalidate()
        looper = CADisplayLink(target: self, selector: Selector("refreshProcess"))
        looper?.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
        
        lastStep = CACurrentMediaTime()
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        mpview?.delegate=nil;
        
        looper?.invalidate()
    }
    
    func clearmapPoints(){
        currentOverlys?.removeAll(keepCapacity: false)
        mpview?.removeOverlays(mpview?.overlays)
        mpview?.removeAnnotations(mpview?.annotations)
        
        
    }
    
    
    
    func drawCurrentPoint(index:Int){
        
        if(index >= allPoints.count) {
            return
        }
        
        
        
        
        //删除当前的mark
        
        
        for annotation in mpview!.annotations {
            if (annotation.isKindOfClass(BMKPointAnnotationExt)){
                var temp  = annotation as! BMKPointAnnotationExt
                if(temp.pointtype == StatusCode.CURRENT_PO){
                    mpview?.removeAnnotation(temp)
                }
            }
            
        }
        if(mpview!.overlays.count > 2){
            
            if(currentOverlys.count > 2){
                
                mpview?.removeOverlay(currentOverlys.last)
                
                
                currentOverlys.removeLast()
            }
            
        }
        
        
        
        
        currentPoints.removeAll(keepCapacity: false)
        
        for var i = 0;i<index+1;i++ {
            var point = allPoints[i]
            point.type = nil
            if(i == index){
                point.type = StatusCode.CURRENT_PO
            }
            currentPoints.append(point)
        }
        
        if(self.startStatus){
            mpview?.setCenterCoordinate( CLLocationCoordinate2D(latitude: currentPoints[currentPoints.count - 1].lat, longitude: currentPoints[currentPoints.count - 1].lng), animated: false)
            
        }
        
        drawMapPoint(currentPoints)
        
        
        
        
        
    }
    
    
    func drawMapPoint(points:[EbickPoint]?) -> Void {
        
        if(points == nil) {
            return
        }
        
        var coors:[CLLocationCoordinate2D] = [];
        //            // 1起始点 2停顿点 3结束点
        for (index,ebickpoint:EbickPoint) in enumerate(points!) {
            
            self.setBMKPointAnnotation(index,ebickpoint:ebickpoint)
            coors.append( CLLocationCoordinate2D(latitude:ebickpoint.lat, longitude: ebickpoint.lng))
        }
        
        
        var polyline = BMKPolyline(coordinates: &coors, count: UInt(coors.count))
        
        
        self.currentOverlys.append(polyline)
        
        self.mpview?.addOverlay(polyline);
        //            mpview?.setCenterCoordinate(coors[coors.count-1], animated: true)
        self.mpview?.viewForOverlay(polyline);
        
        
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
    
    func setBMKPinAnnotationView(type:Int,view:BMKPinAnnotationViewExt) -> BMKPinAnnotationViewExt? {
        
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
            imageName = "trance_end"
            
            img = UIImage(named: imageName)
            view.image=img;
            view.centerOffset = CGPointMake((view.frame.size.width * 0.01), -(view.frame.size.height * 0.35));
            view.title = "当前位置"
            
            break;
        case StatusCode.STOP_PO:
            
            if(!isShowStop){
                return nil
            }
            
            imageName = "stop"
            
            img = UIImage(named: imageName)
            view.image=img;
            view.centerOffset = CGPointMake(0, 0);
            view.title = "中途停车位置"
            
            break;
            
        case StatusCode.CURRENT_PO:
            imageName = "trance_point"
            
            img = UIImage(named: imageName)
            view.image=img;
            view.centerOffset = CGPointMake(0, 0);
            view.title = "当前位置"
            
            break;
            
        default:
            
            break;
            
        }
        
        
        
        return view
    }
    
    
    
    
    func mapView(mapView: BMKMapView!, viewForOverlay overlay: BMKOverlay!) -> BMKOverlayView! {
        if(overlay.isKindOfClass(BMKPolyline)){
            var polylineView=BMKPolylineView(overlay: overlay);
            if(currentOverlys[0] == (overlay as! BMKPolyline)){
                
                polylineView.strokeColor = CommonUtil.UIColorFromRGB(0x000000).colorWithAlphaComponent(1);
                polylineView.lineWidth = 6.0;
                
            }else if(currentOverlys[1] == (overlay as! BMKPolyline)){
                
                polylineView.strokeColor = CommonUtil.UIColorFromRGB(0xafc0d2).colorWithAlphaComponent(1);
                polylineView.lineWidth = 4.0;
                
            }else{
                
                polylineView.strokeColor = CommonUtil.UIColorFromRGB(0x3cc1fc).colorWithAlphaComponent(1);
                polylineView.lineWidth = 4.0;
            }
            
            return polylineView;
            
        }
        
        return nil;
    }
    
    
    func mapView(mapView: BMKMapView!, viewForAnnotation annotation: BMKAnnotation!) -> BMKAnnotationView! {
        if  (annotation.isKindOfClass(BMKPointAnnotationExt)) {
            
            var newAnnotationView = BMKPinAnnotationViewExt(annotation: annotation, reuseIdentifier: "myAnnotation"); //(); alloc] initWithAnnotation:annotation reuseIdentifier:@ "myAnnotation" ];
            var annotationtemp = annotation as! BMKPointAnnotationExt
            
            newAnnotationView.index = annotationtemp.pointindex
            
            newAnnotationView = setBMKPinAnnotationView(annotationtemp.pointtype,view:newAnnotationView)
            
            newAnnotationView?.animatesDrop = false
            
            return  newAnnotationView;
            
        }
        return  nil;
    }
    
    
    
    
    /**
    * 进行两个点之间的插值处理
    *
    * @param beginPoint
    *            起始点
    * @param endPoint
    *            终止点
    * @param interpolationCount
    *            插值个数
    * @param interpolationPoints
    *            插值后的返回值
    */
    func processInterpolation(beginPoint:EbickPoint,endPoint:EbickPoint,interpolationCount:Int,interpolationPoints:[EbickPoint]) ->[EbickPoint]{
        
        var interalTime:NSTimeInterval = 0;
        var lng = Double(endPoint.lng - beginPoint.lng)
            / Double(interpolationCount);
        var lat = Double(endPoint.lat - beginPoint.lat)
            / Double(interpolationCount);
        var startTime = beginPoint.locationTime;
        var endTime = endPoint.locationTime;
        if (startTime != nil && endTime != nil
            && (interpolationCount != 0)) {
                interalTime = (endTime - startTime)
                    / Double(interpolationCount)
        }
        
        // 当前插入点的时间信息
        // 按照次数进行插值
        // 最后一个点不插,留到下一个循环的起点再插
        var points:[EbickPoint] = []
        
        // 插入点的时间信息
        for (var i = 1; i < interpolationCount; i++) {
            var polysonPlayPoint = EbickPoint()
            polysonPlayPoint.lng = beginPoint.lng + lng
                * Double(i)
            polysonPlayPoint.lat = beginPoint.lat + lat * Double(i)
            
            if(startTime != nil){
                polysonPlayPoint.locationTime = startTime + interalTime * Double(i)
                
            }
            
            points.append(polysonPlayPoint)
            
        }
        return points
        
    }
    
    
    
    /**
    * 对轨迹列表进行位置点插值处理
    *
    * @param points
    *            List<Point> 需要被插值的源轨迹位置点列表
    * @return List<Point> 被插值后的轨迹位置点列表
    */
    func getInterpolationPoints(points:[EbickPoint]?) -> [EbickPoint]?{
        
        if (points == nil || points!.count == 0) {
            return points;
        }
        // 定义最小切割距离
        var perDistanceMin:Int = 200;
        // 定义每次循环的开始点、结束点
        var beginPoint:EbickPoint, endPoint:EbickPoint;
        // 定义每次循环的开始点、结束点之间的距离
        var distance:Double;
        // 定义每次循环的开始点结束点之间的插值次数
        var interpolationCount:Int = 0;
        // 被插值后的轨迹位置点列表
        
        
        
        var interpolationPoints:[EbickPoint] = [];
        
        for (var i = 0; i < points!.count - 1; i++) {
            beginPoint = points![i];
            endPoint = points![i+1];
            distance = CommonUtil.getDistance(beginPoint.lng, lat1: beginPoint.lat,
                lng2: endPoint.lng, lat2: endPoint.lat);
            // 算出插值的次数, 取顶值
            interpolationCount = Int(ceil(distance / Double(perDistanceMin)));
            // 把开始点加进列表
            interpolationPoints.append(beginPoint)
            // 把插值点加进列表
            interpolationPoints += processInterpolation(beginPoint, endPoint: endPoint, interpolationCount: interpolationCount,
                interpolationPoints: interpolationPoints);
        }
        // 把最后一个点加进列表
        interpolationPoints.append(points![points!.count-1])
        return interpolationPoints;
        
    }
    
    
    
    
    
    func addpoint(points:[EbickPoint]) -> [EbickPoint]? {
        return getInterpolationPoints(points)
    }
    
    
    
    func refreshProcess(){
        
        
        var thisStep = CACurrentMediaTime()
        
        var stepDuration1 = thisStep - self.lastStep!;
        
        self.lastStep = thisStep;
        
        var difference =  (100.0 *  stepDuration1 / self.currentSpeend)
        
        if(self.startStatus){
            
            self.setCurrnetProcess(self.currentProcess + CGFloat(difference))
            
            
        }else{
            
            
        }
        
        
    }
    
    
    
    override func viewDidLayoutSubviews() {
        mpview!.frame=self.mapview.frame;
        
        mpview?.showMapScaleBar = true
        //自定义比例尺的位置
        mpview?.mapScaleBarPosition = CGPointMake(3, self.mapview.frame.size.height-33)
        
        
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    
    func currentTime(process:CGFloat) -> String {
        
        var total = NSTimeInterval(Double(endTime - startTime) * (Double(process)/100.0))
        
        return CommonUtil.FloatToDate(self.startTime+total,format:"HH:mm")
        
    }
    
    
    func setCurrnetProcess(process:CGFloat){
        if(process > 100){
            
            self.setStartStop(false)
        }
        
        
        
        self.currentProcess = process
        
        var totallength = processLineBgView.frame.size.width
        
        
        var currentlength = (process/100.0)*(totallength-10)
        
        currentProcessViewWidthSpace?.constant = currentlength
        
        
        
        
        if ((currentlength+5) > currentProcessTimeLable.frame.size.width / 2.0)
        {
            
            if( currentlength + 5 + currentProcessTimeLable.frame.size.width / 2.0 > totallength){
                currentProcessTimeLable.text = CommonUtil.FloatToDate(self.endTime,format:"HH:mm")
                currentTimeLableLeftSpace?.constant = totallength - currentProcessTimeLable.frame.width
                
            }else{
                currentProcessTimeLable.text = currentTime(process)
                currentTimeLableLeftSpace?.constant = currentlength + 5 - currentProcessTimeLable.frame.width/2.0
            }
            
            
        }else{
            currentProcessTimeLable.text = CommonUtil.FloatToDate(self.startTime,format:"HH:mm")
            currentTimeLableLeftSpace?.constant = 0
            
        }
        
        if(process<=0){
            drawCurrentPoint(Int(Double(self.allPoints.count) * Double(0/100.0)))
            return
        }
        if(process>=100){
            drawCurrentPoint(Int(Double(self.allPoints.count-1)))
            return
        }
        
        drawCurrentPoint(Int(Double(self.allPoints.count) * Double(process/100.0)))
        
        
        
    }
    
    func setButtonSelected(button:UIButton){
        slowButton.setBackgroundImage(disselectButtonImage, forState: UIControlState.Normal)
        normalButton.setBackgroundImage(disselectButtonImage, forState: UIControlState.Normal)
        fastButton.setBackgroundImage(disselectButtonImage, forState: UIControlState.Normal)
        
        slowButton.setTitleColor(CommonUtil.UIColorFromRGB(0x2bcd9c), forState: UIControlState.Normal)
        normalButton.setTitleColor(CommonUtil.UIColorFromRGB(0x2bcd9c), forState: UIControlState.Normal)
        fastButton.setTitleColor(CommonUtil.UIColorFromRGB(0x2bcd9c), forState: UIControlState.Normal)
        
        button.setBackgroundImage(selectedButtonImage, forState: UIControlState.Normal)
        button.setTitleColor(CommonUtil.UIColorFromRGB(0xffffff), forState: UIControlState.Normal)
        
        
        
    }
    
    @IBOutlet weak var startAndStopButton: UIButton!
    
    var startStatus = false
    
    @IBAction func startAndStopButtonAction(sender: AnyObject) {
        
        
        if(startStatus){
            startAndStopButton.setImage(startButtonImage, forState: UIControlState.Normal)
            startStatus = false
        }else{
            
            startAndStopButton.setImage(stopButtonImage, forState: UIControlState.Normal)
            startStatus = true
            if(self.currentProcess > 100){
                setCurrnetProcess(0)
            }
        }
        
        
    }
    
    
    func setStartStop(status:Bool){
        
        if(!status){
            startAndStopButton.setImage(startButtonImage, forState: UIControlState.Normal)
            startStatus = false
        }else{
            
            startAndStopButton.setImage(stopButtonImage, forState: UIControlState.Normal)
            startStatus = true
        }
        
    }
    
    @IBAction func slowButtonAction(sender: AnyObject) {
        
        currentSpeend = 30.0
        
        
        setButtonSelected(slowButton)
    }
    
    
    @IBAction func normalButtonAction(sender: AnyObject) {
        
        currentSpeend = 20.0
        
        setButtonSelected(normalButton)
    }
    
    
    @IBAction func fastButtonAction(sender: AnyObject) {
        
        currentSpeend = 10.0
        
        setButtonSelected(fastButton)
    }
    
    
    var currentlength:CGFloat!
    //MARK: - horizontal pan gesture methods
    func handlePan(recognizer: UIPanGestureRecognizer) {
        
        var totallength = processLineBgView.frame.size.width
        
        
        
        let translation = recognizer.translationInView(self.currentProcessButton)
        // 1
        if recognizer.state == .Began {
            currentlength = self.currentProcessViewWidthSpace.constant
            //            println("start:  \(translation)")
        }
        // 2
        if recognizer.state == .Changed {
            
            //             println("move:  \(translation)")
        }
        // 3
        if recognizer.state == .Ended {
            //             println("end:  \(translation)")
        }
        
        
        if(currentlength + translation.x < 0){
            self.setCurrnetProcess(0)
            return
        }
        if(currentlength + translation.x > totallength){
            self.setCurrnetProcess(100)
            return
        }
        
        
        self.setCurrnetProcess(((currentlength+translation.x) / totallength)*100)
        
        //        self.setStartStop(false)
        
    }
    
    func tapGesture(gesture:UITapGestureRecognizer){
        
        
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        
        var  point = touch.locationInView(self.currentProcessButton)
        
        currentlength = self.currentProcessViewWidthSpace.constant
        var totallength = processLineBgView.frame.size.width
        
        if(currentlength + point.x < 0){
            self.setCurrnetProcess(0)
            return true
        }
        if(currentlength + point.x > totallength){
            self.setCurrnetProcess(100)
            return true
        }
        
        
        self.setCurrnetProcess(((currentlength+point.x) / totallength)*100)
        //        self.setStartStop(false)
        
        
        return true
    }
    
    
    
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
    
    
    
    
    
    
}


