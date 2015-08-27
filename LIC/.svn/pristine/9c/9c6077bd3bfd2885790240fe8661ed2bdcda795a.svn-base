//
//  AlarmDetailController.swift
//  LIC
//
//  Created by 温红权 on 15/4/7.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class AlarmDetailController :BaseTableController,TableCellDegetle,UIGestureRecognizerDelegate{
    
    
    var type:Int!
    
    
    var eventMessages:[Msg] = []
    var loading:JGProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        CommonUtil.setNavigationControllerBackground(self)
        
        var rightbar = UIBarButtonItem(image: UIImage(named: "barbuttonicon_delete"), style: UIBarButtonItemStyle.Plain, target: self, action: "deleteAll")
        
        rightbar.imageInsets = UIEdgeInsets(top: 0, left: -7, bottom: 0, right: 7)
        

        
        self.navigationItem.setRightBarButtonItem(rightbar, animated: false)
        
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
        
   
        initUI()
        

        self.tableView.allowsSelection = true
        self.tableView.scrollEnabled = true
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
       
        
    }
    
    func setTableviewCellCanSelected(canselect:Bool){
        
        self.tableView.allowsSelection = canselect;
       
    }
    
    var opendCell:[TableCellDetailController] = []
    
    func cellopen(cell: TableCellDetailController) {
        
        if(opendCell.count>0){
          for celltemp in opendCell {
            if celltemp == cell {
            
              continue
            }

            celltemp.Close()
          }
        }
        
        opendCell.removeAll(keepCapacity: false)
        opendCell.append(cell)
    }
    
    
    func cellClose(cell: TableCellDetailController) {

    }

    
    func cellmoveing(cell:TableCellDetailController){
        if(opendCell.count>0){
            for celltemp in opendCell {
                if celltemp == cell {
                    
                    continue
                }
                celltemp.Close()
            }
        }
        
        opendCell.removeAll(keepCapacity: false)
        opendCell.append(cell)
       
    }
    
    func didselectAllCell() {
        if (self.tableView.indexPathForSelectedRow() != nil){
            tableView.deselectRowAtIndexPath(self.tableView.indexPathForSelectedRow()!, animated: false)
        }
    }
    
    func backtomain(){
        self.loadings?.dismissAnimated(false)
        self.loadings?.dismiss()
        
        CommonUtil.transitionWithType(kCATransitionReveal, withSubType: kCATransitionFromBottom, forView: self.view.window!)
        
        self.navigationController?.popToRootViewControllerAnimated(false)
    }
    
    var loadings:JGProgressHUD?
    var hasnoread:Bool = false
    func deleteData(){
        
        EventService.sharedEventService.RemoveMsgsByType({(data)in
            
            if(data["status"].int == StatusCode.SystemSC.SYSTEM_OK){
            
                self.loadings =  CommonUtil.alertSuccess(self.navigationController!.view!,title:"成功")
                
                self.loadings?.dismissAfterDelay(1200)
                
                NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("backtomain"), userInfo: nil, repeats: false)

            
            }}, errorHandler: {(data)in
        
        }, type: self.type!)
        
    
//        GpsService.sharedGpsService.DELETEEbickEVENTByTAPE({(data)in
//            
//            if(data["status"].int == StatusCode.SystemSC.SYSTEM_OK){
//                
//                self.loadings =  CommonUtil.alertSuccess(self.navigationController!.view!,title:"成功")
//                
//                self.loadings?.dismissAfterDelay(1200)
//                
//                NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("backtomain"), userInfo: nil, repeats: false)
//            }
//            
//            
//            }, errorHandler: {(data)in}, userId: Cache.USER.id, category: category!)
        

    }
    
    
    func deleteAll(){
        
        if(self.hasnoread){
            
            CommonUtil.alertView(self, title: "当前有未读消息，确认清空所有消息？", message: "", buttons: [AlertHandler(title: "取消", handle: {}),AlertHandler(title: "确定", handle: {
                self.deleteData()
               
            })])

            
            
        
        }else{
                CommonUtil.alertView(self, title: "确认清空所有消息？", message: "", buttons: [AlertHandler(title: "取消", handle: {}),AlertHandler(title: "确定", handle: {
                
                self.deleteData()
                })])
        
        }
        
        
        
        
    
    }
    
    
    var messagePageTemp:EventMessagePage!
    
    func getMsgByType(paged:Int){
       
        if(paged == 0){
            
            EventService.sharedEventService.GetMsgsByType({(data)in
            
                  if(data["status"].int == StatusCode.SystemSC.SYSTEM_OK){
                
                    if(data["data"].dictionaryObject == nil){
                       self.navigationController?.popViewControllerAnimated(true)
                       return
                    }
                    
                    var messagePage:EventMessagePage? = Mapper<EventMessagePage>().map(data["data"].dictionaryObject!)
                    
                    if(messagePage?.objs.count > 0){
                        
                       self.messagePageTemp = messagePage!
                       self.eventMessages = self.messagePageTemp!.objs
                       self.tableView.reloadData()
                        
                        if(messagePage!.totalPage == messagePage!.paged){
                            self.tableView.removeFooter()
                        }else{
                            self.tableView.addLegendFooterWithRefreshingBlock({()->Void in
                                self.getMsgByType(self.messagePageTemp!.paged! + 1)
                                
                            })
                        
                        }
                        
                      
                    
                    }else{
                    
                        self.messagePageTemp = nil
                        self.eventMessages = []
                        
                        self.navigationController?.popViewControllerAnimated(true)

                    
                    }

                  }
            
            
                }, errorHandler: {(data)in
            
            
            }, type: self.type!, paged: 1, pagesize: 10)
            
            
        }else{
            
            EventService.sharedEventService.GetMsgsByType({(data)in
                
                if(data["status"].int == StatusCode.SystemSC.SYSTEM_OK){
                    
                    var messagePage:EventMessagePage? = Mapper<EventMessagePage>().map(data["data"].dictionaryObject!)
                    
                    if(self.messagePageTemp?.objs.count > 0){
                        //有数据  渲染
                        self.messagePageTemp = messagePage
                        self.eventMessages += self.messagePageTemp.objs
                        self.tableView.reloadData()

                        
                        if(messagePage!.totalPage == messagePage!.paged){
                            self.tableView.removeFooter()
                        }else{
                            self.tableView.addLegendFooterWithRefreshingBlock({()->Void in
                                 self.getMsgByType(self.messagePageTemp!.paged! + 1)
                            })
                        }
                        
                    }
                }
                
                }, errorHandler: {(data)in
                    
                }, type: self.type!, paged: paged, pagesize: 10)
        }
        
        
        
        
        
    }

    
        
        
    func refreshTable(){
        
        if(opendCell.count>0){
            for celltemp in opendCell {
                if(celltemp.OpenState){
                    celltemp.Close()
                }
                
            }
        }
        
        getMsgByType(0)
        
    
        
        self.tableView.allowsSelection = true
        self.tableView.scrollEnabled = true
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None


    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
   
    
    override func viewWillAppear(animated: Bool) {
        
       super.viewWillAppear(animated)
        
        disableNetWork = true
        if(BaseString.NetWorkEnable){
            networkEnable()
        }else{
            networkDisable()
        }
       refreshTable()
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        CommonUtil.GCDThread({()->Void in
            
            EventService.sharedEventService.ReadMsgsByType({(data) in
                
                }, errorHandler: {(data) in
                    
                }, type: self.type!)
            
            return
            }, afterdo: nil )
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  eventMessages.count
    }


    func getPicName(category:Int) -> String {

        switch(category){
        case StatusCode.MSG_CATEGORY_WEATHER_XY:
            return "MSG_CATEGORY_WEATHER_XY"
        case StatusCode.MSG_CATEGORY_WEATHER_ZY:
            return "MSG_CATEGORY_WEATHER_ZY"
        case StatusCode.MSG_CATEGORY_WEATHER_DY:
            return "MSG_CATEGORY_WEATHER_TDBY"
        case StatusCode.MSG_CATEGORY_WEATHER_BY:
            return "MSG_CATEGORY_WEATHER_TDBY"
        case StatusCode.MSG_CATEGORY_WEATHER_DBY:
            return "MSG_CATEGORY_WEATHER_TDBY"
        case StatusCode.MSG_CATEGORY_WEATHER_TDBY:
            return "MSG_CATEGORY_WEATHER_TDBY"
        case StatusCode.MSG_CATEGORY_WEATHER_SD:
            return "MSG_CATEGORY_WEATHER_SD"
        case StatusCode.MSG_CATEGORY_WEATHER_DF56:
            return "MSG_CATEGORY_WEATHER_DF56"
        case StatusCode.MSG_CATEGORY_WEATHER_DF78:
            return "MSG_CATEGORY_WEATHER_DF78"
        case StatusCode.MSG_CATEGORY_WEATHER_DF8:
            return "MSG_CATEGORY_WEATHER_DF8"
        case StatusCode.MSG_CATEGORY_WEATHER_WSZS152:
            return "MSG_CATEGORY_WEATHER_WSZS152"
        case StatusCode.MSG_CATEGORY_WEATHER_WSZS23:
            return "MSG_CATEGORY_WEATHER_WSZS23"
        case StatusCode.MSG_CATEGORY_WEATHER_WSZS300:
            return "MSG_CATEGORY_WEATHER_WSZS300"
        case StatusCode.MSG_CATEGORY_WEATHER_XX:
            return "MSG_CATEGORY_WEATHER_XX"
        case StatusCode.MSG_CATEGORY_WEATHER_ZX:
            return "MSG_CATEGORY_WEATHER_ZX"
        case StatusCode.MSG_CATEGORY_WEATHER_DX:
            return "MSG_CATEGORY_WEATHER_DX"
        case StatusCode.MSG_CATEGORY_WEATHER_BX:
            return "MSG_CATEGORY_WEATHER_DX"
        case StatusCode.MSG_CATEGORY_WEATHER_DBX:
                return "MSG_CATEGORY_WEATHER_DX"
        case StatusCode.MSG_CATEGORY_WEATHER_TDBX:
                return "MSG_CATEGORY_WEATHER_DX"
        default:
            return "weather"
        
        }
    
    
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("detialcells") as! TableCellDetailController
        cell.titlelable.text = eventMessages[indexPath.row].categoryValue
        cell.detaillable.text = CommonUtil.StringLimt(16,string:eventMessages[indexPath.row].categoryDes)
        cell.timelable.text = CommonUtil.formatDate(eventMessages[indexPath.row].insertTime)
        
        if(type == StatusCode.MSG_MOVE ){
  
            cell.images.image = UIImage(named: "movealarm")
            
        }
        
        if(type == StatusCode.MSG_OUTAGE ){
            cell.images.image = UIImage(named: "power_out")
        }
        

        if(type == StatusCode.MSG_WEATER ){
            
                       
           cell.images.image = UIImage(named: getPicName(eventMessages[indexPath.row].category))

            
        }

        
        
        

        if( eventMessages[indexPath.row].readFlag == 0 ){
            self.hasnoread = true
            cell.contentView.backgroundColor =  CommonUtil.UIColorFromRGB(0xecf2ff);
            cell.bgview.backgroundColor =  CommonUtil.UIColorFromRGB(0xecf2ff);
        }else{
            cell.contentView.backgroundColor =  CommonUtil.UIColorFromRGB(0xffffff);
            cell.bgview.backgroundColor =  CommonUtil.UIColorFromRGB(0xffffff);
        }
        var view = UIView(frame: CGRectMake(10, 0, cell.frame.size.width-10, 0.4))
        view.backgroundColor = CommonUtil.UIColorFromRGB(0xd9d9d9);
     
        cell.addSubview(view)
        
        cell.deletehandler = {() in
           
            CommonUtil.GCDThread( {() -> Void in

                 EventService.sharedEventService.RemoveMsgsById({(data) in
                
                    if(data["status"].int == StatusCode.SystemSC.SYSTEM_OK){
                        CommonUtil.GCDThread({()->Void in
                            
                             self.refreshTable()
                            
                            }, afterdo: nil)
                    }
                
                    }, errorHandler: {(data) in
                        
                        
                        
                }, type: self.type, id: Int(self.eventMessages[indexPath.row].id))
                
                return
                }, afterdo: nil)
            
            return
            
        }


         cell.degetle = self
        
//        cell.selectionStyle = UITableViewCellSelectionStyle.Default;
        return cell
        
    }
    
    
 

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        CommonUtil.GCDThread({()->Void in
//            
//            EventService.sharedEventService.ReadEventByUserId({(data) in
//                
//                
//                
//                }, errorHandler: {(data) in
//                    
//                    
//                    
//                }, userId: Cache.USER.id.description, eventId: self.eventMessages[indexPath.row].id.description)
//            
//            return
//            }, afterdo: nil )
        
        if(type == StatusCode.MSG_WEATER){
            var sb = UIStoryboard(name: "Main", bundle:nil)
            
            var vc = sb.instantiateViewControllerWithIdentifier("weatherTableViewController") as!  WeatherTableViewController
            
            vc.message = self.eventMessages[indexPath.row]
            
            vc.hidesBottomBarWhenPushed = true
            
            
            self.navigationController?.pushViewController(vc, animated: true)
        
            return
        }
        
        
        var sb = UIStoryboard(name: "Main", bundle:nil)
        
        var vc = sb.instantiateViewControllerWithIdentifier("alarmmap") as!  AlarmMapController
        
        vc.message = self.eventMessages[indexPath.row]
        
        vc.hidesBottomBarWhenPushed = true
        
        
        self.navigationController?.pushViewController(vc, animated: true)
        

        
        
        
        
    }
    
    
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 65
        
    }
    
    
    
    func initUI(){
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
         self.navigationItem.title = "消息详情"

        if(type == StatusCode.MSG_OUTAGE ){
              self.navigationItem.title = "设备断电"
        }
        if(type == StatusCode.MSG_MOVE ){
              self.navigationItem.title = "异常移动"
        }
        if(type == StatusCode.MSG_WEATER ){
            self.navigationItem.title = "天气提醒"
        }
        
        
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
        
        
        
        
        var tapGesture = UITapGestureRecognizer(target: self, action: "tapGesture:")
        tapGesture.delegate = self
        self.tableView.addGestureRecognizer(tapGesture)
        
        
        
    }
    
    
    func tapGesture(gesture:UITapGestureRecognizer){
    
        
 
    }
    
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {

        var touchClassName = NSStringFromClass(touch.view.classForCoder)
       
        if(touchClassName == "UITableView" || touchClassName == "UIView"){
            if(opendCell.count>0){
                for celltemp in opendCell {
                    if(celltemp.OpenState){
                         celltemp.Close()
                    }

                }
            }
        
        }
        
        var state = false
        
        for celltemp in opendCell {
            
            if(celltemp.OpenState){
                
                state = true
                break;
            }
        }
        if(state){
            
            return true
        }
        


        return false
    }
    
    
    
    
    
}