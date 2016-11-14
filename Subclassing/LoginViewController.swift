//
//  LoginViewController.swift
//  Subclassing
//
//  Created by Dinesh Reddy.C on 11/11/16.
//  Copyright © 2016 Vishwak. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        let str =  self.appUtil .getDisplay()
        print(str)
    }
    //MARK: MEMORY WARNING
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}
