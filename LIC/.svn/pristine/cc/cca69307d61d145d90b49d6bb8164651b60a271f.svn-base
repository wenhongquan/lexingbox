//
//  AlarmMapController.swift
//  LIC
//
//  Created by 温红权 on 15/4/7.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation
//import ObjectMapper


class AlarmMapController :BaseController,BMKMapViewDelegate,UIGestureRecognizerDelegate {

    @IBOutlet weak var location: UIButton!
    @IBOutlet weak var tipview: UIView!

  
    @IBOutlet weak var mapview: UIView!
    @IBOutlet weak var tipTimeLable: UILabel!
    @IBOutlet weak var tiplocationLable: UILabel!
    @IBOutlet weak var tiptitleLable: UILabel!
    
    var message:Msg!
    
    var mpview:BMKMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        InitUI()
    }
    
    
    @IBAction func locationAction(sender: AnyObject) {
        
        if(ebickPoints.count>0){
            if(message.type == StatusCode.MSG_OUTAGE){
                var point = CLLocationCoordinate2D(latitude:ebickPoints[0].lat, longitude: ebickPoints[0].lng)
                mpview?.setCenterCoordinate(point, animated: true)
                
            }else{
                
                var point = CLLocationCoordinate2D(latitude:ebickPoints[ebickPoints.count-1].lat, longitude: ebickPoints[ebickPoints.count-1].lng)
                mpview?.setCenterCoordinate(point, animated: true)
            
            }
            
        }

        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        mpview?.viewWillAppear()
        mpview?.delegate=self;
        
          disableNetWork = true
        if(BaseString.NetWorkEnable){
            networkEnable()
        }else{
            networkDisable()
        }
        
        
        getTrajector()
  

    
    }
    
    override func viewWillDisappear(animated: Bool) {
       
        
         mpview?.delegate=nil;
        if(mpview != nil ){
        
           mpview = nil
        }
    
        
        
    }

    
    override func viewWillLayoutSubviews() {
        
        mpview?.frame=mapview.frame;
        
        mpview?.showMapScaleBar = true
        //自定义比例尺的位置
        mpview?.mapScaleBarPosition = CGPointMake(10, mapview.frame.size.height-100)
        self.view.bringSubviewToFront(self.tipview)
        self.mapview.bringSubviewToFront(self.location)
        
    }
    
    
    func InitUI(){
    
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        
        self.navigationItem.title = "消息详情"
        
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        
        
        self.mpview = BMKMapView();
        mapview.addSubview(self.mpview!)
        self.mpview!.zoomLevel = 16

        var tapGesture = UITapGestureRecognizer(target: self, action: "tapGesture:")
        tapGesture.delegate = self
        self.mpview?.addGestureRecognizer(tapGesture)
        
        
        
    }
    
    
    func tapGesture(gesture:UITapGestureRecognizer){
        
        
        
    }
    
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        
        var touchClassName = NSStringFromClass(touch.view.classForCoder)
        
        if(touch.view.isKindOfClass(BMKPinAnnotationViewExt)){
            
           self.didSelectAnnotationView(touch.view as! BMKPinAnnotationViewExt)
        
        }else{
           
           self.didDeselectAnnotationView()
        }
        
        
        
        return false
    }

    
     var ebickPoints:[EbickPoint]!
    
    
    func getTrajector(){
        
        GpsService.sharedGpsService.GetEbickEventTrajectory({(data) in
            if(data["status"].int == StatusCode.SystemSC.SYSTEM_OK){
                
                println(data)
                self.ebickPoints = Mapper<EbickPoint>().mapArray(data["data","trajectory"].arrayObject!)
                self.drawMapPoint(self.ebickPoints);
                
            }
            
            
            
            }, errorHandler: {(data) in
                
                
        }, eventId: message.detailsId, ebickId: Double(Cache.EBICK.id), userId: Double(Cache.USER.id))
    
    
    }
 
    
    func drawMapPoint(points:[EbickPoint]) -> Void {
        
        
        if(points.count > 0){
            mpview?.removeOverlays(mpview?.overlays)
            mpview?.removeAnnotations(mpview?.annotations)
            
            
            if(message.type == StatusCode.MSG_OUTAGE){

                var point = CLLocationCoordinate2D(latitude:points[0].lat, longitude: points[0].lng)
                var annotation=BMKPointAnnotationExt();
                annotation.coordinate = point;
                annotation.title = "alarm_power"
                annotation.pointindex = 0
                mpview?.addAnnotation(annotation);
                
                mpview?.setCenterCoordinate(point, animated: true)
                
                
                
            }else{
            
            
            var coors:[CLLocationCoordinate2D] = [];
            // 1起始点 2停顿点 3结束点
            for (index,ebickpoint:EbickPoint) in enumerate(points) {
          
                setBMKPointAnnotation(index,ebickpoint:ebickpoint)
               coors.append( CLLocationCoordinate2D(latitude:ebickpoint.lat, longitude: ebickpoint.lng))
            }
            
            var polyline = BMKPolyline(coordinates: &coors, count: UInt(coors.count))
            
            mpview?.addOverlay(polyline);
            mpview?.setCenterCoordinate(coors[coors.count-1], animated: true)
            mpview?.viewForOverlay(polyline);
                
                
            }
        }
        
    }
    
    func mapView(mapView: BMKMapView!, viewForOverlay overlay: BMKOverlay!) -> BMKOverlayView! {
        if(overlay.isKindOfClass(BMKPolyline)){
            
            var polylineView=BMKPolylineView(overlay: overlay);
            polylineView.strokeColor = UIColor.redColor().colorWithAlphaComponent(1);
            polylineView.lineWidth = 3.0;
            return polylineView;
            
        }
        
        
        
        return nil;
    }
    

    
    
    func mapView(mapView: BMKMapView!, viewForAnnotation annotation: BMKAnnotation!) -> BMKAnnotationView! {
        if  (annotation.isKindOfClass(BMKPointAnnotationExt)) {
            
            var newAnnotationView = BMKPinAnnotationViewExt(annotation: annotation, reuseIdentifier: "myAnnotation"); //(); alloc]

            var annotationtemp = annotation as! BMKPointAnnotationExt
            
            newAnnotationView.index = annotationtemp.pointindex
            
            newAnnotationView = setBMKPinAnnotationView(annotationtemp.pointtype,view:newAnnotationView)
           
            return  newAnnotationView;
        }
        return  nil;
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
    
        UIView.animateWithDuration(0.4, animations: {
            
            self.tipview.frame.origin = CGPoint(x: self.tipview.frame.origin.x, y: self.mapview.frame.size.height+65)
            
        })

    }
    
    
    func didSelectAnnotationView(view:BMKPinAnnotationView){
    
        if(view.isKindOfClass(BMKPinAnnotationViewExt)){
            
            var viewtemp = view as! BMKPinAnnotationViewExt
            
            if(viewtemp.index>ebickPoints.count) {
                return
            }
            
            var ebickpoint:EbickPoint = ebickPoints[viewtemp.index]
            
            self.tipTimeLable.text = CommonUtil.formatDate(ebickpoint.time)
            
            self.tiplocationLable.text = ebickpoint.bdAddr
            
            self.tiptitleLable.text = viewtemp.title
            
            
            UIView.animateWithDuration(0.4, animations: {
                
                self.tipview.frame.origin = CGPoint(x:  self.tipview.frame.origin.x, y: self.mapview.frame.size.height-65)
                
            })
            
        }

    }
    
    
    func setBMKPinAnnotationView(type:Int,view:BMKPinAnnotationViewExt) -> BMKPinAnnotationViewExt {
        
        var imageName = ""
        var img:UIImage!
        
        view.canShowCallout = false
        
        switch type {
        
            case StatusCode.START_PO:
                
                imageName = "alarm_start"
                
                img = UIImage(named: imageName)
                view.image=img;
                view.centerOffset = CGPointMake((view.frame.size.width * 0.03), -(view.frame.size.height * 0.3));
                view.title = "报警时的位置"
                break;
            case StatusCode.END_PO:
                imageName = "alarm_current"
                
                img = UIImage(named: imageName)
                view.image=img;
                view.centerOffset = CGPointMake((view.frame.size.width * 0.03), -(view.frame.size.height * 0.3));
                view.title = "报警时的位置"
                
                break;
            case StatusCode.STOP_PO:
                imageName = "stop"
                
                img = UIImage(named: imageName)
                view.image=img;
                view.centerOffset = CGPointMake(0, 0);
                view.title = "中途停车位置"
                
                break;
            case StatusCode.CURRENT_PO:
                imageName = "alarm_current"
                
                img = UIImage(named: imageName)
                view.image=img;
                view.centerOffset = CGPointMake((view.frame.size.width * 0.03), -(view.frame.size.height * 0.3));
                view.title = "当前位置"
                
                break;
            case StatusCode.EVENT_AFTER_2_HOURS_PO:
                imageName = "alarm_current"
                
                img = UIImage(named: imageName)
                view.image=img;
                view.centerOffset = CGPointMake((view.frame.size.width * 0.03), -(view.frame.size.height * 0.3));
                view.title = "报警2小时后位置"
                
                break;
            case StatusCode.DATA_LOST_PO:
                imageName = "alarm_current"
                
                img = UIImage(named: imageName)
                view.image=img;
                view.centerOffset = CGPointMake((view.frame.size.width * 0.03), -(view.frame.size.height * 0.3));
                view.title = "信号丢失时的位置"
                
                break;
        
             default:
                
                imageName = "alarm_power"
                
                img = UIImage(named: imageName)
                view.image=img;
                view.centerOffset = CGPointMake((view.frame.size.width * 0.03), -(view.frame.size.height * 0.3));
                view.title = "设备断电位置"
                
                break;
        
        }
        
        
       
        
        return view
    }
    
    
    
    
    
    
}



