//
//  AreaSelectMapViewController.swift
//  LIC
//
//  Created by 温红权 on 15/5/29.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class AreaSelectMapViewController:BaseController,BMKMapViewDelegate,UITextViewDelegate{

    @IBOutlet weak var mapView: UIView!

    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var areaView: UIView!

    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var locationbgImage: UIImageView!
    @IBOutlet weak var addrTextFied: UITextView!
    @IBOutlet weak var phaLable: UILabel!
    @IBOutlet weak var bottomToBg: NSLayoutConstraint!
    
     var mpview:BMKMapView?
    override func viewDidLoad() {
        areaView.addTopBorderWithHeight(1, color: CommonUtil.UIColorFromRGB(0xd9d9d9))
        initUI()
    }
    
    
    @IBAction func locationButtonAction(sender: AnyObject) {
        
        setLocation()
    
    }
    var isfirst = false
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        mpview?.delegate=self;
        locationManager.startUserLocationService()
        isfirst = false
      
        
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        mpview?.delegate=nil;
        
    }
    
    override func viewDidLayoutSubviews() {
        mpview!.frame=self.mapView.frame;
        
        mpview?.zoomLevel = 16
        
        mpview?.showMapScaleBar = true
        //自定义比例尺的位置
        mpview?.mapScaleBarPosition = CGPointMake(3, self.mapView.frame.size.height-33)
        
    }
    
    override func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
//        super.didUpdateBMKUserLocation(userLocation)
        Cache.USER.latitude = userLocation.location.coordinate.latitude
        Cache.USER.longitude = userLocation.location.coordinate.longitude
        
//        var geoCodeOption = BMKReverseGeoCodeOption()
//        geoCodeOption.reverseGeoPoint = userLocation.location.coordinate
        
//        searchService.reverseGeoCode(geoCodeOption)
        
        
        
        if(!isfirst){
           mpview?.updateLocationData(userLocation)
           setLocation()
           isfirst = true
        }
      
        
    }
    
    override func onGetReverseGeoCodeResult(searcher: BMKGeoCodeSearch!, result: BMKReverseGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
        super.onGetReverseGeoCodeResult(searcher, result: result, errorCode: error)
        phaLable.hidden = true
        addrTextFied.text =  result.addressDetail.streetName +  result.addressDetail.streetNumber
        
        if(addrTextFied.text == ""){
            phaLable.hidden = false
            self.navigationItem.rightBarButtonItem?.enabled=false
        }else{
            phaLable.hidden = true
            self.navigationItem.rightBarButtonItem?.enabled=true
        }
     
    }
    
    
    func mapView(mapView: BMKMapView!, regionWillChangeAnimated animated: Bool) {
        UIView.animateWithDuration(0.5, animations: {
            
           self.bottomToBg.constant = 15
           self.locationImage.layoutIfNeeded()
        
        })
       
    }
    
    func mapView(mapView: BMKMapView!, onClickedMapBlank coordinate: CLLocationCoordinate2D) {
        UIView.animateWithDuration(0.5, animations: {
            
            self.bottomToBg.constant = 0
            self.locationImage.layoutIfNeeded()
        })
    }
    
    
    
    func mapView(mapView: BMKMapView!, regionDidChangeAnimated animated: Bool) {

        UIView.animateWithDuration(0.5, animations: {
            
            self.bottomToBg.constant = 0
            self.locationImage.layoutIfNeeded()
        })
        EbickBrandAddTableData.EbickBrandLocation.latitude = mapView.centerCoordinate.latitude
        EbickBrandAddTableData.EbickBrandLocation.longitude = mapView.centerCoordinate.longitude
        
        var geoCodeOption = BMKReverseGeoCodeOption()
        geoCodeOption.reverseGeoPoint = mapView.centerCoordinate
        
        searchService.reverseGeoCode(geoCodeOption)
    }
    
    func mapView(mapView: BMKMapView!, annotationViewForBubble view: BMKAnnotationView!) {
        view.canShowCallout = false
        view.exclusiveTouch = false
    }
    
    
    func setLocation(){
        if(Cache.USER?.longitude != nil){
            mpview?.setCenterCoordinate(CLLocationCoordinate2D(latitude:Cache.USER.latitude, longitude: Cache.USER.longitude), animated:false)
            mpview?.removeAnnotations(mpview?.annotations)
            var point = CLLocationCoordinate2D(latitude:Cache.USER.latitude, longitude: Cache.USER.longitude)
            var annotation=BMKPointAnnotationExt();
            annotation.coordinate = point;
            mpview?.addAnnotation(annotation);
        }

        
    
      
    
    }
    
    
    func mapView(mapView: BMKMapView!, viewForAnnotation annotation: BMKAnnotation!) -> BMKAnnotationView! {
        if  (annotation.isKindOfClass(BMKPointAnnotationExt)) {
            
            var newAnnotationView = BMKPinAnnotationViewExt(annotation: annotation, reuseIdentifier: "myAnnotation"); //(); alloc] initWithAnnotation:annotation reuseIdentifier:@ "myAnnotation" ];
            var annotationtemp = annotation as! BMKPointAnnotationExt
            
            newAnnotationView.index = annotationtemp.pointindex
            newAnnotationView.canShowCallout = false
           
           
            
            var imageName = "mylocation"
            var img = UIImage(named: imageName)
            newAnnotationView.image=img;
            newAnnotationView.centerOffset = CGPointMake(0, 0);

           
            
            return  newAnnotationView;
        }
        return  nil;
    }
    


    
    func initUI(){
        
        self.mpview = BMKMapView();
        
//        mpview?.userTrackingMode = BMKUserTrackingModeFollow
//        mpview?.showsUserLocation = true
        self.mapView.addSubview(self.mpview!)
        self.mapView.bringSubviewToFront(areaView)
        self.mapView.bringSubviewToFront(locationbgImage)
        self.mapView.bringSubviewToFront(locationImage)
        self.mapView.bringSubviewToFront(locationButton)
        mpview?.delegate=self;
//        mpview?.userTrackingMode = BMKUserTrackingModeFollow
//        mpview?.showsUserLocation = true
       
        

        
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        self.navigationItem.title = "详细地址"
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        
        
        
        CommonUtil.setNavigationControllerBackground(self)
        
        self.navigationItem.leftItemsSupplementBackButton = false
        
        
        var button = UIButton()
        
        button.frame = CGRectMake(0.0, 2.0,40, 34);
        button.titleLabel?.textAlignment = NSTextAlignment.Right
        button.addTarget(self, action: "compleate", forControlEvents: UIControlEvents.TouchUpInside)
        button.setTitle("完成", forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(17)
        button.setTitleColor(CommonUtil.UIColorFromRGB(0x01624b), forState: UIControlState.Disabled)
        button.setTitleColor(CommonUtil.UIColorFromRGB(0x2bcd9c), forState: UIControlState.Normal)
        button.setTitleColor(CommonUtil.UIColorFromRGB(0x01624b), forState: UIControlState.Selected)
        button.setTitleColor(CommonUtil.UIColorFromRGB(0x01624b), forState: UIControlState.Highlighted)
        
        //        button.enabled = false
        
        var baritem = UIBarButtonItem(customView: button)
        
        self.navigationItem.rightBarButtonItem = baritem
        
        self.navigationItem.rightBarButtonItem?.enabled = false
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        
        
        
        var item1 = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "clear")
        item1.tintColor = UIColor.whiteColor()
        self.navigationItem.setLeftBarButtonItems([item1], animated: false)

        
        addrTextFied.delegate = self
    }
    
    func compleate(){
    
        EbickBrandAddTableData.EbickBrandLocation.address = addrTextFied.text
        
        if(EbickBrandAddTableData.EbickBrandLocation.latitude != nil && EbickBrandAddTableData.EbickBrandLocation.address != nil && EbickBrandAddTableData.EbickBrandLocation.address != ""){
           
            clear()
        
        }else{
            
           CommonUtil.alertView(self, title: "未定位成功", message: "", buttons: [AlertHandler(title: "确定", handle: { () -> Void in
            
           })])
        }
       
        
    }
    
    
    func textViewDidChange(textView: UITextView) {
        if(addrTextFied.text == ""){
            phaLable.hidden = false
        }else{
            phaLable.hidden = true
        }
    }
    
    
    
    func textViewDidEndEditing(textView: UITextView) {
        
        if(addrTextFied.text == ""){
            phaLable.hidden = false
        }else{
            phaLable.hidden = true
        }
        
        
    }
    
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
  
        
        
        var alltext = (addrTextFied.text as NSString).stringByReplacingCharactersInRange(range, withString: text)
        
        if((alltext as NSString).length == 0){
            phaLable.hidden = false
        }else{
            phaLable.hidden = true
        }
        
        var length = 0
        var temp = "";
        for c:Character in alltext {
            
            if((++length) <= 50){
                temp.append(c)
            }
        }
        
        if(length>0){
            
            self.navigationItem.rightBarButtonItem?.enabled=true
            
        }else{
            
            self.navigationItem.rightBarButtonItem?.enabled=false
        }
        
        if (length > 50) {
            addrTextFied.text = temp;
            return false;
        }
        return true;
    }
    
    

    
    
    func clear(){
        
      
        CommonUtil.transitionWithType(kCATransitionReveal, withSubType: kCATransitionFromBottom, forView: self.view.window!)
        
        self.navigationController?.popViewControllerAnimated(false)
        
    }

    
}

