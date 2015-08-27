//
//  PasswordSettingTableController.swift
//  LIC
//
//  Created by 温红权 on 15/3/17.
//  Copyright (c) 2015年 &#20048;&#34892;&#22825;&#19979;. All rights reserved.
//

import UIKit

protocol PasswordSettingTableControllerHandlerProtocol{
    func  passwordInputhandler() -> Void
}


class PasswordSettingTableController: BaseTableController {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPass: UITextField!
    @IBOutlet weak var userpassagain: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        userName.text=BaseString.USERPHONE;
//        userPass.becomeFirstResponder()
    }
    
    var passwordtablehandle:PasswordSettingTableControllerHandlerProtocol!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func passwordInput(sender: AnyObject) {
        passwordtablehandle.passwordInputhandler()
        CommonUtil.validateString(userPass.text, limit: 20)
    }
    @IBAction func passwordagaininput(sender: AnyObject) {
        passwordtablehandle.passwordInputhandler()
        CommonUtil.validateString(userpassagain.text, limit: 20)
    }
    override func viewWillAppear(animated: Bool) {
        
        
   }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0){
            return 44
        }else{
            return 10
        }
    }

    
    
    
}
