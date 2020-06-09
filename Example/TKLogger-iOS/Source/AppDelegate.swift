//
//  AppDelegate.swift
//  TKLogger-iOS
//
//  Created by me@shper.cn on 05/28/2020.
//  Copyright (c) 2020 me@shper.cn. All rights reserved.
//

import UIKit
import TKLogger

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
     static var shared: AppDelegate?

    var window: UIWindow?


    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        AppDelegate.shared = self
        
        TKLogger.setup()
//        TKLogger.addDestination(TKLogDiskDestination())
        TKLogger.addFilter(ExampleLogFilter())
        
        setupBootViewController()
        
        return true
    }
    
    private func setupBootViewController() {
        let navigation = UINavigationController(rootViewController: RootViewController())
        navigation.setNavigationBarHidden(true, animated: false)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()
    }

}

