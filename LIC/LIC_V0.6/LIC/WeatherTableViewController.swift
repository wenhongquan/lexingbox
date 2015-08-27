//
//  WeatherTableViewController.swift
//  LIC
//
//  Created by 温红权 on 15/5/14.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

class WeatherTableViewController: BaseTableController
{
    var message:Msg!
    
    
    var notices:[Notice] = []
    var questions:[Article] = []
    
    @IBOutlet weak var headView: UIView!
    @IBOutlet weak var weatherPic: UIImageView!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var weatherTextLable: UILabel!
    @IBOutlet weak var weatherTemperature: UILabel!
    @IBOutlet weak var evaluateImage: UIImageView!
    @IBOutlet weak var evaluateTitle: UILabel!
    @IBOutlet weak var evaluateText: UILabel!
    @IBOutlet weak var weatherDesTextLable: UILabel!
    
    @IBOutlet weak var weatherWidth: NSLayoutConstraint!
    @IBOutlet weak var evaluateWidth: NSLayoutConstraint!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        questions = message.articles
        
        
        notices = []
        
        
        
        
        weatherDesTextLable.text = message.msgDetails.des
        
        if(message.msgDetails.dangerIndex<=3){
           evaluateImage.image = UIImage(named: "normal")
           evaluateText.text = "（一般）"
        }
        if(message.msgDetails.dangerIndex==4){
            evaluateImage.image = UIImage(named: "more")
            evaluateText.text = "（严重）"
        }
        if(message.msgDetails.dangerIndex==5){
            evaluateImage.image = UIImage(named: "hard")
            evaluateText.text = "（恶劣）"
        }
        
        
        
        
        weatherTemperature.text = message.msgDetails.temperature
        
        
        switch(message.category){
        case StatusCode.MSG_CATEGORY_WEATHER_XY:
            notices.append(getNotices(0))
            notices.append(getNotices(1))
            notices.append(getNotices(2))
            bgImageView.image = UIImage(named: "WEATHER_XY")
            weatherPic.image = UIImage(named: "MSG_CATEGORY_WEATHER_XY_BG")
            weatherTextLable.text = message.msgDetails.weather
            
            
            break
        case StatusCode.MSG_CATEGORY_WEATHER_ZY:
            notices.append(getNotices(0))
            notices.append(getNotices(1))
            notices.append(getNotices(2))
            bgImageView.image = UIImage(named: "WEATHER_XY")
            weatherPic.image = UIImage(named: "MSG_CATEGORY_WEATHER_ZY_BG")
            weatherTextLable.text = message.msgDetails.weather
            
            break
        case StatusCode.MSG_CATEGORY_WEATHER_DY:
            notices.append(getNotices(0))
            notices.append(getNotices(1))
            notices.append(getNotices(2))
            bgImageView.image = UIImage(named: "WEATHER_XY")
             weatherPic.image = UIImage(named: "MSG_CATEGORY_WEATHER_DY_BG")
            weatherTextLable.text = message.msgDetails.weather
            
            break
        case StatusCode.MSG_CATEGORY_WEATHER_BY:
            notices.append(getNotices(0))
            notices.append(getNotices(1))
            notices.append(getNotices(2))
            bgImageView.image = UIImage(named: "WEATHER_XY")
            weatherPic.image = UIImage(named: "MSG_CATEGORY_WEATHER_DY_BG")
            weatherTextLable.text = message.msgDetails.weather
            
            break
        case StatusCode.MSG_CATEGORY_WEATHER_DBY:
            notices.append(getNotices(0))
            notices.append(getNotices(1))
            notices.append(getNotices(2))
            bgImageView.image = UIImage(named: "WEATHER_XY")
            weatherPic.image = UIImage(named: "MSG_CATEGORY_WEATHER_DY_BG")
            weatherTextLable.text = message.msgDetails.weather
            
            break
        case StatusCode.MSG_CATEGORY_WEATHER_TDBY:
            notices.append(getNotices(0))
            notices.append(getNotices(1))
            notices.append(getNotices(2))
            bgImageView.image = UIImage(named: "WEATHER_XY")
            weatherPic.image = UIImage(named: "MSG_CATEGORY_WEATHER_DY_BG")
            weatherTextLable.text = message.msgDetails.weather
            
            break
        case StatusCode.MSG_CATEGORY_WEATHER_SD:
            notices.append(getNotices(0))
            notices.append(getNotices(1))
            notices.append(getNotices(3))
            bgImageView.image = UIImage(named: "WEATHER_SD")
            weatherPic.image = UIImage(named: "MSG_CATEGORY_WEATHER_SD_BG")
            weatherTextLable.text = message.msgDetails.weather
            
            break
        case StatusCode.MSG_CATEGORY_WEATHER_DF56:
            notices.append(getNotices(1))
            notices.append(getNotices(4))
            bgImageView.image = UIImage(named: "WEATHER_DF")
            weatherPic.image = UIImage(named: "MSG_CATEGORY_WEATHER_DF56_BG")
            weatherTextLable.text = message.msgDetails.windstemp
            

            break
        case StatusCode.MSG_CATEGORY_WEATHER_DF78:
            notices.append(getNotices(1))
            notices.append(getNotices(4))
            bgImageView.image = UIImage(named: "WEATHER_DF")
            weatherPic.image = UIImage(named: "MSG_CATEGORY_WEATHER_DF78_BG")
             weatherTextLable.text = message.msgDetails.windstemp
            
            break
        case StatusCode.MSG_CATEGORY_WEATHER_DF8:
            notices.append(getNotices(1))
            notices.append(getNotices(4))
            bgImageView.image = UIImage(named: "WEATHER_DF")
            weatherPic.image = UIImage(named: "MSG_CATEGORY_WEATHER_DF8_BG")
             weatherTextLable.text = message.msgDetails.windstemp
            
            break
        case StatusCode.MSG_CATEGORY_WEATHER_WSZS152:
            notices.append(getNotices(4))
            notices.append(getNotices(5))
            bgImageView.image = UIImage(named: "WEATHER_WSZS")
            weatherPic.image = UIImage(named: "MSG_CATEGORY_WEATHER_WSZS152_BG")
             weatherTextLable.text = message.msgDetails.pm25
            
            break
        case StatusCode.MSG_CATEGORY_WEATHER_WSZS23:
            notices.append(getNotices(4))
            notices.append(getNotices(5))
            bgImageView.image = UIImage(named: "WEATHER_WSZS")
            weatherPic.image = UIImage(named: "MSG_CATEGORY_WEATHER_WSZS23_BG")
            weatherTextLable.text = message.msgDetails.pm25
            
            break
        case StatusCode.MSG_CATEGORY_WEATHER_WSZS300:
            notices.append(getNotices(4))
            notices.append(getNotices(5))
            bgImageView.image = UIImage(named: "WEATHER_WSZS")
            weatherPic.image = UIImage(named: "MSG_CATEGORY_WEATHER_WSZS300_BG")
            weatherTextLable.text = message.msgDetails.pm25
            
            break
        case StatusCode.MSG_CATEGORY_WEATHER_XX:
            notices.append(getNotices(0))
            notices.append(getNotices(1))
            notices.append(getNotices(3))
            bgImageView.image = UIImage(named: "WEATHER_XX")
            weatherPic.image = UIImage(named: "MSG_CATEGORY_WEATHER_XX_BG")
            weatherTextLable.text = message.msgDetails.weather

            break
        case StatusCode.MSG_CATEGORY_WEATHER_ZX:
            notices.append(getNotices(0))
            notices.append(getNotices(1))
            notices.append(getNotices(3))
            bgImageView.image = UIImage(named: "WEATHER_XX")
            weatherPic.image = UIImage(named: "MSG_CATEGORY_WEATHER_ZX_BG")
            weatherTextLable.text = message.msgDetails.weather

            break
        case StatusCode.MSG_CATEGORY_WEATHER_DX:
            notices.append(getNotices(0))
            notices.append(getNotices(1))
            notices.append(getNotices(3))
            bgImageView.image = UIImage(named: "WEATHER_XX")
            weatherPic.image = UIImage(named: "MSG_CATEGORY_WEATHER_DX_BG")
            weatherTextLable.text = message.msgDetails.weather

            break
        case StatusCode.MSG_CATEGORY_WEATHER_BX:
            notices.append(getNotices(0))
            notices.append(getNotices(1))
            notices.append(getNotices(3))
            bgImageView.image = UIImage(named: "WEATHER_XX")
            weatherPic.image = UIImage(named: "MSG_CATEGORY_WEATHER_DX_BG")
            weatherTextLable.text = message.msgDetails.weather

            break
        case StatusCode.MSG_CATEGORY_WEATHER_DBX:
            notices.append(getNotices(0))
            notices.append(getNotices(1))
            notices.append(getNotices(3))
            bgImageView.image = UIImage(named: "WEATHER_XX")
            weatherPic.image = UIImage(named: "MSG_CATEGORY_WEATHER_DX_BG")
            weatherTextLable.text = message.msgDetails.weather

            break
        case StatusCode.MSG_CATEGORY_WEATHER_TDBX:
            notices.append(getNotices(0))
            notices.append(getNotices(1))
            notices.append(getNotices(3))
            bgImageView.image = UIImage(named: "WEATHER_XX")
            weatherPic.image = UIImage(named: "MSG_CATEGORY_WEATHER_DX_BG")
            weatherTextLable.text = message.msgDetails.weather

            break
        default:
            break
        }
 
 
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
          disableNetWork = true
        if(BaseString.NetWorkEnable){
            networkEnable()
        }else{
            networkDisable()
        }
    }
    
    
    override func networkEnable() {
        super.networkEnable()
        
        
        headView.frame.origin.y = 44
        
    }
    
    
    override func viewDidLayoutSubviews() {

        
        weatherWidth.constant = weatherTextLable.frame.width + weatherTemperature.frame.width + 15
        

        
        evaluateWidth.constant = evaluateTitle.frame.width + evaluateText.frame.width + evaluateImage.image!.size.width

    }
    
    func getNotices(index:Int) -> Notice {
    
        var notice = Notice()
        
        switch(index){
        
        case 0:
            notice.picName = "luntai"
            notice.title = "检查轮胎是否打滑"
            notice.des = "检查轮胎表面花纹是否磨尽，可提前更换有排水花纹的轮胎"
            return notice
        case 1:
            notice.picName = "shache"
            notice.title = "检查刹车是否可靠"
            notice.des = "将刹车握至最紧，用力推动电动车，验证刹车可靠性"
            return notice
        case 2:
            notice.picName = "deng"
            notice.title = "确认灯光齐全"
            notice.des = "检查前灯与后灯的正常开关"
            return notice
        case 3:
            notice.picName = "zhuanwan"
            notice.title = "请以超低速转弯"
            notice.des = "过弯时降低车速，并使用脚部辅助支撑"
            return notice
        case 4:
            notice.picName = "fengsha"
            notice.title = "防止风沙进入眼睛"
            notice.des = "购买合适的防风眼镜或佩戴头盔出行"
            return notice
        case 5:
            notice.picName = "kouzhao"
            notice.title = "减少直接呼吸污染空气"
            notice.des = "佩戴较厚的或专业的PM2.5口罩出行"
            return notice
            
        default:
            return notice

        }
        
        
    
    }
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section){
        case 0:
            return notices.count;
        case 1:
            return questions.count;
        default:
            break;
        }
        return 0;
    }

    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var header = ""
        
        switch(section){
        case 0:
            header =  "注意事项";
            
            var headerView = UIView(frame: CGRectMake(0, 0, tableView.bounds.size.width, 28))
            
            var headlable:UILabel = UILabel()
            headlable.frame = CGRectMake(16, 16,300, 28);
            headlable.backgroundColor = UIColor.clearColor()
            
            headlable.textColor = CommonUtil.UIColorFromRGB(0x008EDC);
            
            headlable.font = UIFont.systemFontOfSize(14)
            
            headlable.text = header
            
            
            headerView.backgroundColor = CommonUtil.UIColorFromRGB(0xefeff4)
            
            headerView.addSubview(headlable)

            
            return headerView;
            
            
        default:
            break;
        }
        
        
        return nil;
        
        
    }

    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch(section){
        case 0:
            return 40;
        default:
            break;
        }
        return 0;
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch(indexPath.section){
        case 0:
            var cell = tableView.dequeueReusableCellWithIdentifier("weatherNoticeTableCell") as! WeatherNoticeTableCell
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.noticePic.image = UIImage(named: self.notices[indexPath.row].picName!)
            cell.noticeTitle.text = self.notices[indexPath.row].title
            cell.noticeDes.text = self.notices[indexPath.row].des
            
            return cell
        case 1:
            var cell = tableView.dequeueReusableCellWithIdentifier("questionTableCell") as! QuestionTableCell
            
            cell.desLable.text = questions[indexPath.row].title
            
            return cell
            
        default:
            break;
        }
        var cell = tableView.dequeueReusableCellWithIdentifier("questionTableCell") as! QuestionTableCell
        
        
        return cell
        
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        switch(indexPath.section){
        case 0:
             return 130
        case 1:
             return 44
            
        default:
            break;
        }

        return 44
    }


    
    
    func initUI(){
    
        headView.bringSubviewToFront(weatherPic)
        headView.bringSubviewToFront(weatherTextLable)
        headView.bringSubviewToFront(weatherTemperature)
        headView.bringSubviewToFront(evaluateImage)
        headView.bringSubviewToFront(evaluateText)
        headView.bringSubviewToFront(evaluateTitle)
        headView.bringSubviewToFront(weatherDesTextLable)
        
        tableView.separatorStyle=UITableViewCellSeparatorStyle.None;
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        
        self.navigationItem.title = "消息详情"
        
        self.navigationController?.navigationBar.tintColor=UIColor.whiteColor()
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
       
        if(indexPath.section == 1){
        
            CommonUtil.backToWebView(self, name: "webviewcontroller", title: "问题", url: questions[indexPath.row].url)
        }
        
        
        
        
        
    }
    
}