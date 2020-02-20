//
//  WebViewController.swift
//  TSMobileAnalyticsIntegration
//
//  Created by Mohammad Najafi on 03/01/17.
//  Copyright © 2017 TNS Sifo AB. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    var webView = UIWebView()
    
    var request: URLRequest? {
        didSet {
            self.loadWebView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.layoutWebView()
        self.loadWebView()
    }

    func loadWebView() {
        if let req = self.request , self.isViewLoaded {
            self.webView.loadRequest(req)
        }
    }
    
    func layoutWebView() {
        if self.webView.superview == nil {
            self.view.addSubview(self.webView)
        }
        self.webView.frame = self.view.bounds
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.layoutWebView()
    }
    
}
