//
//  AppDelegate.swift
//  ZYKeyboard
//
//  Created by leeey on 14/8/31.
//  Copyright (c) 2014年 leeey. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        var view = ViewController()
        self.window!.rootViewController = view
        self.window!.makeKeyAndVisible()
        return true
    }

 

}

