//
//  EbickGarageDetailTableController.swift
//  LIC
//
//  Created by 温红权 on 15/4/29.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class EbickGarageDetailTableController :BaseTableController,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var onlyrepairLable: UILabel!
    @IBOutlet weak var ebickBrandCollectionView: UICollectionView!
    @IBOutlet weak var repairImage: UIImageView!
    @IBOutlet weak var funcViewTop: NSLayoutConstraint!
      var layout: UICollectionViewFlowLayout?
     var layout1: UICollectionViewFlowLayout?
    
    @IBOutlet weak var addrLable: UILabel!
    
    @IBOutlet weak var mainBrandsTop: NSLayoutConstraint!
    @IBOutlet weak var repairPlaceTop: NSLayoutConstraint!
    
    @IBOutlet weak var lexingIcoImage: UIImageView!

    @IBOutlet weak var distanceLable: UILabel!
    @IBOutlet weak var telnumbLable: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var repairPlaceAddrView: UIView!
    @IBOutlet weak var repairPlaceFuncView: UIView!
    @IBOutlet weak var repairPlaceNameLable: UILabel!
    @IBOutlet weak var ebickBrandView: UIView!
    var allFuncData:[String] = []
    var mainBrandData:[String] = ["航天神迪"]
    var busines:Business?
    
    var images = [UIImage(named: "downloadingpicBig")]
    
    var ordTop:CGFloat = 0;
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(busines?.businessScopeValue != nil){
            allFuncData = []
            for name in busines!.businessScopeValue! {
                if(name != ""){
                   allFuncData.append(name)
                }
            }
            
        }else{
            allFuncData = []
        }
        
       
        if(busines?.brandValue != nil){
            mainBrandData = []
            for name in busines!.brandValue! {
                if(name != ""){
                    mainBrandData.append(name)
                }
            }
            
        }else{
            mainBrandData = []
        }
        
        

        layout = UICollectionViewFlowLayout()
        layout!.itemSize = CGSize(width: 75, height: 15)
        layout?.minimumLineSpacing = 8
        
        layout1 = UICollectionViewFlowLayout()
        layout1!.itemSize = CGSize(width: 75, height: 15)
        layout1?.minimumLineSpacing = 8
    
        collectionView.collectionViewLayout = layout!
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(FuncCollectionViewCell.self, forCellWithReuseIdentifier: "funcCollectionViewCell")
        
        var linenumb = CGFloat(allFuncData.count%3>0 ? (allFuncData.count/3)+1 : allFuncData.count/3)
        funcViewTop.constant =  53 + 15 * linenumb + 8 * (linenumb - 1)
        
        
        
        ebickBrandCollectionView.collectionViewLayout = layout1!
        
        ebickBrandCollectionView.dataSource = self
        ebickBrandCollectionView.delegate = self
        ebickBrandCollectionView.registerClass(FuncCollectionViewCell.self, forCellWithReuseIdentifier: "funcCollectionViewCell")
        
        linenumb = CGFloat(mainBrandData.count%3>0 ? (mainBrandData.count/3)+1 : mainBrandData.count/3)
        mainBrandsTop.constant =  53 + 15 * linenumb + 8 * (linenumb - 1)
        
        
        self.addrLable.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.addrLable.numberOfLines = 0
        
       
        
        
        ordTop = repairPlaceTop.constant

        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
      
        initUI()
        
        self.collectionView.scrollEnabled = false

        
        
        
        onlyrepairLable.hidden = true
        if(busines?.repairScope == "1"){
            onlyrepairLable.hidden = false
        }
     
        
        
        repairPlaceAddrView.layer.borderColor = CommonUtil.UIColorFromRGB(0xd9d9d9).CGColor
        repairPlaceAddrView.layer.cornerRadius = 2
        repairPlaceAddrView.layer.borderWidth = 1
        repairPlaceAddrView.layer.masksToBounds = true
        repairPlaceAddrView.layoutSubviews()
        
        
        repairPlaceFuncView.layer.borderColor = CommonUtil.UIColorFromRGB(0xd9d9d9).CGColor
        repairPlaceFuncView.layer.cornerRadius = 2
        repairPlaceFuncView.layer.borderWidth = 1
        repairPlaceFuncView.layer.masksToBounds = true
        repairPlaceFuncView.layoutSubviews()

        
        ebickBrandView.layer.borderColor = CommonUtil.UIColorFromRGB(0xd9d9d9).CGColor
        ebickBrandView.layer.cornerRadius = 2
        ebickBrandView.layer.borderWidth = 1
        ebickBrandView.layer.masksToBounds = true
        ebickBrandView.layoutSubviews()

        
        //初始化地址
        
        addrLable.text = busines?.address
        telnumbLable.text = busines?.telephone
        distanceLable.text = String(format:"%.1f", Double(Int(busines!.distance!/1000.0*10))/10.0) + "km"
        if(busines?.sPhotoUrl != nil){
            
//            var imageRequest  =  NSURLRequest(URL:  NSURL(string: busines!.sPhotoUrl!)!, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval: 60)
//            repairImage.setImageWithUrlRequest(imageRequest, placeHolderImage: UIImage(named: "downloadingpic"), success: nil, failure: nil)
//            
            repairImage.sd_setImageWithURL(NSURL(string:  busines!.sPhotoUrl!),placeholderImage:UIImage(named: "downloadingpic"),options:SDWebImageOptions.RefreshCached)

        }
        
        repairPlaceNameLable.text = busines?.name
        
    
        lexingIcoImage.hidden = true
        if(busines?.lxbDeviceSellFlag == 1){
           lexingIcoImage.hidden = false
        }
        
        

    }

    @IBAction func toGoButtonAction(sender: AnyObject) {
        
        var sb = UIStoryboard(name: "Main", bundle:nil)
        
        var vc = sb.instantiateViewControllerWithIdentifier("routeSearchController") as!  RouteSearchController
        
        vc.hidesBottomBarWhenPushed = true
        
        vc.startPt = CLLocationCoordinate2D(latitude: Cache.USER.latitude, longitude: Cache.USER.longitude)
        vc.endPt = CLLocationCoordinate2D(latitude: self.busines!.bd09Point!.lat, longitude:  self.busines!.bd09Point!.lng)
        
        vc.busniess = self.busines
        
        self.navigationController?.pushViewController(vc, animated: true)

        
    }
    
    @IBAction func telButtonAction(sender: AnyObject) {
        
        CommonUtil.alertTelService(self, tels: busines!.telephone!)
        
    }
    override func viewDidLayoutSubviews() {
        var size = CGRect();
        var size2 = CGSize();
        size =  addrLable!.text!.boundingRectWithSize(size2, options: NSStringDrawingOptions.UsesFontLeading, attributes: nil, context: nil);
        
        var linenumb = Int(size.width%addrLable.frame.width>0 ? (size.width/addrLable.frame.width)+1 : 1 )
        
        repairPlaceTop.constant = ordTop + CGFloat(linenumb - 1>0 ? linenumb - 1 : 0)*size.height
        
        
        headerView.frame.size.height = 40 + funcViewTop.constant + repairPlaceTop.constant + mainBrandsTop.constant
        
        self.tableView.sectionHeaderHeight = headerView.frame.size.height

        
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    
    override func viewDidAppear(animated: Bool) {

         self.tableView.tableHeaderView = self.tableView.tableHeaderView;
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
    }
    
  
  


    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
            var cell = tableView.dequeueReusableCellWithIdentifier("repairPlaceImage") as! RepairPlaceImageTableCell
        if(busines!.photoUrl == nil){
            cell.placeImageView.image =  CommonUtil.resizeImage(images[0]!, scan: cell.placeImageView.frame.width/images[0]!.size.width)
        }else{
            var imageRequest  =  NSURLRequest(URL: NSURL(string:busines!.photoUrl! )!, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval: 60)
//            cell.placeImageView.setImageWithUrlRequest(imageRequest, placeHolderImage:  CommonUtil.resizeImage(images[0]!, scan: cell.placeImageView.frame.width/images[0]!.size.width), success: nil, failure: nil)
        
             cell.placeImageView.sd_setImageWithURL(NSURL(string: busines!.photoUrl!),placeholderImage:CommonUtil.resizeImage(images[0]!, scan: cell.placeImageView.frame.width/images[0]!.size.width),options:SDWebImageOptions.RefreshCached)
            
        }
        
      
        
         
           cell.frame.size.height = cell.placeImageView.image!.size.height
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
  
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return  1
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        
        
        return CommonUtil.resizeImage(images[0]!, scan: (self.view.frame.width - 20)/images[0]!.size.width).size.height
   
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if(collectionView == self.collectionView){
          return allFuncData.count
        }
        
        if(collectionView == self.ebickBrandCollectionView){
            return mainBrandData.count
        }
        
        return 0
        
    }
    
   
  
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
    
       return 8
    }

    
    var maxCellWidth:CGFloat = 0;
    var maxCellWidth1:CGFloat = 0;
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("funcCollectionViewCell", forIndexPath: indexPath) as! FuncCollectionViewCell
        
        if(collectionView == self.collectionView){
            cell.setDisLableText(allFuncData[indexPath.row])
            if(cell.frame.width > maxCellWidth){
                maxCellWidth = cell.frame.width
                
                
                layout!.itemSize = CGSize(width: (self.collectionView.frame.width - 2 * 10)/3.0, height: 15)
                
                
                layout?.invalidateLayout()
                
                
            }
            
        }
        
        if(collectionView == self.ebickBrandCollectionView){
            cell.setDisLableText(mainBrandData[indexPath.row])
            if(cell.frame.width > maxCellWidth1){
                maxCellWidth1 = cell.frame.width
                
                
                layout1!.itemSize = CGSize(width: (self.ebickBrandCollectionView.frame.width - 2 * 10)/3.0, height: 15)
                
                
                layout1?.invalidateLayout()
                
                
            }
        }

        
       
       

        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func initUI(){
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        
        self.navigationItem.title = "商铺详情"
        
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.scrollEnabled = true
    }

    
}