//
//  StatusModel.swift
//  NASCIS
//
//  Created by Pieter Kubben on 25-04-15.
//  Copyright (c) 2015 DigitalNeurosurgeon.com. All rights reserved.
//

import Foundation

class StatusModel: NSObject {
    
    let version: String
    let message: String
    let hasIssue: Bool
    //let currentVersion = "0.1"
    let lastDateOfLocalSave: NSDate
    
    init(version: String?, message: String?, issueValue: Int?) {
        self.version  = version ?? ""
        self.message  = message ?? ""
        self.hasIssue = (issueValue == 1) ? true : false
        self.lastDateOfLocalSave = NSDate()
    }
    
    class func getCurrentVersion() -> String {
        return "1.0"
    }
    
}