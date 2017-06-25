//
//  ViewController.swift
//  rensou
//
//  Created by Yuichi Kobayashi on 2017/05/25.
//  Copyright © 2017年 Yuichi Kobayashi. All rights reserved.
//

import UIKit
import GoogleMobileAds

class SelectRoomViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var gadBannerView: GADBannerView!
    
    var selectedRoomType: RoomType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = UIImageView(image:UIImage(named:"select_room_title"))
        initBannerView();
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let color = UIColor(hex: "23ac0e")
        self.navigationController?.navigationBar.barTintColor = color
        self.navigationController?.navigationBar.tintColor = color
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RoomType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell", for: indexPath) as! RoomCell
        
        let roomType = RoomType.cases[indexPath.row]
        cell.roomImageView?.image = UIImage(named: roomType.imageName())
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRoomType = RoomType.cases[indexPath.row]
        performSegue(withIdentifier: "selectRoom",sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination  as! QuestionViewController
        viewController.roomType = selectedRoomType
    }
}

