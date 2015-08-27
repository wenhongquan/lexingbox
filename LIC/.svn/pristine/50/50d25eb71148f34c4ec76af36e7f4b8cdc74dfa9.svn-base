//
//   EbickGarageController.swift
//  LIC
//
//  Created by 温红权 on 15/4/28.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class EbickGarageController: BaseTableController {
    

    var brandId:Int?
    var businessScope:Int?
    var lxbDeviceSellFlag:Int?
    
    var pagetitle:String?
    
    var allBusiness:[Business] = []
    
    var businessPageTemp:BusinessPage?
//    var hasData:Bool = true
    var isinit = true
    
    override func viewDidLoad() {
        initUI()
        
    }
    
    func mapnavfunc(){
        var sb = UIStoryboard(name: "Main", bundle:nil)
        
        var vc = sb.instantiateViewControllerWithIdentifier("repairMapViewController") as!  RepairMapViewController
        
        vc.hidesBottomBarWhenPushed = true
        vc.brandId = self.brandId
        vc.businessScope = self.businessScope
        vc.lxbDeviceSellFlag = self.lxbDeviceSellFlag
        
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
    
    func BusinessCountInCity(){
        if(Cache.USER?.userAddr?.city != nil){
//            
//            GpsService.sharedGpsService.GetEbickBusinessCountBycityName({(data)in
//                if(data["status"].int == StatusCode.SystemSC.SYSTEM_OK){
//                    
//                    if (data["data"].int == 0 && self.allBusiness.count > 0 ){
//                      
//                        self.tableView.sectionHeaderHeight = 78
//                    }else{
//                      
//                        self.tableView.sectionHeaderHeight = 0
//                    }
//                    self.tableView.tableHeaderView = self.tableView.tableHeaderView;
//                    
//                }
//                
//                
//                }, errorHandler: {(data)in
//                    
//                    
//                    
//                }, city: Cache.USER.userAddr!.city)
            
        }
    }
    
    var loading:JGProgressHUD?
    
    func getEbickBusiness(paged:Int){
        
        
        if(Cache.USER.latitude == nil){
            
            if(!CommonUtil.locationisEnable(self)){
                return
            }
        }
        
       
     
        if(paged == 0){
            // TODO 检测当前城市是否有修车铺
            BusinessCountInCity()
            
            //获取电动车
            GpsService.sharedGpsService.GetEbickBusiness({(data)in
                self.isinit = false
                self.loading?.dismiss()
                if(data["status"].int == StatusCode.SystemSC.SYSTEM_OK){
                    
                    var businessPage:BusinessPage? = Mapper<BusinessPage>().map(data["data"].dictionaryObject!)
                    if(businessPage?.objs.count > 0){
                        //有数据  渲染
                        self.businessPageTemp = businessPage!
                        self.allBusiness = self.businessPageTemp!.objs
//                        self.allBusiness = []
                        
                        
                        
                        self.tableView.reloadData()

                        self.setHeader()
//                        self.hasData = true
                        if(businessPage!.totalPage == businessPage!.paged){
                            self.tableView.removeFooter()
                        }else{
                        self.tableView.addLegendFooterWithRefreshingBlock({()->Void in
                            self.getEbickBusiness(self.businessPageTemp!.paged! + 1)
                            
                        })
                        }
                        
                        var rightItem = UIBarButtonItem(image: UIImage(named: "map_nav"), style: UIBarButtonItemStyle.Plain, target: self, action: "mapnavfunc")
                        self.navigationItem.rightBarButtonItem = rightItem
                        
                    }else{
                        
                        self.navigationItem.rightBarButtonItem = nil
                        self.businessPageTemp = nil
                        self.allBusiness = []
                        self.tableView.reloadData()
                    }
                    
                }else{
                
                    self.navigationItem.rightBarButtonItem = nil
                    self.businessPageTemp = nil
                    self.allBusiness = []
                    self.tableView.reloadData()

                }
                
                }, errorHandler: {(data)in
                    
                }, latitude: Cache.USER.latitude.description, longitude: Cache.USER.longitude.description,paged:"1",brand:brandId,businessScope:businessScope,lxbDeviceSellFlag:lxbDeviceSellFlag)

        
        }else{
        
            
//            if(hasData){
              //定位数据
                GpsService.sharedGpsService.GetEbickBusiness({(data)in
                    self.isinit = false
                    self.loading?.dismiss()
                    if(data["status"].int == StatusCode.SystemSC.SYSTEM_OK){
                        
                        var businessPage:BusinessPage = Mapper<BusinessPage>().map(data["data"].dictionaryObject!)
                        if(self.businessPageTemp?.objs.count > 0){
                            //有数据  渲染
                            self.businessPageTemp = businessPage
                            self.allBusiness += self.businessPageTemp!.objs
                            self.tableView.reloadData()
//                            self.hasData = true
                            self.setHeader()
                            if(businessPage.totalPage == businessPage.paged){
                               self.tableView.removeFooter()
                            }else{
                                self.tableView.addLegendFooterWithRefreshingBlock({()->Void in
                                    self.getEbickBusiness(self.businessPageTemp!.paged! + 1)
                                    
                                })
                            }
                            
                        }
                    }
                    
                    }, errorHandler: {(data)in
                        
                    }, latitude: Cache.USER.latitude.description, longitude: Cache.USER.longitude.description,paged:paged.description,brand:brandId,businessScope:businessScope,lxbDeviceSellFlag:lxbDeviceSellFlag)
  
        }

    
    }
    
    
    func setHeader(){
    
        if(self.allBusiness.count>0){
            var views = UIView.loadFromNibNamedView("LexingTipView", bundle: nil)
            views!.frame.size.height = 34
            self.tableView.tableHeaderView = views
            
        }else{
            
            self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: CGFloat.min))
        }

        self.tableView.reloadData()
    }
    
    
    override func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
        super.didUpdateBMKUserLocation(userLocation)
        
        locationManager.stopUserLocationService()
        
         //获取电动车
        getEbickBusiness(0)
        
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        self.tableView.tableHeaderView = self.tableView.tableHeaderView
    }
    

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allBusiness.count > 0 ?  allBusiness.count : 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        if(allBusiness.count > 0){
        
            var cell = tableView.dequeueReusableCellWithIdentifier("ebickServiceTableCell") as! EbickServiceTableCell
            
            cell.garageAddrLable.text = CommonUtil.StringLimt(12,string:(self.allBusiness[indexPath.row].area == nil ? "" : self.allBusiness[indexPath.row].area!) + (self.allBusiness[indexPath.row].address == nil ? "" : self.allBusiness[indexPath.row].address!))
         
            cell.garageTitleLable.text = self.allBusiness[indexPath.row].name
            cell.garageDistanceLable.text = String(format:"%.1f", Double(Int(self.allBusiness[indexPath.row].distance!/1000.0*10))/10.0) + "km"
            if(self.allBusiness[indexPath.row].sPhotoUrl != nil){
                
//                var imageRequest  =  NSURLRequest(URL:  NSURL(string: self.allBusiness[indexPath.row].sPhotoUrl!)!, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval: 60)
                
                cell.garagePicView.sd_setImageWithURL(NSURL(string: self.allBusiness[indexPath.row].sPhotoUrl!),placeholderImage:UIImage(named: "downloadingpic"),options:SDWebImageOptions.RefreshCached)
                
//                cell.garagePicView.setImageWithUrlRequest(imageRequest, placeHolderImage: UIImage(named: "downloadingpic"), success: nil, failure: nil)
               
                
            }
            
            for view in  cell.garageFuncView.subviews {
                view.removeFromSuperview()
            }

            
            for (index,temp) in enumerate(self.allBusiness[indexPath.row].businessScope!) {
                if(107006==temp){
                    continue
                }
                var imageView = UIImageView()
                var imageViewY:CGFloat = 0
                var imageViewW:CGFloat = 12;
                var imageViewH:CGFloat = 12;
                var imageViewX:CGFloat = 0 + CGFloat(index) * imageViewW + 3 * CGFloat(index);
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
                    break
                    
                }
                imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH)
                
                cell.garageFuncView.addSubview(imageView)
                
                
            }
            
            cell.lexingIconImage.hidden = true
            if(self.allBusiness[indexPath.row].lxbDeviceSellFlag == 1){
                cell.lexingIconImage.hidden = false
            }
            
            
            
            return cell;

        
        }else{
        
            if(isinit){
            
               return UITableViewCell()
            }
           
            
           var cell = tableView.dequeueReusableCellWithIdentifier("noEbickBrandTableCell") as! NoEbickBrandTableCell
            
            cell.addView.clickevnt = { () in
                
                
                var sb = UIStoryboard(name: "Main", bundle:nil)
                
                var vc = sb.instantiateViewControllerWithIdentifier("ebickBrandAddTableController") as!  EbickBrandAddTableController
                
                vc.hidesBottomBarWhenPushed = true
                
                CommonUtil.transitionWithType(kCATransitionMoveIn, withSubType: kCATransitionFromTop, forView: self.view.window!)
                self.navigationController?.pushViewController(vc, animated: false)
                
                            
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
            
        }
        
        
        
            
     
        
        
    }
    
    
  
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
       
        if(allBusiness.count > 0){
            self.tableView.scrollEnabled = true
            
           return 85
        }else{
        
             self.tableView.scrollEnabled = false
        
           return self.tableView.frame.size.height
        }
    
       
      
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        locationManager.startUserLocationService()
        
        self.loading = CommonUtil.alertLoding(self, title: "请稍等...")
        var yNavBar = self.navigationController!.navigationBar.frame.height
        // yStatusBar indicates the height of the status bar
        var yStatusBar = UIApplication.sharedApplication().statusBarFrame.size.height
        
        self.loading?.frame.origin.y -= yNavBar + yStatusBar
        self.loading?.dismissAfterDelay(12000)
        
        

        
        isinit = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.loading?.dismiss()
        isinit = true
    }
    
    

    
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(allBusiness.count > 0){
        
          return 10
        }
        
        return CGFloat.min
        
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        if(allBusiness.count < 1){
           return
        }
        
        var sb = UIStoryboard(name: "Main", bundle:nil)
        
        var vc = sb.instantiateViewControllerWithIdentifier("ebickGarageDetailTableController") as!  EbickGarageDetailTableController
        
        vc.busines = self.allBusiness[indexPath.row]
        
        vc.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    



    
    
    
    func initUI(){
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        
        self.navigationItem.title = "我要修车"
        if(pagetitle != nil){
          self.navigationItem.title = pagetitle
        }
        
        
        
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.scrollEnabled = true
    }
    
}
