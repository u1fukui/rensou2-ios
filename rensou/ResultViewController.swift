//
//  ResultViewController.swift
//  rensou
//
//  Created by Yuichi Kobayashi on 2017/06/15.
//  Copyright © 2017年 Yuichi Kobayashi. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ResultViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var gadBannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBannerView()
        initTableView()
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
    
    func initTableView() {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultRensouCell", for: indexPath) as! ResultRensouCell
        
        if (indexPath.row % 2 == 0) {
            cell.setLeftStyle()
        } else {
            cell.setRightStyle()
        }
        
        cell.setRensou(rensou: Rensou.init())
        
        return cell
    }
}
