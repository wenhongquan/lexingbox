//
//  RepairMapViewController.swift
//  LIC
//
//  Created by 温红权 on 15/5/5.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class RepairMapViewController :BaseController,BMKMapViewDelegate,UIGestureRecognizerDelegate {
    
    
    var brandId:Int?
    var businessScope:Int?
    var lxbDeviceSellFlag:Int?
    
    @IBOutlet weak var addrView: UIViewTouchView!
    
    @IBOutlet weak var mapView: UIView!
    
    var mpview:BMKMapView?
    
    @IBOutlet weak var lexingIconImage: UIImageView!
    @IBOutlet weak var repairAddrLable: UILabel!
    @IBOutlet weak var repairImageView: UIImageView!
    @IBOutlet weak var repairNameLable: UILabel!
    @IBOutlet weak var distanceLable: UILabel!
    @IBOutlet weak var displayFuncView: UIView!
    var allBusiness:[Business] = []
    
    override func viewDidLoad() {
        addrView.addTopBorderWithHeight(1, color: CommonUtil.UIColorFromRGB(0xd9d9d9))
        initUI()
    }
    
    
    override func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
        super.didUpdateBMKUserLocation(userLocation)
        mpview?.updateLocationData(userLocation)
        setRecon()
      
    }
    
    var isfirst = false

    
    func setRecon(){
    
        if(allBusiness.count>0 && Cache.USER.latitude != nil && !isfirst){
            
            isfirst = true
            
            var xdis = BMKMetersBetweenMapPoints(BMKMapPointForCoordinate(CLLocationCoordinate2DMake(allBusiness[0].bd09Point!.lat,allBusiness[0].bd09Point!.lng)),BMKMapPointForCoordinate(CLLocationCoordinate2DMake(Cache.USER.latitude,allBusiness[0].bd09Point!.lng)));
            
            var ydis = BMKMetersBetweenMapPoints(BMKMapPointForCoordinate(CLLocationCoordinate2DMake(allBusiness[0].bd09Point!.lat,allBusiness[0].bd09Point!.lng)),BMKMapPointForCoordinate(CLLocationCoordinate2DMake(allBusiness[0].bd09Point!.lat,Cache.USER.longitude)));
            
            
            
            
            var region = BMKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: Cache.USER.latitude, longitude: Cache.USER.longitude) , xdis+10000, ydis+10000)
            
            var  adjustedRegion = self.mpview!.regionThatFits(region)
            
            self.mpview?.setRegion(adjustedRegion, animated: true)
            
        }
        

    
    
    
    }
    
    
    func initUI(){
        
        self.mpview = BMKMapView();
        self.mapView.addSubview(self.mpview!)
        self.mapView.bringSubviewToFront(addrView)
        mpview?.delegate=self;
        mpview?.userTrackingMode = BMKUserTrackingModeFollow
        mpview?.showsUserLocation = true
        
        
        if allBusiness.count < 1{
        
            addrView.hidden = true
        }else{
            addrView.hidden = false
        }
        
        if(Cache.USER.longitude != nil){
        
        
        CommonUtil.GCDThread({(data)in
            
            GpsService.sharedGpsService.GetEbickBusiness({(data)in
                
                if(data["status"].int == StatusCode.SystemSC.SYSTEM_OK){
                    
                    var businessPage:BusinessPage? = Mapper<BusinessPage>().map(data["data"].dictionaryObject!)
                    if(businessPage?.objs.count > 0){
                        //有数据  渲染
                        self.allBusiness = businessPage!.objs
                        
                        
                        self.addBMKPinAnnotation()
                    }
                    
                    if self.allBusiness.count < 1{
                        
                         self.addrView.hidden = true
                    }else{
                         self.addrView.hidden = false
                    }

                }
                
                }, errorHandler: {(data)in
                    
                }, latitude: Cache.USER.latitude.description, longitude: Cache.USER.longitude.description,paged:"1",brand:self.brandId,businessScope:self.businessScope,lxbDeviceSellFlag:self.lxbDeviceSellFlag)
            
            
            }, afterdo: nil)
        }
        
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        self.navigationItem.title = "地图显示"
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        
        var tapGesture = UITapGestureRecognizer(target: self, action: "tapGesture:")
        tapGesture.delegate = self
        self.mpview?.addGestureRecognizer(tapGesture)
        
        
        addrView.clickevnt = {()in
        
        
            var sb = UIStoryboard(name: "Main", bundle:nil)
            
            var vc = sb.instantiateViewControllerWithIdentifier("ebickGarageDetailTableController") as!  EbickGarageDetailTableController
            
            vc.busines = self.allBusiness[self.selectedIndex]
            
            vc.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(vc, animated: true)

        
        
        }
        
        
        
        
    }
    
    
    func tapGesture(gesture:UITapGestureRecognizer){
        
        
        
    }
    
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        
        var touchClassName = NSStringFromClass(touch.view.classForCoder)
        
        if(touch.view.isKindOfClass(BMKPinAnnotationViewExt)){
            var viewtemp = touch.view as! BMKPinAnnotationViewExt
            SelectAnnotationView(viewtemp.index)
        }
        return false
    }
    
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
        
        
    }

    func addBMKPinAnnotation(){
        mpview?.removeAnnotations(mpview?.annotations)
       
        for (index,busines) in enumerate(allBusiness) {

            var point = CLLocationCoordinate2D(latitude:busines.bd09Point!.lat, longitude: busines.bd09Point!.lng)
            var annotation=BMKPointAnnotationExt();
            annotation.coordinate = point;
            annotation.pointindex = index
            mpview?.addAnnotation(annotation);
        
        }
        if(allBusiness.count>0){
           mpview?.setCenterCoordinate(CLLocationCoordinate2D(latitude:allBusiness[0].bd09Point!.lat, longitude: allBusiness[0].bd09Point!.lng) , animated: false)
           mpview?.zoomLevel = 15
            
           SelectAnnotationView(0)
            
            
           setRecon()
            
        }
        
        
        

    }
    
    
    
    func mapView(mapView: BMKMapView!, viewForAnnotation annotation: BMKAnnotation!) -> BMKAnnotationView! {
        if  (annotation.isKindOfClass(BMKPointAnnotationExt)) {
            
            var newAnnotationView = BMKPinAnnotationViewExt(annotation: annotation, reuseIdentifier: "myAnnotation")
            
            var annotationtemp = annotation as! BMKPointAnnotationExt
            
            newAnnotationView.index = annotationtemp.pointindex
            
            newAnnotationView = setBMKPinAnnotationView(annotationtemp.pointtype,view:newAnnotationView)
            
            return  newAnnotationView;
        }
        return  nil;
    }
    
    var selectedIndex = 0
    
    func SelectAnnotationView(index:Int){
        
        //使原来的变成正常色
        
        for annotation in mpview!.annotations {
        
            if (annotation.isKindOfClass(BMKPointAnnotationExt)) {
            
                var views:BMKPinAnnotationViewExt = mpview?.viewForAnnotation(annotation as! BMKPointAnnotationExt) as! BMKPinAnnotationViewExt
               
                
                if(index == views.index){
                   //当前的变为高亮色
                    views.image = UIImage(named: "repair_current")
                }else{
                 
                    views.image = UIImage(named: "repair_other")
                }
            
            }
        
        
        }
        
        
       selectedIndex = index
        
        if(index>allBusiness.count){
           return
        }
        
        
        
        //修改下方的信息、图片等
//        repairImageView.setImageWithUrl(NSURL(string:allBusiness[index].sPhotoUrl!)!, placeHolderImage: UIImage(named: "downloadingpic"))

        
        
        repairNameLable.text = allBusiness[index].name
        
        repairAddrLable.text = CommonUtil.StringLimt(12,string:(self.allBusiness[index].area == nil ? "" : self.allBusiness[index].area!) + (self.allBusiness[index].address == nil ? "" : self.allBusiness[index].address!))
        
        distanceLable.text =  String(format:"%.1f", Double(Int(allBusiness[index].distance!/1000.0*10))) + "km"
        
        if( allBusiness[index].sPhotoUrl != nil){
            repairImageView.sd_setImageWithURL(NSURL(string: allBusiness[index].sPhotoUrl!),placeholderImage:UIImage(named: "downloadingpic"),options:SDWebImageOptions.RefreshCached)
        }else{
        
           repairImageView.image = UIImage(named: "downloadingpic")
        }
        
        
        for view in displayFuncView.subviews {
        
           view.removeFromSuperview()
        
        }
        
        
        for (index,temp) in enumerate(self.allBusiness[index].businessScope!) {
            
            var imageView = UIImageView()
            var imageViewY:CGFloat = 0
            var imageViewW:CGFloat = 12;
            var imageViewH:CGFloat = 12;
            var imageViewX:CGFloat = 0 + CGFloat(index) * imageViewW + 3 * CGFloat(index);
            
            imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH)
            
            
            
            switch(temp){
            case StatusCode.EBICK_GRANDE_FUNC_CONG:
                imageView.image = UIImage(named: "ico_manchong")
                break;
                
            case StatusCode.EBICK_GRANDE_FUNC_GAI:
                imageView.image = UIImage(named: "ico_gai")
                break;
                
            case StatusCode.EBICK_GRANDE_FUNC_SALE:
                imageView.image = UIImage(named: "ico_sale")
                break;
                
            case StatusCode.EBICK_GRANDE_FUNC_ZHU:
                imageView.image = UIImage(named: "ico_zhu")
                break;
                
            case StatusCode.EBICK_GRANDE_FUNC_REPAIR:
                imageView.image = UIImage(named: "ico_repair")
                break;
                
            default:
                imageView.image = UIImage(named: "ico_chong")
                continue
                
            }
            displayFuncView.addSubview(imageView)
        }
        
        lexingIconImage.hidden = true
        if(allBusiness[index].lxbDeviceSellFlag == 1){
             lexingIconImage.hidden = false
        }
        

    }
    
    
    

    
    
    
    func setBMKPinAnnotationView(type:Int,view:BMKPinAnnotationViewExt) -> BMKPinAnnotationViewExt {
        
        var imageName = ""
        var img:UIImage!
        
        view.canShowCallout = false
        
        view.image=UIImage(named: "repair_other")
        view.centerOffset = CGPointMake((0), (0))
        
        
        
        return view
    }
    
    

    


    
    
}