//
//  RankingViewController.swift
//  rensou
//
//  Created by Yuichi Kobayashi on 2017/07/16.
//  Copyright © 2017年 Yuichi Kobayashi. All rights reserved.
//

import UIKit
import APIKit
import GoogleMobileAds
import SVProgressHUD

class RankingViewController: BaseViewController, UITableViewDataSource {

    @IBOutlet weak var gadBannerView: GADBannerView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var roomType: RoomType?
    
    var rensous: [Rensou]?
    
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDateFormatter()
        initNavigationBar()
        initRoomTypeTheme()
        initTableView()
        setupBannerView(gadBannerView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRankingList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Initialization

    func initDateFormatter() {
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
    }
    
    func initNavigationBar() {
        self.navigationItem.titleView = UIImageView(image:UIImage(named:"ranking_title"))
    }
    
    func initRoomTypeTheme() {
        if let roomType = roomType {
            self.view.backgroundColor = UIColor(hex: roomType.backgroundColor())
        }
    }
    
    func initTableView() {
        tableView.backgroundColor = UIColor.clear
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = UIColor(hex: roomType!.backgroundColor())
    }
    
    // MARK: - API
    
    func fetchRankingList() {
        SVProgressHUD.show()
        Session.send(RensouAPI.GetRankingList(roomType: roomType!)) { result in
            switch result {
            case .success(let response):
                SVProgressHUD.dismiss()
                
                self.rensous = response
                self.tableView.reloadData()
            case .failure(let error):
                SVProgressHUD.dismiss()
                ApiErrorHandler.showErrorAlert(alertType: ApiErrorHandler.AlertType.RELOAD,
                                               viewController: self,
                                               error: error,
                                               reloadAction: {(action: UIAlertAction) in
                                                self.fetchRankingList()
                })
            }
        }
    }
    
    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rensous = rensous {
            return rensous.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rankingRensouCell", for: indexPath) as! RankingRensouCell
        cell.setRensou(rensou: rensous![indexPath.row], rank: indexPath.row + 1, dateFormatter: dateFormatter)
        return cell
    }
}
