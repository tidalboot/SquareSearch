//
//  AppDelegate.swift
//  SquareSearch
//
//  Created by Nick Jones on 15/09/2017.
//  Copyright © 2017 NickJones. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //Rather than using Storyboards we set up a base view controller here to allow us to develop the app purely in code
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = Search()
        window?.makeKeyAndVisible()
        
        return true
    }
}

