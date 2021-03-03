//
//  WebViewController.swift
//  TSMobileAnalyticsIntegration
//
//  Created by Mohammad Najafi on 03/01/17.
//  Copyright © 2017 TNS Sifo AB. All rights reserved.
//

import UIKit
import TSMobileAnalytics

class WebViewController: UIViewController {
    
    var webView = WKWebView()
    
    var request: URLRequest? {
        didSet {
            self.loadWebView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TSMobileAnalytics.addWebview(self.webView)
        self.layoutWebView()
        self.loadWebView()
    }
    
    deinit {
        TSMobileAnalytics.removeWebview(self.webView)
    }

    func loadWebView() {
        if let req = self.request , self.isViewLoaded {
            self.webView.load(req)
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
