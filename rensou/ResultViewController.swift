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
    
    var rensous: [Rensou]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        initBannerView()
        initTableView()
    }
    
    func initNavigationBar() {
        self.navigationItem.titleView = UIImageView(image:UIImage(named:"result_title"))
        
        let image = UIImage(named: "navigation_ranking")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.plain, target: self, action: #selector(ResultViewController.tapRankingButton))
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
    
    @objc func tapRankingButton() {
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "ranking")
        self.navigationController?.pushViewController(nextView, animated: true)
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
        if rensous == nil {
            return 0
        }
        return rensous!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultRensouCell", for: indexPath) as! ResultRensouCell
        
        if indexPath.row % 2 == 0 {
            cell.setLeftStyle()
        } else {
            cell.setRightStyle()
        }
        cell.setRensou(rensous![indexPath.row])
        
        return cell
    }
}
