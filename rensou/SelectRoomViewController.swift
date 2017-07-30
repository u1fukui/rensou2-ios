//
//  ViewController.swift
//  rensou
//
//  Created by Yuichi Kobayashi on 2017/05/25.
//  Copyright © 2017年 Yuichi Kobayashi. All rights reserved.
//

import UIKit
import APIKit
import GoogleMobileAds

class SelectRoomViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var gadBannerView: GADBannerView!
    
    var selectedRoomType: RoomType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationBar()
        initBannerView()
        
        let userId = DataSaveHelper.sharedInstance.loadUserId()
        if userId == nil {
            showAgreementAlert()
        }
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

    // MARK: - Initialization methods
    
    func initNavigationBar() {
        self.navigationItem.titleView = UIImageView(image:UIImage(named:"select_room_title"))
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
    
    func showAgreementAlert() {
        let alert: UIAlertController = UIAlertController(title: "確認",
                                                         message: "サービスを利用するには以下の内容に同意下さい。\n\n1. 禁止事項\n・個人情報や他の方が不快と感じるような内容は投稿しないで下さい\n\n2. 表示内容について\n・不快と感じる投稿が表示される可能性があります\n・不快な投稿があった場合は通報ボタンを押して下さい",
                                                         preferredStyle:  UIAlertControllerStyle.alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "同意する",
                                                         style: UIAlertActionStyle.default,
                                                         handler: {(action: UIAlertAction!) -> Void in
                                                            self.registerUser()
        })
        alert.addAction(defaultAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func registerUser() {
        Session.send(RensouAPI.RegisterUser()) { result in
            switch result {
            case .success(let response):
                DataSaveHelper.sharedInstance.saveUserId(response.userId)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RoomType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell", for: indexPath) as! RoomCell
        
        let roomType = RoomType.cases[indexPath.row]
        cell.roomImageView?.image = UIImage(named: roomType.imageName())
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRoomType = RoomType.cases[indexPath.row]
        performSegue(withIdentifier: "selectRoom",sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination  as! QuestionViewController
        viewController.roomType = selectedRoomType
    }
}

