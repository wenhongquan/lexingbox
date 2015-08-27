//
//  TrackThePlaybackController.swift
//  LIC
//
//  Created by 温红权 on 15/4/20.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class TrackThePlaybackController :BaseController,UIScrollViewDelegate,TrackTableDegetel, FSCalendarDataSource, FSCalendarDelegate,UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var calendarview: UIView!

    @IBOutlet weak var topviews: UIView!

    @IBOutlet weak var playAll: UIButton!
    @IBOutlet weak var viewtop: NSLayoutConstraint!
    var todaybutton: UIButton!
    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var playallView: UIView!
    
    @IBOutlet weak var bottomspace: NSLayoutConstraint!
    weak var tableControl:TrackTableController!
    
    
    var imageRight:UIImageView!
    var datetextLable:UILabel!
    var rightView:UIViewTouchView!
    
    var frams:CGRect!
    var buttonfram:CGRect!
    
    

    var TranceRecodes:[Trance] = []
    
    var loading:JGProgressHUD?
    
    var selectDate:NSDate?
    
    var days:[NSDate] = []
    
    
    func getTranceRecords(startTime:String,endTime:String){
    
        if(Cache.EBICK == nil){
           return
        }
    
        CommonUtil.GCDThread({()in
        
            GpsService.sharedGpsService.GetEbickTranceRecords({(data) in
                
                 self.loading?.dismiss()
                
                if(data["status"].int == StatusCode.SystemSC.SYSTEM_OK){
                    
                    self.TranceRecodes = []
                    self.tableControl.isinit = false
                    
                    var records:Records = Mapper<Records>().map(data["data"].dictionaryObject!)
                    
                    //渲染
                    
                    self.tableControl.drivingTime = records.drivingTime
                    self.tableControl.drivingMileage = records.drivingMileage
                    
                    
                    var tranceTemp:[Trance] = []
                    if(records.drivingRecords.count > 0){
                        for var i=0;i<records.drivingRecords.count;i++ {
                            var trance = records.drivingRecords[i]
                            if(trance.parkingTime != nil){
                                var trancetemp = Trance()
                                trancetemp.endAddr = trance.startAddr
                                trancetemp.parkingTime = trance.parkingTime
                                tranceTemp.append(trancetemp)
                            }
                            
                            tranceTemp.append(trance)
                            
                        }
                        
                        if (records.parkingTime != nil) {
                            var trance = records.drivingRecords[records.drivingRecords.count - 1]
                            var trancetemp = Trance()
                            trancetemp.endAddr = trance.endAddr
                            trancetemp.parkingTime = records.parkingTime
                            tranceTemp.append(trancetemp)
                        }else{
                            var trance = records.drivingRecords[records.drivingRecords.count - 1]
                            var trancetemp = Trance()
                            trancetemp.endAddr = trance.endAddr
                            tranceTemp.append(trancetemp)
                        }
                        
                    }
                    
                    self.TranceRecodes = tranceTemp
                    self.tableControl.alltrance = self.TranceRecodes
                    
                    if( self.TranceRecodes.count>0){
                        self.bottomspace.constant = 50
                        self.playallView.hidden = false
                    }else{
                        self.bottomspace.constant = 0
                        self.playallView.hidden = true
                    }
                    
                    
                    
                    
                    self.tableControl.refresh()
                    
                }else{
                
                    self.TranceRecodes = []
                    self.tableControl.alltrance = []
                    
                    self.playallView.hidden = true
                    self.tableControl.refresh()
                }
                
                
                
                
                
                }, errorHandler: {(data) in
                    
                    
                    
                }, startTime: startTime, endTime: endTime, ebickId: Cache.EBICK.id.description)
        
            }, afterdo: nil)
        
        
    
    }
    
    
   
    func getTranceStatus(){
        if(Cache.EBICK == nil){
          return
        }
        
        var firstdate = CommonUtil.FloatToDate(Cache.EBICK?.firstUseTime)
        var nowdate = NSDate()
        
        for year in firstdate.fs_year ... nowdate.fs_year {
        
            
            GpsService.sharedGpsService.GetEbickTranceStatus({(data) in
                
                self.loading?.dismiss()

                if(data["status"].int == StatusCode.SystemSC.SYSTEM_OK){
                    for (key: String, subJson: JSON) in data["data"] {
                        
                        if(subJson.count > 0){
                            for var i=0;i<subJson.count;i++ {
                                var day:Int = subJson[i].int!
                                
                                var date = key
                                if(day > 9){
                                   date += day.description
                                }else{
                                   date += "0" + day.description
                                }
                                
                                var datetemp:NSDate = NSDate.fs_dateFromString(date, format: "yyyyMMdd")
                                
                                
                                
                                if(self.days.count == 0){
                                   self.days.append(datetemp)
                                }else{
                                
                                    var isin = false
                                    for j in self.days {
                                        if( datetemp.compare(j) == NSComparisonResult.OrderedSame ){
                                           isin = true
                                            break
                                        }
                                    }
                                    if(!isin){
                                       self.days.append(datetemp)
                                    }
                                }
                            }
                        
                        }
                    }
                    
                   self.calendar.reloadData()
                }
                
                }, errorHandler: {(data) in
                    
                    
                }, year: year.description, ebickId: Cache.EBICK.id.description)
        
        }
        
    
        
    
    
    }
    
    
    override func viewDidLoad() {
        
       initUI()
        
       self.playallView.hidden = true
        self.bottomspace.constant = 0
        
        rightView = UIViewTouchView()
        var imageLeft = UIImageView()
        datetextLable = UILabel()
        imageRight = UIImageView()
        
        imageLeft.image = UIImage(named: "calendar")
        datetextLable.text = "今日"
        imageRight.image = UIImage(named: "calendartrun")
    
        
        datetextLable.font = UIFont.systemFontOfSize(10)
        datetextLable.textColor = UIColor.whiteColor()
        datetextLable.textAlignment = NSTextAlignment.Center
       
        rightView.frame = CGRectMake(0.0, 0.0,100, 34);
        imageLeft.frame = CGRectMake(0.0, (rightView.frame.size.height - 13)/2.0,13, 13);
        datetextLable.frame = CGRectMake(imageLeft.frame.size.width, (rightView.frame.size.height - 15)/2.0,80, 15);
        
        
        
        var size = CGRect();
        var size2 = CGSize();
        size =  datetextLable.text!.boundingRectWithSize(size2, options: NSStringDrawingOptions.UsesFontLeading, attributes: nil, context: nil);
        datetextLable.frame.size.width = size.width
        rightView.frame.size.width = 13+6+size.width
        
        imageRight.frame = CGRectMake(imageLeft.frame.size.width + datetextLable.frame.size.width,  (rightView.frame.size.height - 6)/2.0,6, 6);
        
        
        rightView.addSubview(imageLeft)
        rightView.addSubview(datetextLable)
        rightView.addSubview(imageRight)
        
        
        rightView.clickevnt = {
        () in
            
            self.calendaraction()
        
        }
        
       

        
        var baritem = UIBarButtonItem(customView: rightView)
        
        self.navigationItem.rightBarButtonItem = baritem
        buttonfram = self.navigationItem.rightBarButtonItem?.customView?.bounds
        
        
        
       frams = UIScreen.mainScreen().bounds
       calendarview.backgroundColor = UIColor(white: 0, alpha: 0.6)
        
   
        
        
      
        
        calendar.appearance.weekdayTextColor = CommonUtil.UIColorFromRGB(0x000)
        calendar.appearance.headerTitleColor = CommonUtil.UIColorFromRGB(0x2bcd9c)
        calendar.appearance.selectionColor = CommonUtil.UIColorFromRGB(0x2bcd9c)
        calendar.appearance.headerDateFormat = "yyyy MMMM"
        calendar.appearance.eventColor = CommonUtil.UIColorFromRGB(0xe9f4ff)
       
        calendar.appearance.subtitleFont = UIFont.systemFontOfSize(8)
        calendar.appearance.cellStyle = FSCalendarCellStyle.Circle
       
        todaybutton = UIButton();
        todaybutton.frame = CGRectMake(self.view.frame.width - 40 - 50, 14, 40, 20);
        todaybutton.titleLabel?.font = UIFont.systemFontOfSize(12)
        todaybutton.setTitle("今日",forState:UIControlState.Normal);

        calendarview.addSubview(todaybutton)
        
        todaybutton = CommonUtil.buttonSetImage(todaybutton, name: "whritebtn-normal", states: [UIControlState.Normal,UIControlState.Selected,UIControlState.Highlighted])
        todaybutton.setTitleColor(CommonUtil.UIColorFromRGB(0x2bcd9c), forState: UIControlState.Normal)
        todaybutton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
        todaybutton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        todaybutton.addTarget(self, action: "todayTapaction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        playAll = CommonUtil.buttonSetImage(playAll, name: "remove_devicebtn", states: [UIControlState.Normal,UIControlState.Selected,UIControlState.Highlighted])
        playAll.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
        playAll.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        
        
        
     
        
        
        var tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "viewtap:")
        tapGesture.delegate = self
        calendarview.addGestureRecognizer(tapGesture)
        
       isfirstCalendarSelect = true
        
        
        
       
       
     

    }
    
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "recodeSegue") {
            tableControl = segue.destinationViewController as! TrackTableController
            tableControl.trackTableDegetel = self
        }
    }
    
    
    @IBAction func playAllAction(sender: AnyObject) {
        
        
        if TranceRecodes.count < 1 {
        
            
            
            CommonUtil.alertView(self, title: "无轨迹", message: "", buttons: [AlertHandler(title: "确定", handle: {  ()in
                
            })])
           return

        }
        
        turnToTrancePlay(TranceRecodes[1].startTime!, endTime: TranceRecodes[TranceRecodes.count - 2].endTime!,showStop:false)
    }
    
   
    @IBAction func todayTapaction(sender: AnyObject) {
        
        if(calendar?.selectedDate != nil){
            if  calendar!.selectedDate.isToday(calendar!.selectedDate)  {
                setDisplayDate(NSDate())
            }else{
                
                var date:NSDate = NSDate()
                var zone = NSTimeZone.systemTimeZone()
                var interval = NSTimeInterval(zone.secondsFromGMTForDate(date))
                var localDate = date.dateByAddingTimeInterval(interval)
                
                
                
                calendar?.selectedDate = localDate
            }
        }else{
             setDisplayDate(NSDate())
        }
    }
    
    func viewtap(gesture:UITapGestureRecognizer){
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        
        var touchClassName = NSStringFromClass(touch.view.classForCoder)
        
        if(touch.view.isKindOfClass(UIViewFull)){
             self.calendaraction()
        }
        return false
    }

    
    func calendar(calendar: FSCalendar!, hasEventForDate date: NSDate!) -> Bool {
        
        var isin = false
        for datetemp in days {
        
            if(date ==  datetemp) {
               isin = true
                break;
            }
        }
        
        return isin
    }
    
    
    
    //pragma mark - FSCalendarDataSource
    func calendar(calendar: FSCalendar!, subtitleForDate date: NSDate!) -> String! {
        
       
        
        if  date.isToday(date)  {
          return "今日";
        }else{
          return nil;
        }
        
    }
    
    
    func minimumDateForCalendar(calendar: FSCalendar!) -> NSDate {
        
        var nowdate = NSDate()
        var date = CommonUtil.FloatToDate(Cache.EBICK?.firstUseTime)
        if(Cache.EBICK?.firstUseTime != nil){
            date = CommonUtil.FloatToDate(Cache.EBICK?.firstUseTime)
            
        }else{
            
            date = NSDate.fs_dateWithYear(nowdate.fs_year, month: nowdate.fs_month - 3, day: 1)
        }

        return NSDate.fs_dateWithYear(date.fs_year, month: date.fs_month - 1, day: 1)
    }
    
    func maximumDateForCalendar(calendar: FSCalendar!) -> NSDate{
        
        var nowdate = NSDate()
        var date = CommonUtil.FloatToDate(Cache.EBICK?.firstUseTime)
        if(Cache.EBICK?.firstUseTime != nil){
            date = CommonUtil.FloatToDate(Cache.EBICK?.firstUseTime)
            
        }else{
            
            date = NSDate.fs_dateWithYear(nowdate.fs_year, month: nowdate.fs_month - 3, day: 1)
        }
        
        return NSDate.fs_dateWithYear(nowdate.fs_year, month: nowdate.fs_month + 1, day: 1)
    }
    //- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
    //{
    //    return [NSDate fs_dateWithYear:2015 month:6 day:15];
    //}
    //
    //- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
    //{
    //    return [NSDate fs_dateWithYear:2015 month:7 day:15];
    //}

    
    

    
    //pragma mark - FSCalendarDelegate
    func calendar(calendar: FSCalendar!, didSelectDate date: NSDate!) {
        

        setDisplayDate(date)
 
    }
    
//    func calendar(calendar: FSCalendar!, shouldSelectDate date: NSDate!) {
//        
//        var zone = NSTimeZone.systemTimeZone()
//        var interval = NSTimeInterval(zone.secondsFromGMTForDate(date))
//        var localDate = date.dateByAddingTimeInterval(interval)
//        
//        setDisplayDate(localDate)
//        
//    }
    

    
    
    

    
    
    func setDisplayDate(date:NSDate){
    
        selectDate =  NSDate.fs_dateWithYear(date.fs_year, month: date.fs_month, day: date.fs_day).fs_dateByIgnoringTimeComponents
        
        calendar.appearance.setTodayColorNoReload(CommonUtil.UIColorFromRGB(0x2bcd9c).colorWithAlphaComponent(0))
        
        calendar.appearance.setTitleTodayColorNoReload(CommonUtil.UIColorFromRGB(0x2bcd9c))
        calendar.appearance.setSubtitleTodayColorNoReload(CommonUtil.UIColorFromRGB(0x2bcd9c))
    
        if(!self.isfirstCalendarSelect){
            if(show){
               NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("calendaraction"), userInfo: nil, repeats: false)
            }
        }
        self.isfirstCalendarSelect = false
        
        if(selectDate!.isToday(selectDate!)){
            datetextLable.text = "今日"
            self.tableControl.timedate = "今日"
            
            var size = CGRect();
            var size2 = CGSize();
            size =  datetextLable.text!.boundingRectWithSize(size2, options: NSStringDrawingOptions.UsesFontLeading, attributes: nil, context: nil);
            datetextLable.frame.size.width = size.width
            rightView.frame.size.width = 13+6+size.width
            imageRight.frame.origin.x = rightView.frame.size.width - 6
            
            self.tableControl?.isToday = true
            
        }else{
            
            datetextLable.text = date.fs_stringWithFormat("yyyy-MM-dd")
            
            self.tableControl.timedate = datetextLable.text
            var size = CGRect();
            var size2 = CGSize();
            size =  datetextLable.text!.boundingRectWithSize(size2, options: NSStringDrawingOptions.UsesFontLeading, attributes: nil, context: nil);
            datetextLable.frame.size.width = size.width
            rightView.frame.size.width = 13+6+size.width
            imageRight.frame.origin.x = rightView.frame.size.width - 6
            
            self.tableControl?.isToday = false
            
        }
        
        //     self.tableControl?.tableView.reloadData()
        
        
        self.getTranceRecords(Int64(selectDate!.timeIntervalSince1970 * 1000).description, endTime:Int64(NSDate.fs_dateWithYear(date.fs_year, month: date.fs_month, day: date.fs_day + 1).timeIntervalSince1970 * 1000).description)

    }
    
    
    
    var show = false
    
    func calendaraction(){
        
        if(show){
            UIView.animateWithDuration(0.5, animations: {
                self.viewtop.constant = -320
                self.calendarview.alpha = 0
                self.topviews.layoutIfNeeded()
            })
           imageRight.image = UIImage(named: "calendartrun")
            
           NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("calendarviewhide"), userInfo: nil, repeats: false)
        }else{
           
//          calendarHeader.bringSubviewToFront(todaybutton)
//          calendarHeader.layoutIfNeeded()
          UIView.animateWithDuration(0.5, animations: {
              self.viewtop.constant = 0
                self.calendarview.alpha = 1
                 self.topviews.layoutIfNeeded()
          })
         imageRight.image = UIImage(named: "calendarup")
         calendarviewshow()
        }
        
        
    }

    func calendarviewhide(){
       calendarview.hidden = true
       self.calendarview.alpha = 0
       show = false
        self.navigationController?.interactivePopGestureRecognizer.enabled = true
    }
    func calendarviewshow(){
        calendarview.hidden = false
        show = true
        self.navigationController?.interactivePopGestureRecognizer.enabled = false

    }
    
    func initUI(){
        
        
        var item1 = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "clear:")
        item1.tintColor = UIColor.whiteColor()
        self.navigationItem.setLeftBarButtonItems([item1], animated: false)
        
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        
        self.navigationItem.title = "行驶记录"
        
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        
        
        
        
        
        
        
        
        
        //右划
        var swipeGesture = UISwipeGestureRecognizer(target: self, action: "handleSwipeGesture:")
        self.view.addGestureRecognizer(swipeGesture)
        //左划
        var swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: "handleSwipeGesture:")
        swipeLeftGesture.direction = UISwipeGestureRecognizerDirection.Left //不设置是右
        self.view.addGestureRecognizer(swipeLeftGesture)
        
        
        
        
        
    }
    
        
    
    func clear(sender: UIButton){
        
        CommonUtil.transitionWithType(kCATransitionReveal, withSubType: kCATransitionFromBottom, forView: self.view.window!)
        
        self.navigationController?.popViewControllerAnimated(false)
        
    }
    
    var isfirstCalendarSelect = true
    
    override func viewDidAppear(animated: Bool) {
        if(isfirstCalendarSelect||calendar?.selectedDate == nil){
            var date:NSDate = NSDate()
            var zone = NSTimeZone.systemTimeZone()
            var interval = NSTimeInterval(zone.secondsFromGMTForDate(date))
            var localDate = date.dateByAddingTimeInterval(interval)

            
         calendar?.selectedDate =  NSDate().fs_dateByIgnoringTimeComponents
        }
        
    
       
        

    }
    
    override func viewWillDisappear(animated: Bool) {
        //calendarview?.removeFromSuperview()
        loading?.dismiss()
    }



    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        
        loading = CommonUtil.alertLoding(self, title: "请稍等...")
        loading?.dismissAfterDelay(12000)
        var yNavBar = self.navigationController!.navigationBar.frame.height
        // yStatusBar indicates the height of the status bar
        var yStatusBar = UIApplication.sharedApplication().statusBarFrame.size.height
        
        self.loading?.frame.origin.y -= yNavBar + yStatusBar
        
        
        CommonUtil.GCDThread({()in
            self.getTranceStatus()
            
            
            }, afterdo: nil)
        calendarviewhide()
        
        if(calendar?.selectedDate == nil){
            setDisplayDate(NSDate())
        }else{
           setDisplayDate(selectDate!)
        }

       
    }
    
    //#TrackTableDegetel
    
    func turnToTrancePlay(startTime: NSTimeInterval, endTime: NSTimeInterval,showStop:Bool) {
        
        
        
        var sb = UIStoryboard(name: "Main", bundle:nil)
        
        var vc = sb.instantiateViewControllerWithIdentifier("trancerepaly") as!  TranceRePlayController
        
        
        vc.hidesBottomBarWhenPushed = true
        vc.startTime = startTime
        
        vc.endTime = endTime
        
        vc.currentDate = datetextLable.text
        
        vc.isShowStop = showStop
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func turnToPreviousDate(){
        
        if(selectDate != nil){
//            selectDate
            
            var date:NSDate = NSDate(timeInterval:-1 * 24 * 60 * 60, sinceDate: selectDate!)
            var zone = NSTimeZone.systemTimeZone()
            var interval = NSTimeInterval(zone.secondsFromGMTForDate(date))
            var localDate = date.dateByAddingTimeInterval(interval)
        
        
            
            calendar?.selectedDate =  localDate
//            setDisplayDate(localDate)
            
            CommonUtil.transitionWithType(kCATransitionMoveIn, withSubType: kCATransitionFromLeft, forView: self.view,time:0.5)
        }
        
    }
    
    func turnToNextDate(){
        
       
        
        if(selectDate != nil){
            if(selectDate!.isToday(selectDate!)){
                  return
             }
            var date = NSDate(timeInterval: 1 * 24 * 60 * 60, sinceDate: selectDate!)
            var zone = NSTimeZone.systemTimeZone()
            var interval = NSTimeInterval(zone.secondsFromGMTForDate(date))
            var localDate = date.dateByAddingTimeInterval(interval)

             calendar?.selectedDate =  localDate
//            setDisplayDate(localDate)
           
            CommonUtil.transitionWithType(kCATransitionMoveIn, withSubType: kCATransitionFromRight, forView: self.view,time:0.5)
        }
    }
    
    func handleSwipeGesture(sender: UISwipeGestureRecognizer){
        //划动的方向
        var direction = sender.direction
        //判断是上下左右
        switch (direction){
        case UISwipeGestureRecognizerDirection.Left:
            
            turnToNextDate()
            
            break
        case UISwipeGestureRecognizerDirection.Right:
           turnToPreviousDate()
            break
        case UISwipeGestureRecognizerDirection.Up:
            println("Up")
            break
        case UISwipeGestureRecognizerDirection.Down:
            println("Down")
            break
        default:
            break;
        }
       
    }
    

}