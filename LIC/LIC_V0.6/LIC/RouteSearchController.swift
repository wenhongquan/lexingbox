//
//  RouteSearchController.swift
//  LIC
//
//  Created by 温红权 on 15/5/5.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation
import MapKit


class RouteSearchController:BaseController,BMKMapViewDelegate,BMKRouteSearchDelegate {
    
    
    var mpview:BMKMapView?
    
    @IBOutlet weak var mapView: UIView!
    
    var _routesearch:BMKRouteSearch?
    
    @IBOutlet weak var navButton: UIButton!
    
    @IBOutlet weak var locationButton: UIButton!
    var startPt:CLLocationCoordinate2D!
    var endPt:CLLocationCoordinate2D!
    
    var busniess:Business?
    
    
    override func viewDidLoad() {
        initUI()
    }
    
    
    override func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
        super.didUpdateBMKUserLocation(userLocation)
        mpview?.updateLocationData(userLocation)
        
    }
    
    
    func initUI(){
        
        self.mpview = BMKMapView();
        self.mapView.addSubview(self.mpview!)
        self.mapView.bringSubviewToFront(navButton)
        self.mapView.bringSubviewToFront(locationButton)
        
        mpview?.delegate=self;
        
        mpview?.userTrackingMode = BMKUserTrackingModeFollow
        mpview?.showsUserLocation = true
        
        
        
        _routesearch = BMKRouteSearch()
        _routesearch?.delegate = self
        
        
        mpview?.setCenterCoordinate(startPt, animated: true)
        mpview?.zoomLevel = 16
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        self.navigationItem.title = "路线规划"
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        mpview?.delegate=self;
        _routesearch?.delegate = self
        
        
        var start = BMKPlanNode()
        start.pt = startPt
        var end = BMKPlanNode()
        end.pt = endPt
        
        var walkingRouteSearchOption = BMKWalkingRoutePlanOption()
        
        walkingRouteSearchOption.from = start
        walkingRouteSearchOption.to = end
        
        _routesearch?.walkingSearch(walkingRouteSearchOption)
        
        locationManager.startUserLocationService()
        
        availableMapsApps()
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        mpview?.delegate=nil;
        _routesearch?.delegate = nil
        
    }
    
    override func viewDidLayoutSubviews() {
        mpview!.frame=self.mapView.frame;
        
        
        mpview?.showMapScaleBar = true
        //自定义比例尺的位置
        mpview?.mapScaleBarPosition = CGPointMake(3, self.mapView.frame.size.height-75)
    }
    
    
    @IBAction func locationButtonAction(sender: AnyObject) {
        
        mpview?.setCenterCoordinate(CLLocationCoordinate2D(latitude: Cache.USER.latitude, longitude: Cache.USER.longitude), animated: true)
    }
    
    
    @IBAction func navButtonAction(sender: AnyObject) {
        
        
        if ((UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 8.0)  {
            
            let shareMenu = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
            
            
            for dic:NSDictionary in availableMaps {
                
                let temp = UIAlertAction(title: dic.objectForKey("name") as! String, style: UIAlertActionStyle.Default ) { (_) in
                    var url = dic.objectForKey("url") as! NSString
                    
                    url = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
                    
                    
                    UIApplication.sharedApplication().openURL(NSURL(string: url as String)!) ;
                    return
                }
                shareMenu.addAction(temp)
                
                
            }
            
            
            let cancelAction = UIAlertAction(title: "取消", style: .Cancel) { (_) in }
            
            
            shareMenu.addAction(cancelAction)
            
            
            
            
            
            shareMenu.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.allZeros
            
            shareMenu.popoverPresentationController?.sourceView = self.view
            shareMenu.popoverPresentationController?.sourceRect = CGRectMake((self.view.frame.size.width*0.5), (self.view.frame.size.height*0.5), 0, 0);// 显示在中心位置
            
            
            self.presentViewController(shareMenu, animated: true, completion: nil)
            
        }else{
            
            
            let shareMenu = UIActionSheetExt(title: nil, delegate: IosActionSheetDegetel.sharedIosActionSheetDegetel, cancelButtonTitle: nil, destructiveButtonTitle: nil)
            
            for dic:NSDictionary in availableMaps {
                
                shareMenu.addButtonWithTitle(dic.objectForKey("name") as! String)
                shareMenu.handles?.append({()in
                    var url = dic.objectForKey("url") as! NSString
                    
                    url = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
                    
                    if((dic.objectForKey("name") as! String) == "苹果地图"){
                        if ((UIDevice.currentDevice().systemVersion as NSString).doubleValue < 8.0)  {
                            var destCoord = CLLocationCoordinate2DMake(self.busniess!.gcj02Point!.lat, self.busniess!.gcj02Point!.lng)
                            var destPlacemark = MKPlacemark(coordinate: destCoord, addressDictionary: nil)
                            var destMapItem = MKMapItem(placemark: destPlacemark)
                            
                            var currentMapItem = MKMapItem.mapItemForCurrentLocation()
                            
                            MKMapItem.openMapsWithItems([currentMapItem,destMapItem], launchOptions: [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeWalking])
                            return
                        }
                    }
                    UIApplication.sharedApplication().openURL(NSURL(string: url as String)!) ;
                    
                    return
                })
                
                
            }
            
            
            shareMenu.addButtonWithTitle("取消")
            
            shareMenu.tag = StatusCode.ActionSheetSC.TEL
            shareMenu.cancelButtonIndex = availableMaps.count
            
            
            if(self.tabBarController != nil){
                shareMenu.showFromTabBar(self.tabBarController?.tabBar)
            }else{
                shareMenu.showInView(self.view)
            }
        }
        
        
    }
    
    var availableMaps:[NSDictionary] = []
    
    func availableMapsApps(){
        
        self.availableMaps.removeAll(keepCapacity: false);
        
        
        
        
        
        if UIApplication.sharedApplication().canOpenURL(NSURL(string:"baidumap://map/")!) {
            
            var urlString = "baidumap://map/direction?origin="+self.startPt.latitude.description+","+self.startPt.longitude.description+"&destination="+self.busniess!.bd09Point!.lat.description+","+self.busniess!.bd09Point!.lng.description+"&mode=walking"
            
            var dic:NSDictionary = [
                "name" : "百度地图",
                "url":urlString
            ]
            
            
            self.availableMaps.append(dic)
            
            
        }
        
        if UIApplication.sharedApplication().canOpenURL(NSURL(string:"iosamap://")!) {
            
            var urlString = "iosamap://navi?sourceApplication=lexingbox&backScheme=applicationScheme&poiname=fangheng&poiid=BGVIS&lat="+self.busniess!.gcj02Point!.lat.description+"&lon="+self.busniess!.gcj02Point!.lng.description+"&dev=0&style=2"
            
            
            var dic:NSDictionary = [
                "name" : "高德地图",
                "url":urlString
            ]
            
            
            self.availableMaps.append(dic)
            
        }
        
        
        
        
        var location = bd_decrypt(CLLocationCoordinate2D(latitude: self.startPt.latitude, longitude: self.startPt.longitude))
        
        var urlString = "http://maps.apple.com/?daddr="+self.busniess!.gcj02Point!.lat.description+","+self.busniess!.gcj02Point!.lng.description+"&saddr="+location.latitude.description+","+location.longitude.description
        
        var dic:NSDictionary = [
            "name" : "苹果地图",
            "url":urlString
        ]
        
        
        self.availableMaps.append(dic)
        
        
        
    }
    
    func bd_decrypt( bd:CLLocationCoordinate2D) ->CLLocationCoordinate2D
    {
        var x = bd.longitude - 0.0065
        var y = bd.latitude - 0.006;
        
        var z = sqrt(x * x + y * y) - 0.00002 * sin(y * M_PI);
        
        var theta = atan2(y, x) - 0.000003 * cos(x * M_PI);
        
        return CLLocationCoordinate2D(latitude: z * sin(theta), longitude: z * cos(theta))
        
    }
    
    
    
    func onGetWalkingRouteResult(searcher: BMKRouteSearch!, result: BMKWalkingRouteResult!, errorCode error: BMKSearchErrorCode) {
        
        mpview?.removeOverlays(mpview?.overlays)
        mpview?.removeAnnotations(mpview?.annotations)
        
        
        
        if (error.value == BMK_SEARCH_NO_ERROR.value) {
            
            
            var plan: BMKWalkingRouteLine = result.routes[0] as! BMKWalkingRouteLine
            var size = plan.steps.count
            var planPointCounts:Int32 = 0
            
            
            for (var i = 0; i < size; i++) {
                
                var transitStep:BMKWalkingStep = plan.steps[i] as! BMKWalkingStep
                
                if(i==0){
                    var item = BMKPointAnnotationExt()
                    item.coordinate = plan.starting.location;
                    item.pointtype=0
                    mpview?.addAnnotation(item)// 添加起点标注
                    
                }else if(i==size-1){
                    var item = BMKPointAnnotationExt()
                    item.coordinate = plan.terminal.location;
                    item.pointtype=1
                    mpview?.addAnnotation(item)// 添加起点标注
                }
                
                
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
            
            mpview?.addOverlay(polyLine) // 添加路线overlay
            
            
            
        }
        
        
    }
    
    func mapView(mapView: BMKMapView!, viewForOverlay overlay: BMKOverlay!) -> BMKOverlayView! {
        if(overlay.isKindOfClass(BMKPolyline)){
            
            var polylineView=BMKPolylineView(overlay: overlay);
            polylineView.strokeColor = CommonUtil.UIColorFromRGB(0x3cc1fc).colorWithAlphaComponent(1);
            polylineView.lineWidth = 4.0;
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
            
            return  newAnnotationView;
        }
        return  nil;
    }
    
    func setBMKPinAnnotationView(type:Int,view:BMKPinAnnotationViewExt) -> BMKPinAnnotationViewExt {
        
        var imageName = ""
        var img:UIImage!
        
        view.canShowCallout = false
        
        switch type {
            
        case 0:
            
            imageName = "start"
            
            img = UIImage(named: imageName)
            view.image=img;
            view.centerOffset = CGPointMake((view.frame.size.width * 0.01), -(view.frame.size.height * 0.35));
            view.title = "起点"
            break;
        case 1:
            imageName = "repair"
            
            img = UIImage(named: imageName)
            view.image=img;
            view.centerOffset = CGPointMake((view.frame.size.width * 0.01), -(view.frame.size.height * 0.35));
            view.title = "终点"
            
            break;
        default:
            
            break;
            
        }
        return view
    }
    
    
    
    
    
    
}