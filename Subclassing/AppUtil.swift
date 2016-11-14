//
//  AppUtil.swift
//  Subclassing
//
//  Created by Dinesh Reddy.C on 11/11/16.
//  Copyright © 2016 Vishwak. All rights reserved.
//

import UIKit

class AppUtil: NSObject {
    public let dateFormatter = DateFormatter()
    static let sharedInstance = AppUtil()
   
    func getDisplay() -> String {
        return "first Display"
    }
    func getDisplayTwo() -> String {
            return "second Display"
    }
}
