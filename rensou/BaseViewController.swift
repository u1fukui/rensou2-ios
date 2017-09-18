//
//  BaseViewController.swift
//  rensou
//
//  Created by Yuichi Kobayashi on 2017/09/10.
//  Copyright © 2017年 Yuichi Kobayashi. All rights reserved.
//

import UIKit
import GoogleMobileAds

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomBackButton()
    }
    
    private func setupCustomBackButton() {
        navigationController!.navigationBar.topItem!.title = ""
    }
    
    func setupBannerView(_ gadBannerView: GADBannerView) {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        gadBannerView.adUnitID = appDelegate.getConfigValue(key: "AD_UNIT_ID_FOR_BANNER") as? String
        gadBannerView.rootViewController = self
            
        let request = GADRequest()
        #if arch(i386) || arch(x86_64)
            request.testDevices = [kGADSimulatorID]
        #endif
        gadBannerView.load(request)
    }
}
