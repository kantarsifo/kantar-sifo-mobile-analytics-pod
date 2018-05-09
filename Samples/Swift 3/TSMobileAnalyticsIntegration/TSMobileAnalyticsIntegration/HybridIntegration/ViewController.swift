//
//  ViewController.swift
//  TSMobileAnalyticsIntegration
//
//  Created by Mohammad Najafi on 02/01/17.
//  Copyright © 2017 TNS Sifo AB. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let urlArray = ["https://google.com/", "http://expressen.se/", "https://mobil.dn.se/"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.urlArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "urlCell")
        
        if cell == nil {
           cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "urlCell")
        }
        
        cell?.textLabel?.text = self.urlArray[indexPath.row]
        
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC = WebViewController()
        let request = URLRequest(url: URL(string: self.urlArray[indexPath.row])!)
        webVC.request = request
        
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    
}

