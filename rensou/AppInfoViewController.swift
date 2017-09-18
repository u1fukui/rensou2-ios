//
//  AppInfoViewController.swift
//  rensou
//
//  Created by Yuichi Kobayashi on 2017/08/27.
//  Copyright © 2017年 Yuichi Kobayashi. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AppInfoViewController: BaseViewController {

    @IBOutlet weak var gadBannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        setupBannerView(gadBannerView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initBackgroundColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Initialization
    
    func initBackgroundColor() {
        let roomType = RoomType.ADULT
        let primaryColor = UIColor(hex: roomType.primaryColor())
        self.navigationController?.navigationBar.barTintColor = primaryColor
        self.navigationController?.navigationBar.tintColor = primaryColor
        
        self.view.backgroundColor = UIColor(hex: roomType.backgroundColor())
    }
    
    func initNavigationBar() {
        self.navigationItem.titleView = UIImageView(image:UIImage(named:"info_title"))
    }
    
    // MARK: - Click event
    
    @IBAction func onTouchDownMailButton(_ sender: Any) {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let mailAddress = appDelegate.getConfigValue(key: "SUPPORT_MAIL_ADDRESS") as! String
        let subject = "連想ゲーム".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let url = NSURL.init(string: "mailto:" + mailAddress + "?Subject=" + subject!)
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url! as URL)
        }
    }
}
