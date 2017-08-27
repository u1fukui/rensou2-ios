//
//  LicenseViewController.swift
//  rensou
//
//  Created by Yuichi Kobayashi on 2017/08/27.
//  Copyright © 2017年 Yuichi Kobayashi. All rights reserved.
//

import UIKit

class LicenseViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        loadLicenseHtml()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initNavigationBar() {
        self.navigationItem.titleView = UIImageView(image:UIImage(named:"info_title"))
    }
    
    func loadLicenseHtml() {
        let urlpath = Bundle.main.path(forResource: "license", ofType: "html");
        let requesturl = URL(string: urlpath!)
        webView.loadRequest(URLRequest(url: requesturl!))
    }
}
