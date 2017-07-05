//
//  AppDelegate.swift
//  MovieFinder
//
//  Created by Luigi Di Muzio on 22/05/16.
//  Copyright © 2016 dimuz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        customizeAppearance()
        return true
    }
    
    fileprivate func customizeAppearance() {
        let mainColor = UIColor(red: 200/255.0, green: 10/255.0, blue: 60/255.0, alpha: 1.0)
        UISearchBar.appearance().barTintColor = mainColor
        UISearchBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = mainColor
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
    }
    
}

