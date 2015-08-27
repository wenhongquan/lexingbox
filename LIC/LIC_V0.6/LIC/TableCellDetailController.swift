//
//  TableCellDetailController.swift
//  LIC
//
//  Created by 温红权 on 15/4/7.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

protocol TableCellDegetle{
   
    func setTableviewCellCanSelected(canselect:Bool) ->Void
    
    func cellopen(cell:TableCellDetailController) -> Void
    
    func cellmoveing(cell:TableCellDetailController) -> Void

    func cellClose(cell:TableCellDetailController)  -> Void
    
    func didselectAllCell() -> Void
    
    
}

typealias DELETEBUTTONHANDLER = () -> Void


class TableCellDetailController:UITableViewCell{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        originalCenter = bgview.frame.origin
        self.deletebuttin.hidden = true
        
        self.selectionStyle = UITableViewCellSelectionStyle.Default

    }

    @IBOutlet weak var deletebuttin: UIButton!
    @IBOutlet weak var timelable: UILabel!
    @IBOutlet weak var images: UIImageView!
    @IBOutlet weak var titlelable: UILabel!
    @IBOutlet weak var detaillable: UILabel!

    @IBOutlet weak var bgview: UIView!
    
    var degetle:TableCellDegetle!
    
    var deletehandler:DELETEBUTTONHANDLER?
    
    var OpenState=false;
    
    
    
    func Close(){
        
        OpenState = false
        deleteOnDragRelease = true
        backtooriginalCenter();

    
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
     required init(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
        
        var recognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        
        recognizer.delegate = self
        addGestureRecognizer(recognizer)

        
    }

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
               // add a pan recognizer
        

    }

 

    @IBAction func deleteClick(sender: AnyObject) {
        
        
         deletehandler?()
//        println("我被点击了")
        
        
    }
    

    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    



    var originalCenter = CGPoint()
    var deleteOnDragRelease = false
    

    var bgNextOriginal = CGPoint()
    
    
    func backtooriginalCenter(){

        
        self.degetle.cellClose(self)
            
       
        
//         println("-----------------*****************************9999999999")
        
        UIView.animateWithDuration(0.4, animations: {
            
            self.bgview.frame.origin = self.originalCenter
            
              NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: Selector("hiddbutton"), userInfo: nil, repeats: false)
            
             })
        
        
    
    }
    
    func hiddbutton(){
//        println("-----------------*****************************11111111111111")
        self.bgNextOriginal = self.originalCenter
        self.degetle.setTableviewCellCanSelected(true)
        self.deletebuttin.hidden = true
        self.selected = false
        self.selectionStyle = UITableViewCellSelectionStyle.Default
        
        
    }
    func showbutton(){
//        println("-----------------*****************************222222222222")
        
        self.degetle.setTableviewCellCanSelected(false)
        self.deletebuttin.hidden = false
        self.selected = false
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        OpenState = true
    }
    
    
    
    
    //MARK: - horizontal pan gesture methods
    func handlePan(recognizer: UIPanGestureRecognizer) {
        
        
        // 1
        if recognizer.state == .Began {
//            deleteButton.hidden = false
           
            
            if(self.bgNextOriginal != self.originalCenter ){
                
                Close()
                
                return
            }
            
//             println("我要开始滑动了")
//            var outputFormat = NSDateFormatter()
//            
//            //格式化规则
//            outputFormat.dateFormat = "MM-dd HH:mm:ss.SSS"
//            //定义时区
//            outputFormat.locale = NSLocale(localeIdentifier: "shanghai")
//            
//            
//            println(outputFormat.stringFromDate(NSDate()))
//            
//         //   degetle.didselectAllCell()
//            println("-----------------")
            deleteOnDragRelease = false
            self.showbutton()
           
        }
        // 2
        if recognizer.state == .Changed {
            
            if(deleteOnDragRelease){
              return
            }
            self.showbutton()
            self.degetle.cellmoveing(self)
            
            let translation = recognizer.translationInView(self)

            
            if (translation.x > -90 && translation.x < 30 ){
                self.bgNextOriginal = CGPointMake(self.originalCenter.x + translation.x, self.originalCenter.y)
                 self.bgview.frame.origin =  self.bgNextOriginal
            }else{
                if(translation.x < -90){
                     self.bgNextOriginal = CGPointMake(self.originalCenter.x + -90, self.originalCenter.y)
                     self.bgview.frame.origin =  self.bgNextOriginal
    
                }else{
                    
                    self.bgNextOriginal = CGPointMake(self.originalCenter.x + 30, self.originalCenter.y)
                    self.bgview.frame.origin =  self.bgNextOriginal

                }
            
            }
            

        }
        // 3
        if recognizer.state == .Ended {
//            println("end")
            if(deleteOnDragRelease){
                deleteOnDragRelease=false
                return
            }
            
            

            // the frame this cell had before user dragged it
            let originalFrame = CGRect(x: 0, y: frame.origin.y,
                width: bounds.size.width, height: bounds.size.height)
            
            let translation = recognizer.translationInView(self)
            
            if(translation.x < -90){
                UIView.animateWithDuration(0.2, animations: {
                    
                    self.bgNextOriginal = CGPointMake(self.originalCenter.x - 68, self.originalCenter.y)
                    self.bgview.frame.origin =  self.bgNextOriginal
                     self.showbutton()
                    self.degetle.cellopen(self)
                })
            }else{
                if(translation.x > 30){
                    
                    UIView.animateWithDuration(0.2, animations: {
                        self.bgNextOriginal = CGPointMake(self.originalCenter.x - 20, self.originalCenter.y)
                        self.bgview.frame.origin =  self.bgNextOriginal
                    })
                   self.Close()
                }else{
                    if(translation.x < -20){
                        
                        UIView.animateWithDuration(0.4, animations: {
                            self.bgNextOriginal = CGPointMake(self.originalCenter.x - 68, self.originalCenter.y)
                            self.bgview.frame.origin =  self.bgNextOriginal
                             self.showbutton()
                            self.degetle.cellopen(self)
                        })
                        
                    }else{
                        
                         self.Close()
                    }
                }
                
            }
            
        }
    }
    
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = panGestureRecognizer.translationInView(superview!)
            if fabs(translation.x) > fabs(translation.y) {
                return true
            }
            return false
        }
        return false
 
    }

    
    
}