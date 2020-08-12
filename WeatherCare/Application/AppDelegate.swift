//
//  AppDelegate.swift
//  WeatherCare
//
//  Created by Vladislav Dyakov on 12.08.2020.
//  Copyright © 2020 Vladislav Dyakov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let launcher = MainViewController()
        let navigator = UINavigationController(rootViewController: launcher)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigator
        window?.makeKeyAndVisible()
        
        return true
    }
}

