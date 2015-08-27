//
//  TrackTableController.swift
//  LIC
//
//  Created by 温红权 on 15/4/22.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation
//import UIKit


protocol TrackTableDegetel{
    
    func turnToTrancePlay(startTime:NSTimeInterval,endTime:NSTimeInterval,showStop:Bool)
    
    func turnToPreviousDate()
    
    func turnToNextDate()
    
}

class TrackTableController:BaseTableController{
    
    var trackTableDegetel:TrackTableDegetel?
    
    @IBOutlet weak var headViews: UIView!
    @IBOutlet weak var numberView: UIView!
    
    @IBOutlet weak var numberViewWidth: NSLayoutConstraint!
    @IBOutlet weak var tranceBgView: UIView!
    
    @IBOutlet weak var norecodeLable: UILabel!
    var alltrance:[Trance] = []
    
    var isToday = true
    
    var isinit = true
    
    var timedate:String?
    
    var drivingMileage:Double?
    
    var drivingTime:Double?
    
    @IBOutlet weak var allTimeLable: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
        initArc()
        
        
    }
    
    @IBAction func previousButtonAction(sender: AnyObject) {
        
        trackTableDegetel?.turnToPreviousDate()
    }
    
    
    @IBAction func nextButtonAction(sender: AnyObject) {
        
        trackTableDegetel?.turnToNextDate()
        
    }
    
    
    
    func refresh(){
        
        if alltrance.count == 0 {
            
            headViews.hidden = true
            headViews.frame.size.height = 0
            self.tableView.scrollEnabled = false
            self.tableView.tableHeaderView = headViews
            self.tableView.tableHeaderView =  self.tableView.tableHeaderView
        }else{
            headViews.frame.size.height = 265
            headViews.hidden = false
            
            self.tableView.tableHeaderView = headViews
            self.tableView.tableHeaderView =  self.tableView.tableHeaderView
            self.tableView.allowsSelection = true
            self.tableView.scrollEnabled = true
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        }
        self.tableView.reloadData()
        
        
        if(drivingMileage != nil && drivingTime != nil ){

            
            setProcess((CGFloat(drivingMileage!) / (60*1000)) * 100)

            setmiles(String(format:"%.1f", Double(Int((drivingMileage! / 1000.0)*10)) / 10.0) )
            
            allTimeLable.text = changetime(drivingTime!)
            
        }
        
    }
    
    func changetime(num:NSTimeInterval) ->String  {
        var MINS = ""
        var hour:Int = 0
        
        var data = 0;
        var hous = Double(num) / 3600.0;
        
        hour = Int(hous);
        var mins = ( Double(num) - Double(hour) * 3600.0 ) / 60.0;
        
        if( mins - Double(Int(mins)) >= 0.5){
            MINS=(Int(mins)+1).description;
        }else{
            MINS=Int(mins).description;
        }
        if (mins < 10) {
            MINS = "0" + Int(mins).description;
        }
        
        var times = ""
        
        if (hour > 0) {
            
            if(mins<=0){
                
                times = hour.description + "时"
                
                return times
                
            }
            
            times = hour.description + "时"
            
            times = times + MINS + "分"
            
            return times
            
        }
        
        times = MINS + "分"
        
        return times

        
    }
    
    
    var layer_d:CALayer?
    var arc1:CAShapeLayer?
    
    func setmiles(miles:String){
        
        for view in numberView.subviews {
            view.removeFromSuperview()
        }
        
        var dianCount = 0
        var numberWidth:CGFloat = 0 ;
        var index = 0
        for c:Character in miles {
            var imageView = UIImageView()
            var imageViewY:CGFloat = 0
            var imageViewW:CGFloat = 18;
            var imageViewH:CGFloat = 37;
            var imageViewX:CGFloat =  CGFloat(index++) * imageViewW ;
            if(dianCount > 0){
                imageViewX = CGFloat(index-dianCount-1) * imageViewW  + CGFloat(dianCount)*8
            }
            
            if(c == "."){
                dianCount++
                imageViewW = 8;
                imageViewH = 5;
                imageViewY = 37 - 5
                imageView.image = UIImage(named: "number_dian")
                imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH)
                numberView.addSubview(imageView)
                numberWidth += imageViewW
                continue;
            }
            var names:String = ""
            names.append(c)
            imageView.image = UIImage(named: names)
            imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH)
            numberView.addSubview(imageView)
            numberWidth += imageViewW
        }
        numberViewWidth.constant  = numberWidth
        numberView.layoutIfNeeded()
        //        numberView.needsUpdateConstraints()
        
    }
    
    
    func setProcess(process:CGFloat){
        
        if(arc1 == nil){
            initArc()
        }
        var rect = self.tranceBgView.frame
        
        
        arc1!.path = UIBezierPath(arcCenter: CGPoint(x: CGFloat(rect.size.width/2.0), y: CGFloat(rect.size.height/2.0)), radius: CGFloat(rect.size.width/2.0) - 20, startAngle: CGFloat(-M_PI_2), endAngle:CGFloat(-M_PI_2) + (process/100.0) *  2 * CGFloat(M_PI) , clockwise: true).CGPath
        
        var drawAnimation = CABasicAnimation(keyPath: "strokeEnd")
        drawAnimation.duration            = 5.0; // "animate over 10 seconds or so.."
        drawAnimation.repeatCount         = 1.0;  // Animate only once..
        drawAnimation.removedOnCompletion = true;   // Remain stroked after the animation..
        drawAnimation.fromValue = 0
        drawAnimation.toValue   = 10
        drawAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        
        arc1!.addAnimation(drawAnimation, forKey: "drawCircleAnimation")
        
        layer_d?.mask = arc1
        
    }
    
    
    
    func initArc(){
        
        var rect = self.tranceBgView.frame
        
        arc1 = CAShapeLayer()
        arc1!.path = UIBezierPath(arcCenter: CGPoint(x: CGFloat(rect.size.width/2.0), y: CGFloat(rect.size.height/2.0)), radius: CGFloat(rect.size.width/2.0) - 20, startAngle: CGFloat(-M_PI_2), endAngle:CGFloat(-M_PI_2 ), clockwise: true).CGPath
        arc1!.fillColor = UIColor.clearColor().CGColor
        arc1!.strokeColor = UIColor.purpleColor().CGColor
        arc1!.lineWidth = 20
        arc1!.lineCap = kCALineCapRound
        
        
        /// 轨道
        var arc = CAShapeLayer()
        arc.path =  UIBezierPath(arcCenter: CGPoint(x: CGFloat(rect.size.width/2.0), y: CGFloat(rect.size.height/2.0)), radius: CGFloat(rect.size.width/2.0) - 20, startAngle: 0, endAngle:CGFloat(M_PI * 2), clockwise: true).CGPath
        arc.fillColor = UIColor.clearColor().CGColor
        arc.strokeColor = UIColor.whiteColor().CGColor
        arc.lineWidth = 20
        arc.strokeStart = 0;
        arc.strokeEnd = 1.0;
        
        self.tranceBgView.layer.addSublayer(arc);
        
        
        
        var drawAnimation = CABasicAnimation(keyPath: "strokeEnd")
        drawAnimation.duration            = 5.0; // "animate over 10 seconds or so.."
        drawAnimation.repeatCount         = 1.0;  // Animate only once..
        drawAnimation.removedOnCompletion = true;   // Remain stroked after the animation..
        drawAnimation.fromValue = 0
        drawAnimation.toValue   = 10
        drawAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        arc1!.addAnimation(drawAnimation, forKey: "drawCircleAnimation")
        
        
        var gradientLayer =  CAGradientLayer()
        gradientLayer.frame = CGRect(x: self.tranceBgView.frame.width/2, y: 0, width: self.tranceBgView.frame.width/2, height: self.tranceBgView.frame.height/2)
        gradientLayer.colors = [CommonUtil.UIColorFromRGB(0x4fe9cc).CGColor,CommonUtil.UIColorFromRGB(0x48bfdc).CGColor,CommonUtil.UIColorFromRGB(0x6783c7).CGColor]
        gradientLayer?.locations = [0,0.5,1.0];
        gradientLayer.startPoint = CGPointMake(0.2,0.2);
        gradientLayer.endPoint = CGPointMake(0.8,0.8);
        
        
        
        
        var gradientLayer1 =  CAGradientLayer()
        gradientLayer1.frame = CGRect(x: self.tranceBgView.frame.width/2, y: self.tranceBgView.frame.height/2, width: self.tranceBgView.frame.width/2, height: self.tranceBgView.frame.height/2)
        gradientLayer1.colors = [CommonUtil.UIColorFromRGB(0x6783c7).CGColor,CommonUtil.UIColorFromRGB(0xc04384).CGColor,CommonUtil.UIColorFromRGB(0xe55f5b).CGColor]
        gradientLayer1?.locations = [0,0.5,1.0];
        gradientLayer1.startPoint = CGPointMake(0.8,0.2);
        gradientLayer1.endPoint = CGPointMake(0.2,0.8);
        
        
        
        var gradientLayer2 =  CAGradientLayer()
        gradientLayer2.frame = CGRect(x: 0, y: self.tranceBgView.frame.height/2, width: self.tranceBgView.frame.width/2, height: self.tranceBgView.frame.height/2)
        gradientLayer2.colors = [CommonUtil.UIColorFromRGB(0xe55f5b).CGColor,CommonUtil.UIColorFromRGB(0xeaa13e).CGColor,CommonUtil.UIColorFromRGB(0xc0de61).CGColor]
        gradientLayer2?.locations = [0,0.5,1.0];
        gradientLayer2.startPoint = CGPointMake(0.8,0.8);
        gradientLayer2.endPoint = CGPointMake(0.2,0.2);
        
        
        
        
        var gradientLayer3 =  CAGradientLayer()
        gradientLayer3.frame = CGRect(x: 0, y: 0, width: self.tranceBgView.frame.width/2, height: self.tranceBgView.frame.height/2)
        gradientLayer3.colors = [CommonUtil.UIColorFromRGB(0xc0de61 ).CGColor ,CommonUtil.UIColorFromRGB(0x96de61).CGColor,CommonUtil.UIColorFromRGB(0x4fe9cc).CGColor]
        gradientLayer3?.locations = [0,0.5,1.0];
        gradientLayer3.startPoint = CGPointMake(0.2,0.8);
        gradientLayer3.endPoint = CGPointMake(0.8,0.2);
        
        
        layer_d = CALayer()
        layer_d?.insertSublayer(gradientLayer, atIndex: 0)
        layer_d?.insertSublayer(gradientLayer1, atIndex: 0)
        layer_d?.insertSublayer(gradientLayer2, atIndex: 0)
        layer_d?.insertSublayer(gradientLayer3, atIndex: 0)
        layer_d?.mask = arc1
        
        //        self.tranceBgView.layer.addSublayer(gradientLayer1);
        self.tranceBgView.layer.addSublayer(layer_d);
        
        
        
    }
    
    
    
    
    
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return alltrance.count > 0 ?  alltrance.count : 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if(alltrance.count == 0){
            var cell = tableView.dequeueReusableCellWithIdentifier("norecode") as! NoRecodeTableCell
            
            if(isToday){
                
                cell.distextlable.text = "今日没有行驶记录"
            }else{
                
                cell.distextlable.text = "当日没有行驶记录"
            }
            
//            if(isinit){
//                
//                cell.distextlable.hidden = true
//                cell.NoimageView.hidden = true
//            }else{
            
                cell.distextlable.hidden = false
                cell.NoimageView.hidden = false
//            }
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
            
        }
        
        var trance = self.alltrance[indexPath.row]
        
        if(trance.ebikeId  == nil){
            var cell = tableView.dequeueReusableCellWithIdentifier("tranceStop") as! TranceStopTableCell
            
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            if(trance.endAddr != nil){
                
                cell.stopPlaceLable.text =  CommonUtil.StringLimt(11, string: trance.endAddr!)
            }else{
                cell.stopPlaceLable.text =  ""
            }
            
            
            
            var text =  CommonUtil.FloatToTime(trance.parkingTime)
            
            if(text != ""){
                text = "停留"+text
            }
            
            cell.stopTimeLable.text = text
            
            return cell
            
            
        }else{
            
            var cell = tableView.dequeueReusableCellWithIdentifier("tranceRecode") as! TranceTableCell
            
            
            
            cell.tranceLengthLable.attributedText =  CommonUtil.SetLableTextAttr(String(format:"%.1f", Double(Int((trance.mileage!/1000.0)*10)) / 10.0),numSize:16.0, desc: "公里",descSize:10.0)
            
            cell.tranceTimeLable.attributedText = CommonUtil.FloatToAttrTime(trance.useTime)
            
            cell.tranceStopCount.attributedText = CommonUtil.SetLableTextAttr(trance.temporaryParkingCount!.description,numSize:16.0, desc: "次",descSize:10.0)
            
            var temp = CommonUtil.FloatToDate(trance.startTime!,format:"yyyy-MM-dd")
            
            if(temp == self.timedate || self.timedate == "今日"){
                cell.tranceStartTimeLable.text = CommonUtil.FloatToDate(trance.startTime!,format:"HH:mm") + "启动"
            }else{
                
                cell.tranceStartTimeLable.text = CommonUtil.FloatToDate(trance.startTime!,format:"yy-MM-dd HH:mm") + "启动"
            }
            
            cell.tanceStopLable.text = CommonUtil.FloatToDate(trance.endTime!,format:"HH:mm") + "停止"
            
            cell.selectedBackgroundView = UIView();
            cell.selectedBackgroundView.backgroundColor = CommonUtil.UIColorFromRGB(0xd9ddeb);
            
            return cell
            
        }
        
        
        
        
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if(alltrance.count < 1){
            
            return
        }
        
        var trance = alltrance[indexPath.row]
        
        if(trance.ebikeId != nil){
            
            
            trackTableDegetel?.turnToTrancePlay(trance.startTime!, endTime: trance.endTime!,showStop:true)
            
            
        }
        
        
        
    }
    
   

    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if alltrance.count == 0 {
            
            return self.tableView.frame.height
        }else{
            
            var trance = self.alltrance[indexPath.row]
            
            if(trance.ebikeId   == nil){
                return 42
                
            }else{
                return 90
            }
            
            
        }
    }
    
    
}
