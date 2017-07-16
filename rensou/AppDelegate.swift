//
//  AppDelegate.swift
//  rensou
//
//  Created by Yuichi Kobayashi on 2017/05/25.
//  Copyright © 2017年 Yuichi Kobayashi. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let configPlistDectionary: NSDictionary?
    
    override init() {
        let path = Bundle.main.path(forResource: "Config", ofType: "plist")
        configPlistDectionary = NSDictionary(contentsOfFile:path!)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        initNavigationBackButton()
        initGad()
        return true
    }
    
    func initNavigationBackButton() {
        let image = UIImage(named: "navigation_back")
        if let image = image {
            UINavigationBar.appearance().backIndicatorImage = image.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            UINavigationBar.appearance().backIndicatorTransitionMaskImage = image.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        }
    }
    
    func initGad() {
        FirebaseApp.configure()
        
        let appId = getConfigValue(key: "AD_APPLICATION_ID") as! String
        GADMobileAds.configure(withApplicationID: appId)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func getConfigValue(key: String) -> Any? {
        return configPlistDectionary?.value(forKey: key)
    }
}

