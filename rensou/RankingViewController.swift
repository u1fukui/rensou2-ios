//
//  RankingViewController.swift
//  rensou
//
//  Created by Yuichi Kobayashi on 2017/07/16.
//  Copyright © 2017年 Yuichi Kobayashi. All rights reserved.
//

import UIKit
import GoogleMobileAds

class RankingViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var gadBannerView: GADBannerView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        initBannerView()
        initTableView()
    }

    func initNavigationBar() {
        self.navigationItem.titleView = UIImageView(image:UIImage(named:"ranking_title"))
    }
    
    func initBannerView() {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        gadBannerView.adUnitID = appDelegate.getConfigValue(key: "AD_UNIT_ID_FOR_BANNER") as? String
        gadBannerView.rootViewController = self
        
        
        let request = GADRequest()
        if TARGET_OS_SIMULATOR == 1 {
            request.testDevices = [kGADSimulatorID]
        }
        gadBannerView.load(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initTableView() {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rankingRensouCell", for: indexPath) as! RankingRensouCell
        
        let rensou = Rensou.init()
        rensou.likeCount = 100
        rensou.oldKeyword = "ばなな"
        rensou.keyword = "きいろ"
        cell.setRensou(rensou: rensou, rank: indexPath.row + 1)
        
        return cell
    }
}
