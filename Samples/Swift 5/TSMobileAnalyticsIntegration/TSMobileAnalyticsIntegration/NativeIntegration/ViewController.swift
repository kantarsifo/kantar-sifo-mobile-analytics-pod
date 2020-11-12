//
//  ViewController.swift
//  TSMobileAnalyticsIntegration
//
//  Created by Mohammad Najafi on 02/01/17.
//  Copyright © 2017 TNS Sifo AB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        TSMobileAnalytics.sendTag(withCategories: ["category-testios"],
                                  contentID: "123-contentID") { (success, error) in
            if let tError = error {
                // Handle error.
                print("Error: \(tError.localizedDescription)")
            }
        }
    }
    
    @IBAction func sendTag(_ sender: AnyObject) {
        TSMobileAnalytics.sendTag(withCategories: ["category-testios"],
                                  contentID: "123-contentID") { (success, error) in
            if let tError = error {
                // Handle error.
                print("Error: \(tError.localizedDescription)")
            }
        }
    }
}

