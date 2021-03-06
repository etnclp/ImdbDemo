//
//  AppDelegate.swift
//  ImdbDemo
//
//  Created by Erdi Tunçalp on 22.04.2019.
//  Copyright © 2019 Erdi Tunçalp. All rights reserved.
//

import UIKit
import XCGLogger
import IQKeyboardManagerSwift

let log = XCGLogger.default

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        let router = AppCoordinator().anyRouter
        router.setRoot(for: window!)
        
        IQKeyboardManager.shared.enable = true
        
        return true
    }


}

