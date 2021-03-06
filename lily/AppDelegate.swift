//
//  AppDelegate.swift
//  lily
//
//  Created by Nathan Chan on 9/11/17.
//  Copyright © 2017 Nathan Chan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var rootViewController: UITabBarController!
    var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        rootViewController = UITabBarController()
        
        appCoordinator = AppCoordinator(tabBarController: rootViewController)
        appCoordinator.start()
        
        window?.makeKeyAndVisible()
        
        window?.rootViewController = rootViewController
        
        return true
    }
}

