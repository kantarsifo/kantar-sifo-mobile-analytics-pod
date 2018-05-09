//
//  AppDelegate.swift
//  TSMobileAnalyticsIntegration
//
//  Created by Mohammad Najafi on 02/01/17.
//  Copyright © 2017 TNS Sifo AB. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.green
        self.window?.rootViewController = UINavigationController(rootViewController: ViewController())
        self.window?.makeKeyAndVisible()
        
        //Initiate TSMobileAnalytics
        TSMobileAnalytics.createInstance(withCPID: "2383", applicationName: "mobil.sifo-test", trackPanelist: true, keychainAccessGroup: "mo.dyna.TSMobileAnalyticsIntegration")
        TSMobileAnalytics.setLogPrintsActivated(true)
        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey: Any] = [:]) -> Bool {
        return TSMobileAnalytics.sharedInstance().application(app, open: url, options: options)
    }
    
    // Deprecated by Apple in iOS9:
    // func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
    //     return TSMobileAnalytics.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    // }
}

