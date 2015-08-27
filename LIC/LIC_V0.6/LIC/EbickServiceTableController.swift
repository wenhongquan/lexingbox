//
//  EbickServiceTableController.swift
//  LIC
//
//  Created by 温红权 on 15/5/27.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation



class EbickServiceTableController:BaseTableController,UIScrollViewDelegate {

    @IBOutlet weak var buyViewButton: UIViewTouchView!

    @IBOutlet weak var congViewButton: UIViewTouchView!
    
    @IBOutlet weak var gaiViewButton: UIViewTouchView!
   
    
    @IBOutlet weak var repairViewButton: UIViewTouchView!
    
    @IBOutlet weak var brandViewButton: UIViewTouchView!
    
    @IBOutlet weak var gotoViewButton: UIViewTouchView!
    
    
    
    
    
    @IBOutlet weak var brandView: UIView!

    @IBOutlet weak var fontheadView: UIView!

    //    @IBOutlet weak var rightContentlength: NSLayoutConstraint!
    let numImageCount:Int = 3
    var pageImages:[UIImageView] = []

    var garageEbicks:[Business] = []

    var scrollView: HYInfiniteScrollView!     //无限滑动scrollview


    @IBOutlet weak var refreshButton: UIButton!

    @IBAction func refreshButtonAction(sender: AnyObject) {

        self.refresh = true
        locationManager.startUserLocationService()
    }

    var isinit = false

    override func viewDidLoad() {
        
        buyViewButton.addBottomBorderWithHeight(1, color: CommonUtil.UIColorFromRGB(0xd9d9d9))
        buyViewButton.addTopBorderWithHeight(1, color: CommonUtil.UIColorFromRGB(0xd9d9d9))
        buyViewButton.addLeftBorderWithWidth(1, color: CommonUtil.UIColorFromRGB(0xd9d9d9))
//        buyViewButton.addRightBorderWithWidth(1, color: CommonUtil.UIColorFromRGB(0xd9d9d9))
        buyViewButton.clickevnt = self.buyEbickButtonAction
    
        
        
        congViewButton.addBottomBorderWithHeight(1, color: CommonUtil.UIColorFromRGB(0xd9d9d9))
        congViewButton.addTopBorderWithHeight(1, color: CommonUtil.UIColorFromRGB(0xd9d9d9))
        congViewButton.addLeftBorderWithWidth(1, color: CommonUtil.UIColorFromRGB(0xd9d9d9))
//        congViewButton.addRightBorderWithWidth(1, color: CommonUtil.UIColorFromRGB(0xd9d9d9))
        congViewButton.clickevnt =  self.EbickChongButtonAction
        
        
        
        gaiViewButton.addBottomBorderWithHeight(1, color: CommonUtil.UIColorFromRGB(0xd9d9d9))
        gaiViewButton.addTopBorderWithHeight(1, color: CommonUtil.UIColorFromRGB(0xd9d9d9))
        gaiViewButton.addLeftBorderWithWidth(1, color: CommonUtil.UIColorFromRGB(0xd9d9d9))
        gaiViewButton.addRightBorderWithWidth(1, color: CommonUtil.UIColorFromRGB(0xd9d9d9))
        gaiViewButton.clickevnt = self.EbickGaiButtonAction
      
        
        
        repairViewButton.addBottomBorderWithHeight(1, color: CommonUtil.UIColorFromRGB(0xd9d9d9))
//        repairViewButton.addTopBorderWithHeight(1, color: CommonUtil.UIColorFromRGB(0xd9d9d9))
        repairViewButton.addLeftBorderWithWidth(1, color: CommonUtil.UIColorFromRGB(0xd9d9d9))
        repairViewButton.addRightBorderWithWidth(1, color: CommonUtil.UIColorFromRGB(0xd9d9d9))
         repairViewButton.clickevnt =  self.EbickRepairButtonAction
        
        brandViewButton.addBottomBorderWithHeight(1, color: CommonUtil.UIColorFromRGB(0xd9d9d9))
//        brandViewButton.addTopBorderWithHeight(1, color: CommonUtil.UIColorFromRGB(0xd9d9d9))
        brandViewButton.addLeftBorderWithWidth(1, color: CommonUtil.UIColorFromRGB(0xd9d9d9))
//        brandViewButton.addRightBorderWithWidth(1, color: CommonUtil.UIColorFromRGB(0xd9d9d9))
        brandViewButton.clickevnt = self.ebickBrandButtonAction
        
        gotoViewButton.addBottomBorderWithHeight(1, color: CommonUtil.UIColorFromRGB(0xd9d9d9))
//        gotoViewButton.addTopBorderWithHeight(1, color: CommonUtil.UIColorFromRGB(0xd9d9d9))
        gotoViewButton.addLeftBorderWithWidth(1, color: CommonUtil.UIColorFromRGB(0xd9d9d9))
        gotoViewButton.addRightBorderWithWidth(1, color: CommonUtil.UIColorFromRGB(0xd9d9d9))
        gotoViewButton.clickevnt = self.gotoButtonAction

        
        

        //初始化ScrollView
        let scrollViewRect: CGRect = CGRectMake(0, 0,  self.brandView.frame.width, self.brandView.frame.height)
        self.scrollView = HYInfiniteScrollView.init(frame: scrollViewRect)
        self.scrollView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.scrollView.animationEnable = true
        self.scrollView.animationDuration = 5.0
        self.scrollView.slideBarEnable = true
        //        self.scrollView.delegate = self

        //这里只是做一个简单的循环, 可扩展成从网络上拉数据，自己封装数据结构传值
        var imgArr:[UIbrandImageView] = [UIbrandImageView(image:UIImage(named: "banners"),event:{()in

        }),UIbrandImageView(image:UIImage(named: "banners"),event:nil) ,UIbrandImageView(image:UIImage(named: "banners"),event:nil)]
        self.scrollView.reloadActivityItem(imgArr)

        self.brandView.addSubview(self.scrollView)




        fontheadView.addTopBorderWithHeight(0.5, color: CommonUtil.UIColorFromRGB(0xd9d9d9))



        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()

        self.navigationItem.title = "乐行宝"

        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        CommonUtil.setNavigationControllerBackground(self)

        var rightbar = UIBarButtonItem(image: UIImage(named: "customer_service"), style: UIBarButtonItemStyle.Plain, target: self, action: "customerService")

        rightbar.imageInsets = UIEdgeInsets(top: 0, left: -7, bottom: 0, right: 7)



        self.navigationItem.setRightBarButtonItem(rightbar, animated: false)

        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()


        self.refresh = true


        refreshButton.frame.size = CGSize(width: 30, height: 30)

    }
    
        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    var lastdata:Banners?;
    
    func getAdvice(){
        
        if(Cache.BANNER == nil){
            
            var datas: AnyObject? = CommonUtil.readWithNSUserDefaults("BANNER")
            if(datas != nil){
                Cache.BANNER = Mapper<Banners>().map(JSON(datas!).dictionaryObject)
                self.lastdata = Cache.BANNER
                self.display()
            }
        }
        
        
        
        
        GpsService.sharedGpsService.GetEbickAdvert({ (data) -> Void in
            
            if(data == nil) {
                return
            }
            
            if(data["status"].int == StatusCode.SystemSC.SYSTEM_OK){
                var temp = Mapper<Banners>().map(data.dictionaryObject!)
                
                
                
                
                self.lastdata = temp
                
                
                Cache.BANNER = self.lastdata
                
                CommonUtil.saveWithNSUserDefaults(Mapper().toJSON(Cache.BANNER!), key: "BANNER")
                
                self.display()
                
                
            }
            
            
            
            }, errorHandler: { (data) -> Void in
                
        })
        
        
    }
    
    func display(){
        
        var imgArr:[UIbrandImageView]? = [];
        
        
        var datatemp = self.lastdata
        
        if(datatemp?.data.count > 0){
            
            for banner in datatemp!.data {
                
                var images:UIbrandImageView = UIbrandImageView(image:UIImage(named: ""),event:{()in
                    
                    if(banner.jumpType != nil && banner.jumpType == 2){
                        CommonUtil.backToWebView(self, name: "webviewcontroller", title: "广告", url: banner.jumpUrl)
                    }
                    
                    
                    
                })
                images.sd_setImageWithURL(NSURL(string: banner.imgUrl),placeholderImage:UIImage(named: "banners"),options:SDWebImageOptions.RefreshCached)
                
                imgArr!.append(images)
                
            }
            
            
        }
        if(imgArr?.count > 0){
            self.scrollView.totalPageCount = 0;
            self.scrollView.reloadActivityItem(imgArr!)
            self.scrollView.totalPageCount = imgArr!.count
        }
        
    }
    
    
    
    override func networkEnable() {
        super.networkEnable()
        
        getAdvice()
    }
    
    
    
    var  duration:CFTimeInterval?;
    var  timeOffset:CFTimeInterval?;
    var  lastStep:CFTimeInterval?;
    var looper:CADisplayLink?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        CommonUtil.getEbickInfo()
        CommonUtil.login()
        CommonUtil.getevents()
        
        locationManager.startUserLocationService()
        
        isinit = true
        disableNetWork = true
        
        looper?.invalidate()
        looper = CADisplayLink(target: self, selector: Selector("drawLine:"))
        looper?.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
        lastStep = CACurrentMediaTime()
        
        getAdvice()
        
        point = self.refreshButton.center
        
        disableNetWork = true
        if(BaseString.NetWorkEnable){
            networkEnable()
        }else{
            networkDisable()
        }
        
    }
    override func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
        super.didUpdateBMKUserLocation(userLocation)
        locationManager.stopUserLocationService()
        getEbickBusiness(0)
        
    }
    
    
    
    var ration:CGFloat = 0
    var refresh = false
    
    var point:CGPoint?
    
    func drawLine(link:CADisplayLink) -> Void {
        
        var thisStep = CACurrentMediaTime()
        var stepDuration1 = thisStep - self.lastStep!;
        self.lastStep = thisStep;
        
        if(refresh){
            
            ration+=CGFloat((2*M_PI)*(stepDuration1/1))
            if(ration > CGFloat(M_PI*2)){
                ration = 0
            }
            
        }else{
            
            if(ration != 0){
                ration = 0
            }else{
                return
            }
        }
        
        
        self.refreshButton.imageView!.clipsToBounds = false;
        self.refreshButton.imageView!.contentMode = UIViewContentMode.Center;
        
        // 一直绘制
        self.refreshButton.imageView!.transform = CGAffineTransformMakeRotation(ration)
        
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        isinit = false
        looper?.invalidate()
    }
    
    func customerService(){
        
        CommonUtil.alertCustomService(self)
    }
    
    
    var currentPageNumber:Int = 0
    
    
    func ebickBrandButtonAction() {
        
        var sb = UIStoryboard(name: "Main", bundle:nil)
        var vc = sb.instantiateViewControllerWithIdentifier("ebickBrandTableViewComtroller") as!  EbickBrandTableViewComtroller
        
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoButtonAction() {
        
        var sb = UIStoryboard(name: "Main", bundle:nil)
        var vc = sb.instantiateViewControllerWithIdentifier("ebickGarageController") as!  EbickGarageController
        vc.businessScope = StatusCode.EBICK_GRANDE_FUNC_GOTO
        vc.brandId = nil
        vc.lxbDeviceSellFlag = nil
        vc.pagetitle = "上门服务"
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func buyEbickButtonAction() {
        
        var sb = UIStoryboard(name: "Main", bundle:nil)
        var vc = sb.instantiateViewControllerWithIdentifier("ebickGarageController") as!  EbickGarageController
        vc.businessScope = StatusCode.EBICK_GRANDE_FUNC_SALE
        vc.brandId = nil
        vc.lxbDeviceSellFlag = nil
        vc.pagetitle = "售车商户"
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func EbickChongButtonAction() {
        
        var sb = UIStoryboard(name: "Main", bundle:nil)
        var vc = sb.instantiateViewControllerWithIdentifier("ebickGarageController") as!  EbickGarageController
        vc.businessScope = StatusCode.EBICK_GRANDE_FUNC_CONG
        vc.brandId = nil
        vc.lxbDeviceSellFlag = nil
        vc.pagetitle = "充电商户"
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

   func EbickRepairButtonAction() {

        //        var sb = UIStoryboard(name: "Main", bundle:nil)
        //        var vc = sb.instantiateViewControllerWithIdentifier("ebickGarageController") as!  EbickGarageController
        //        vc.businessScope = StatusCode.EBICK_GRANDE_FUNC_REPAIR
        //        vc.brandId = nil
        //        vc.lxbDeviceSellFlag = nil
        //        vc.pagetitle = "维修商户"
        //        vc.hidesBottomBarWhenPushed = true
        //        self.navigationController?.pushViewController(vc, animated: true)



        var order = OrderPay()
        order.tradeType = "APP"
        order.businessesId = 24
        order.goodsId = 1
        GpsService.sharedGpsService.OrderWXpay({ (data) -> Void in

            if(data["status"].int == StatusCode.SystemSC.SYSTEM_OK){


                var req:PayReq = PayReq()
                req.openID = data["data"]["appid"].string!
                req.partnerId = data["data"]["partnerid"].string!
                req.prepayId = data["data"]["prepayid"].string!
                req.nonceStr            = data["data"]["noncestr"].string!
                req.timeStamp           = UInt32((data["data"]["timestamp"].string!).toInt()!)
                req.package             = data["data"]["package"].string!
                req.sign                = data["data"]["sign"].string!


                WXApi.sendReq(req)






            }
            }, errorHandler: { (data) -> Void in

            }, body: Mapper().toJSON(order))




    }
    func EbickGaiButtonAction() {

        //        var sb = UIStoryboard(name: "Main", bundle:nil)
        //        var vc = sb.instantiateViewControllerWithIdentifier("ebickGarageController") as!  EbickGarageController
        //        vc.businessScope = StatusCode.EBICK_GRANDE_FUNC_GAI
        //        vc.brandId = nil
        //        vc.lxbDeviceSellFlag = nil
        //        vc.pagetitle = "改装商户"
        //        vc.hidesBottomBarWhenPushed = true
        //        self.navigationController?.pushViewController(vc, animated: true)

        var order = OrderPay()
        order.tradeType = "APP"
        order.businessesId = 24
        order.goodsId = 1


        GpsService.sharedGpsService.OrderAlipay({ (data) -> Void in

            if(data["status"].int == StatusCode.SystemSC.SYSTEM_OK){

                var orderString:String = data["data"]["orderInfo"].string!


                //               orderString = "sign=\"vrOxvXOVBbm82tjM7jHAC%2ff6zsvAtoUft%2fMIPSMmbjwHhIKV72ct8qpvI5XWcmbCA9p3BHX2PFJ5MoWJGZruTEyfC301177yNWsidibUrhVwwPxhqtWvHrN45LNT0vLzw%2fvv%2fbhoQ%2b23MvIRcL4PgDMNUSEjxe24mNCrDRxYLUA%3d\"&body=\"充电\"&_input_charset=\"utf-8\"&it_b_pay=\"2015-07-17 18:33:46\"&total_fee=\"0.01\"&subject=\"充电\"&sign_type=\"RSA\"&notify_url=\"http://test.open.91lexing.com/service/pay/alipay/notify.jsp\"&service=\"mobile.securitypay.pay\"&seller_id=\"2088911998545940\"&partner=\"2088911998545940\"&out_trade_no=\"b80dca4a6ace40e6974d12d6badb9c1c\"&payment_type=\"1\""


                //               orderString =  "sign=\"0UTAHTnVPwQG9DqgSYkdwJ99On4lQH1fUvpmOS4mSl5yfVyU8lYrmFgx0K3jxgbRrKZa3s4Su2tov7evFlEJIwV3G6TrNDxtNO2lKOR993P%2b%2bYgLC5QFuZEFRVx28e1poZTk4aEit67E1LB80c1bVWxHeRH0RXWz7gv%2fb4qR4pc%3d\"&body=\"充电\"&_input_charset=\"utf-8\"&it_b_pay=\"2015-07-17 18:15:02\"&total_fee=\"0.01\"&subject=\"充电\"&sign_type=\"RSA\"&notify_url=\"http://test.open.91lexing.com/service/pay/alipay/notify.jsp\"&service=\"mobile.securitypay.pay\"&seller_id=\"2088911998545940\"&partner=\"2088911998545940\"&out_trade_no=\"1a0c40250c1b469c9621a73dd61adc2d\"&payment_type=\"1\""

                println(orderString)

                AlipaySDK.defaultService().payOrder(orderString, fromScheme: "lexingbox", callback: { (result) -> Void in


                    CommonUtil.alertView(self, title: "orderInfo", message: orderString, buttons: [AlertHandler(title: "好", handle: { () -> Void in

                    })])

                })


            }



            }, errorHandler: { (data) -> Void in

            }, body: Mapper().toJSON(order))






    }


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isinit){
            return 0
        }
        return garageEbicks.count == 0 ? 1 : garageEbicks.count
    }


    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(garageEbicks.count>0){
            return 85
        }else{
            return 97
        }

    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if(garageEbicks.count>0){
            var cell = tableView.dequeueReusableCellWithIdentifier("ebickServiceTableCell") as! EbickServiceTableCell

            cell.garageAddrLable.text = CommonUtil.StringLimt(12,string:(self.garageEbicks[indexPath.row].area == nil ? "" : self.garageEbicks[indexPath.row].area!) + (self.garageEbicks[indexPath.row].address == nil ? "" : self.garageEbicks[indexPath.row].address!))
            cell.garageTitleLable.text = self.garageEbicks[indexPath.row].name
            cell.garageDistanceLable.text = String(format:"%.1f", Double(Int(self.garageEbicks[indexPath.row].distance!/1000.0*10))/10.0) + "km"
            if(self.garageEbicks[indexPath.row].sPhotoUrl != nil){

                //                var imageRequest  =  NSURLRequest(URL:  NSURL(string: self.garageEbicks[indexPath.row].sPhotoUrl!)!, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval: 60)
                //                 cell.garagePicView.setImageWithUrlRequest(imageRequest, placeHolderImage: UIImage(named: "downloadingpic"), success: nil, failure: nil)

                cell.garagePicView.sd_setImageWithURL(NSURL(string: self.garageEbicks[indexPath.row].sPhotoUrl!),placeholderImage:UIImage(named: "downloadingpic"),options:SDWebImageOptions.RefreshCached)
            }


            for view in  cell.garageFuncView.subviews {
                view.removeFromSuperview()
            }


            for (index,temp) in enumerate(self.garageEbicks[indexPath.row].businessScope!) {
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
                    continue;

                }
                imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH)
                cell.garageFuncView.addSubview(imageView)
            }

            cell.lexingIconImage.hidden = true
            if(self.garageEbicks[indexPath.row].lxbDeviceSellFlag == 1){
                cell.lexingIconImage.hidden = false
            }



            return cell;
        }else{

            var cell = tableView.dequeueReusableCellWithIdentifier("noEbickbrancetablecell") as! UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell;
        }
    }


    var businessPageTemp:BusinessPage?

    func getEbickBusiness(paged:Int){

        isinit = false

        if(Cache.USER.latitude == nil){

            if(!CommonUtil.locationisEnable(self)){
                return
            }

        }



        if(paged == 0){
            //获取电动车
            GpsService.sharedGpsService.GetEbickBusiness({(data)in
                if(data["status"].int == StatusCode.SystemSC.SYSTEM_OK){
                    self.refresh = false
                    var businessPage:BusinessPage? = Mapper<BusinessPage>().map(data["data"].dictionaryObject!)
                    if(businessPage?.objs.count > 0){
                        //有数据  渲染
                        self.businessPageTemp = businessPage!
                        self.garageEbicks = self.businessPageTemp!.objs

                        //                        self.garageEbicks = []

                        self.tableView.reloadData()

                        if(businessPage!.totalPage == businessPage!.paged){
                            self.tableView.removeFooter()
                        }else{
                            self.tableView.addLegendFooterWithRefreshingBlock({()->Void in
                                self.getEbickBusiness(self.businessPageTemp!.paged! + 1)

                            })
                        }



                    }else{

                        self.businessPageTemp = nil
                        self.garageEbicks = []
                        self.tableView.reloadData()
                    }

                }

                }, errorHandler: {(data)in

                }, latitude: Cache.USER.latitude.description, longitude: Cache.USER.longitude.description,paged:"1",brand:nil,businessScope:nil,lxbDeviceSellFlag:nil)


        }else{

            //定位数据
            GpsService.sharedGpsService.GetEbickBusiness({(data)in

                if(data["status"].int == StatusCode.SystemSC.SYSTEM_OK){
                    self.refresh = false
                    var businessPage:BusinessPage = Mapper<BusinessPage>().map(data["data"].dictionaryObject!)
                    if(self.businessPageTemp?.objs.count > 0){
                        //有数据  渲染
                        self.businessPageTemp = businessPage
                        self.garageEbicks += self.businessPageTemp!.objs
                        self.tableView.reloadData()

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

                }, latitude: Cache.USER.latitude.description, longitude: Cache.USER.longitude.description,paged:paged.description,brand:nil,businessScope:nil,lxbDeviceSellFlag:nil)

        }

    }


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        if(garageEbicks.count<1){

            return
        }

        var sb = UIStoryboard(name: "Main", bundle:nil)

        var vc = sb.instantiateViewControllerWithIdentifier("ebickGarageDetailTableController") as!  EbickGarageDetailTableController

        vc.busines = self.garageEbicks[indexPath.row]

        vc.hidesBottomBarWhenPushed = true

        self.navigationController?.pushViewController(vc, animated: true)
    }



}
