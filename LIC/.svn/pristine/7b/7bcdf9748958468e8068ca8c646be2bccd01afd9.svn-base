//
//  CityOfflineMapTableCell.swift
//  LIC
//
//  Created by 温红权 on 15/5/8.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class CityOfflineMapTableCell :UITableViewCell {
    
    @IBOutlet weak var citySizeLable: UILabel!
    @IBOutlet weak var cityNameLable: UILabel!
    @IBOutlet weak var downloadSuccessLable: UILabel!
    @IBOutlet weak var downloadPicView: UIViewTouchView!
    
    @IBOutlet weak var downloadImageView: UIImageView!
    var shapeLayer:CAShapeLayer?
    var shapeLayer2:CAShapeLayer?
    
    
    var cityId:Int32?
    var status:Int = 0 // 0--未下载 1--正在下载  2--暂停  3--完成
    
    
    func setDownloadStatus(statu:Int){
    status=statu
    if(status == 0){
        setprecess(0)
        downloadPicView.hidden = false
        downloadSuccessLable.hidden = true
        downloadImageView.image = UIImage(named: "offline_map_download")
    
    }else
    if(status == 1){
        downloadPicView.hidden = false
        downloadSuccessLable.hidden = true
        downloadImageView.image = UIImage(named: "offline_map_start")
    }else
    if(status == 2){
        downloadPicView.hidden = false
        downloadSuccessLable.hidden = true
        downloadImageView.image = UIImage(named: "offline_map_stop")
    }else
    if(status == 3){
        setprecess(0)
        downloadPicView.hidden = true
        downloadSuccessLable.hidden = false
    }
        
    
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle =  UITableViewCellSelectionStyle.None
        
        
        //创建出CAShapeLayer
        self.shapeLayer = CommonUtil.newLineOverlay()
        self.shapeLayer!.frame = downloadImageView.frame;
        self.shapeLayer!.position = self.downloadImageView.center;
        self.shapeLayer!.fillColor = UIColor.clearColor().CGColor;
        
        self.shapeLayer2 = CommonUtil.newLineOverlay()
        self.shapeLayer2!.frame = downloadImageView.frame;
        self.shapeLayer2!.position = self.downloadImageView.center;
        self.shapeLayer2!.fillColor = UIColor.clearColor().CGColor;
        
        
        //设置线条的宽度和颜色
        self.shapeLayer!.lineWidth = 2.4;
        self.shapeLayer!.strokeColor = CommonUtil.UIColorFromRGB(0x007aff).CGColor;
        
        self.shapeLayer2!.lineWidth = 2.4;
        self.shapeLayer2!.strokeColor = CommonUtil.UIColorFromRGB(0x007aff).CGColor;
        
        //设置stroke起始点
        self.shapeLayer!.strokeStart = 0;
        self.shapeLayer!.strokeEnd = 0;
        
        self.shapeLayer2!.strokeStart = 0.0;
        self.shapeLayer2!.strokeEnd = 0;

        var rect = downloadImageView.frame
        
        //创建出圆形贝塞尔曲线
        var circlePath = UIBezierPath(ovalInRect: CGRect(x: rect.origin.x + 1.2, y: rect.origin.y + 1.2, width: rect.size.width - 2.4, height: rect.size.height - 2.4))
        //让贝塞尔曲线与CAShapeLayer产生联系
        self.shapeLayer!.path = circlePath.CGPath;
        
        self.shapeLayer2!.path = circlePath.CGPath;
        
        //添加并显示
        self.downloadImageView.layer.addSublayer(self.shapeLayer)
        self.downloadImageView.layer.addSublayer(self.shapeLayer2)
        
//         NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("precess"), userInfo: nil, repeats: true)
        
        downloadPicView.clickevnt = {()in
          self.viewtap()
        }
        
      
        
        setDownloadStatus(0)
    }




    
    func viewtap(){
        if(cityId != nil){
            
            if(status == 0){
              //开下载
              OfflineMapDownLoadManage.sharedOfflineMapDownLoadManage.startDownLoadCity(Int32(cityId!))
              self.setDownloadStatus(1)
            }else
            if(status == 1){
                //暂停
                OfflineMapDownLoadManage.sharedOfflineMapDownLoadManage.pauseDownLoadCity(Int32(cityId!))
                self.setDownloadStatus(2)
            }else
            if(status == 2){
                //开始下载
                OfflineMapDownLoadManage.sharedOfflineMapDownLoadManage.startDownLoadCity(Int32(cityId!))
                self.setDownloadStatus(1)
            }
        
        }
        
        
    }

    
    func setprecess(process:CGFloat){
        if (process >= 0 && process <= 25){
        
            self.shapeLayer!.strokeStart = 0.75;
            self.shapeLayer!.strokeEnd = 0.75 + process/100.0;
            
            self.shapeLayer2!.strokeStart = 0.0;
            self.shapeLayer2!.strokeEnd = 0.0;
        }
        
        if(process > 25 && process <= 100){
            self.shapeLayer!.strokeStart = 0.75;
            self.shapeLayer!.strokeEnd = 1.0;
            
            self.shapeLayer2!.strokeStart = 0.0;
            self.shapeLayer2!.strokeEnd = (process - 25)/100.0;
        }
    
    }
    var procesas = 0
    
    func precess(){
       procesas++
        if(procesas > 100){
           procesas = 0
        }
      setprecess(CGFloat(procesas))
    }
    
}