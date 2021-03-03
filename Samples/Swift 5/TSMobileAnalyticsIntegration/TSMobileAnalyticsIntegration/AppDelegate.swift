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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.green
        self.window?.rootViewController = UINavigationController(rootViewController: ViewController())
        self.window?.makeKeyAndVisible()
        
        //Initiate TSMobileAnalytics
        
        TSMobileAnalytics.setLogPrintsActivated(true)
        TSMobileAnalytics.initialize(withCPID: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                                     applicationName: "Sample app",
                                     trackingType: .TrackUsersAndPanelists,
                                     enableSystemIdentifierTracking: false,
                                     isWebViewBased: true,
                                     keychainAccessGroup: "mo.dyna.TSMobileAnalyticsIntegration",
                                     additionals: nil)
        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return TSMobileAnalytics.application(app, open: url, options: options)
    }
}

