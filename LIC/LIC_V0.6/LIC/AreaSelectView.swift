//
//  AreaSelectView.swift
//  LIC
//
//  Created by 温红权 on 15/5/29.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import Foundation

typealias AreaSelected = (province:String,city:String,area:String,addr:String) -> Void
typealias AreaUnSelected = () -> Void

class AreaSelectView:UIView,UIPickerViewDataSource,UIPickerViewDelegate{

    @IBOutlet weak var areaPicker: UIPickerView!
    
    @IBOutlet weak var confirmButton: UIButton!
    //data
    var pickerDic:NSDictionary?
    var provinceArray:NSArray?
    var cityArray:NSArray?
    var townArray:NSArray?
    var selectedArray:NSArray?
    
    var selecdAction:AreaSelected?
    var clearAction:AreaUnSelected?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.alpha = 1
        self.backgroundColor = CommonUtil.UIColorFromRGBA(0x000000, alpha: 0.4)
        
        getPickerData()
        areaPicker.delegate = self
        areaPicker.dataSource = self
        
        confirmButton=CommonUtil.buttonSetImage(confirmButton,name:"greenbigbtn1",states:[UIControlState.Selected,UIControlState.Normal,UIControlState.Highlighted,UIControlState.Disabled])

    }
    
    
//    #pragma mark - get data
    func getPickerData() {
    
        var path:String! = NSBundle.mainBundle().pathForResource("Address", ofType: "plist")

//        var data = NSArray(contentsOfFile: path)
        
        self.pickerDic =  NSDictionary(contentsOfFile: path)
        
        var temp:[String]? = self.pickerDic?.allKeys as? [String]
        if(temp?.count > 0){
            temp?.sort({ (s1:String, s2:String) -> Bool in
                //获取key index
                var arry1 = s1.componentsSeparatedByString(" ")
                var index1: String = arry1[0]
                var arry2 = s2.componentsSeparatedByString(" ")
                var index2: String = arry2[0]
                return index1 < index2
            })
        }
        
        
        self.provinceArray = temp
        self.selectedArray = self.pickerDic?.objectForKey(self.provinceArray![0]) as? NSArray
    
        if (self.selectedArray?.count > 0) {
            self.cityArray = self.selectedArray?.objectAtIndex(0).allKeys
         }
    
        if (self.cityArray?.count > 0) {
            self.townArray =  self.selectedArray!.objectAtIndex(0).objectForKey(self.cityArray?.objectAtIndex(0)) as? NSArray
        }
        self.areaPicker.reloadAllComponents()
    
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (component == 0) {
            return self.provinceArray!.count;
        } else if (component == 1) {
            return self.cityArray!.count;
        } else {
            return self.townArray!.count;
        }
    }
 
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        var string:String = ""
        if (component == 0) {
            string = self.provinceArray!.objectAtIndex(row) as! String;
            var arry1 = string.componentsSeparatedByString(" ")
            string = arry1[1]
            
            
        } else if (component == 1) {
            string = self.cityArray!.objectAtIndex(row) as! String;
        } else {
            string = self.townArray!.objectAtIndex(row) as! String;
        }
        var uilable = UILabel()
        uilable.textAlignment = NSTextAlignment.Center
        
        if(string as NSString).length > 4 && (string as NSString).length <= 8  {
        
           uilable.font = UIFont.systemFontOfSize(10)
        }
        if(string as NSString).length > 8  {
            
            uilable.font = UIFont.systemFontOfSize(8)
        }
        
        
        uilable.text = string
        return uilable
        
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if (component == 0) {
            return 110;
        } else if (component == 1) {
            return 100;
        } else {
            return 110;
        }
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (component == 0) {
            self.selectedArray = self.pickerDic!.objectForKey(self.provinceArray!.objectAtIndex(row)) as? NSArray
            
            if (self.selectedArray?.count > 0) {
                self.cityArray = self.selectedArray?.objectAtIndex(0).allKeys
            } else {
                self.cityArray = nil;
            }
            if (self.cityArray?.count > 0) {
                self.townArray = self.selectedArray!.objectAtIndex(0).objectForKey(self.cityArray!.objectAtIndex(0)) as? NSArray
            } else {
                self.townArray = nil;
            }
        }
        pickerView.selectedRowInComponent(1)
        pickerView.reloadComponent(1)
        pickerView.selectedRowInComponent(2)
 
        
        if (component == 1) {
            if (self.selectedArray?.count > 0 && self.cityArray?.count > 0){
                self.townArray = self.selectedArray!.objectAtIndex(0).objectForKey(self.cityArray!.objectAtIndex(row)) as? NSArray
            } else {
                self.townArray = nil;
            }
            
            pickerView.selectRow(1, inComponent: 2, animated: true)

        }
        
       pickerView.reloadComponent(2)
        
    }
    
    
    
    func hide() {
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
             self.alpha = 0;
            
        }) { (finshed) -> Void in
            self.removeFromSuperview()
        }
    }
    
   
    @IBAction func confirmButtonAction(sender: AnyObject) {
        hide()
        var province:String! = self.provinceArray!.objectAtIndex(self.areaPicker.selectedRowInComponent(0)) as! String
        var arry1 = province.componentsSeparatedByString(" ")
        province = arry1[1]
        
        var city:String! = self.cityArray!.objectAtIndex(self.areaPicker.selectedRowInComponent(1)) as! String
        
        var town:String! = self.townArray!.objectAtIndex(self.areaPicker.selectedRowInComponent(2)) as! String
        var string:String = ""
        
        if(province == city){
        
            if(city == town){
               string = town
            }else{
               string = city + " " + town
            }
        }else{
            if(city == town){
                string = province + " " + town
            }else{
                string = province + " "  + city + " " + town
            }
        }
        string = CommonUtil.StringLimt(11, string: string)
        
        selecdAction?(province: province,city:city,area:town,addr:string)
        

    }
    @IBAction func clearButtonAction(sender: AnyObject) {
        hide()
        clearAction?()
    }
}