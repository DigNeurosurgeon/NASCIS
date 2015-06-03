//
//  AppDelegate.swift
//  NASCIS
//
//  Created by Pieter Kubben on 23-04-15.
//  Copyright (c) 2015 DigitalNeurosurgeon.com. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window?.tintColor = UIColor.orangeColor()
        return true
    }


}

