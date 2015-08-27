//
//  EbickBrandTableViewComtroller.swift
//  LIC
//
//  Created by 温红权 on 15/5/26.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class EbickBrandTableViewComtroller:BaseTableController,GDIIndexBarDelegate{


    var indexBar:GDIIndexBar?
    var indexContentView:IndexBarContentShowView?
    
    var alldata:Dictionary<String, JSON> = [String:JSON]()
    
    var allkey:[String]?
    
    
    override func viewDidLoad() {

        allkey = alldata.keys.array
        
        allkey!.sort(){
            
            $0 < $1
        }

         self.tableView.delaysContentTouches = false
        
        indexBar = GDIIndexBar(tableView: self.tableView)
        indexBar?.delegate = self
        
        indexBar?.textColor = CommonUtil.UIColorFromRGB(0x105ab9)
        indexBar?.textSpacing = 1
        indexBar?.textFont = UIFont.systemFontOfSize(14)
        
        indexBar?.backgroundColor = UIColor.clearColor()
        indexBar?.barBackgroundColor = UIColor.clearColor()
        
        
    
      

        self.tableView.addSubview(indexBar!)
     
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        
        self.navigationItem.title = "品牌"
        
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        
        
        var datas: AnyObject? = CommonUtil.readWithNSUserDefaults("BRANDS")
        if(datas != nil){
            Cache.BRANDS = JSON(datas!)
            self.display()
        }
        
        GpsService.sharedGpsService.GetEbickBrand({ (data) -> Void in
            if(data["status"].int == StatusCode.SystemSC.SYSTEM_OK){
                
                
                Cache.BRANDS = data["data"]
                CommonUtil.saveWithNSUserDefaults(Cache.BRANDS!.object, key: "BRANDS")
                self.display()
                
            }
        }, errorHandler: { (data) -> Void in
            
        })
    }
    
    
    func display(){
        self.alldata =  Cache.BRANDS!.dictionaryValue
        self.allkey = self.alldata.keys.array
        self.allkey!.sort(){
            $0 < $1
        }
        self.indexBar?.reload()
        self.tableView.reloadData()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        indexContentView = UIView.loadFromNibNamedView("IndexBarContentShowView", bundle: nil) as? IndexBarContentShowView
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        indexContentView?.removeFromSuperview()
    }
    
    
    
//    pragma marka - Index bar delegate
    func numberOfIndexesForIndexBar(indexBar: GDIIndexBar!) -> UInt {
        return UInt(allkey!.count)
    }

    func stringForIndex(index: UInt) -> String! {
        return allkey![Int(index)]
    }
    
    func indexBar(indexBar: GDIIndexBar!, didSelectIndex index: UInt) {
        
        self.tableView.scrollToRowAtIndexPath( NSIndexPath(forRow: 0, inSection: Int(index)), atScrollPosition: UITableViewScrollPosition.Top, animated: false)
        
        self.indexContentView?.showContent(self.allkey![Int(index)], view: self.navigationController?.navigationBar, size:indexContentView!.frame)
   
 

    }
    
    func touchEnds() {
         self.indexContentView?.hideContent()
    }
    
    
//    pragma mark - Table view data source
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         return allkey![section]
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return allkey!.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alldata[allkey![section]]!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("uIEbickBrankTableViewCell") as! UIEbickBrankTableViewCell
        
        
        var url:String? = (alldata[allkey![indexPath.section]]!)[indexPath.row]["logoUrl"].string
        
        cell.brandImage.sd_setImageWithURL(NSURL(string: url!),placeholderImage:UIImage(named: "downloadingpic"),options:SDWebImageOptions.RefreshCached)
        
//        var imageRequest  =  NSURLRequest(URL:  NSURL(string: url!)!, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval: 60)
//        cell.brandImage.setImageWithUrlRequest(imageRequest, placeHolderImage: UIImage(named: "downloadingpic"), success: nil, failure: nil)
        
        cell.ebickBrandLable.text = (alldata[allkey![indexPath.section]]!)[indexPath.row]["name"].string

        return cell;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var sb = UIStoryboard(name: "Main", bundle:nil)
        var vc = sb.instantiateViewControllerWithIdentifier("ebickGarageController") as!  EbickGarageController
        vc.businessScope = nil
        vc.lxbDeviceSellFlag = nil
        vc.pagetitle = (alldata[allkey![indexPath.section]]!)[indexPath.row]["name"].string
        vc.brandId = (alldata[allkey![indexPath.section]]!)[indexPath.row]["id"].int
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    
     
    
}