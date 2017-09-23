//
//  ResultViewController.swift
//  rensou
//
//  Created by Yuichi Kobayashi on 2017/06/15.
//  Copyright © 2017年 Yuichi Kobayashi. All rights reserved.
//

import UIKit
import APIKit
import SVProgressHUD
import GoogleMobileAds

class ResultViewController: BaseViewController, UITableViewDataSource, ResultRensouCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var gadBannerView: GADBannerView!
    
    var roomType: RoomType?
    
    var rensous: [Rensou]?
    
    var likeStateDictionary = [Int: Bool]()
    
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDateFormatter()
        initNavigationBar()
        initRoomTypeTheme()
        initTableView()
        setupBannerView(gadBannerView)
    }
    
    func initDateFormatter() {
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
    }
    
    func initNavigationBar() {
        self.navigationItem.titleView = UIImageView(image:UIImage(named:"result_title"))
        
        let image = UIImage(named: "navigation_ranking")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.plain, target: self, action: #selector(ResultViewController.tapRankingButton))
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    @objc func tapRankingButton() {
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "ranking")
        if let nextView = nextView as? RankingViewController {
            nextView.roomType = roomType
        }
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! RankingViewController
        viewController.roomType = roomType
    }

    // MARK: - UITableViewDataSource

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
        cell.delegate = self
        cell.setRensou(rensous![indexPath.row], roomType: roomType!, dateFormatter: dateFormatter)
        
        return cell
    }
    
    // MARK: - ResultRensouCellDelegate
    
    func isChangedLikeState(_ rensou: Rensou) -> Bool? {
        return likeStateDictionary[rensou.rensouId]
    }
    
    func onTouchDownLikeButton(cell: ResultRensouCell, rensou: Rensou) {
        if DataSaveHelper.sharedInstance.isLikedRensou(rensou) {
            unlikeRensou(cell: cell, rensou: rensou)
        } else {
            likeRensou(cell: cell, rensou: rensou)
        }
    }
    
    func likeRensou(cell: ResultRensouCell, rensou: Rensou) {
        SVProgressHUD.show()
        Session.send(RensouAPI.LikeRensouRequest(rensouId: rensou.rensouId)) { result in
            switch result {
            case .success( _):
                SVProgressHUD.dismiss()
                self.likeStateDictionary[rensou.rensouId] = self.likeStateDictionary[rensou.rensouId] != true
                
                DataSaveHelper.sharedInstance.setLikedRensou(rensou, isLiked: true)
                let indexPath = self.tableView.indexPath(for: cell)
                if let indexPath = indexPath {
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            case .failure(let error):
                SVProgressHUD.dismiss()
                print(error)
            }
        }
    }
    
    func unlikeRensou(cell: ResultRensouCell, rensou: Rensou) {
        SVProgressHUD.show()
        Session.send(RensouAPI.UnlikeRensouRequest(rensouId: rensou.rensouId)) { result in
            switch result {
            case .success( _):
                SVProgressHUD.dismiss()
                self.likeStateDictionary[rensou.rensouId] = self.likeStateDictionary[rensou.rensouId] != true
                
                DataSaveHelper.sharedInstance.setLikedRensou(rensou, isLiked: false)
                let indexPath = self.tableView.indexPath(for: cell)
                if let indexPath = indexPath {
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            case .failure(let error):
                SVProgressHUD.dismiss()
                print(error)
            }
        }
    }
    
    func onTouchDownReportButton(cell: ResultRensouCell, rensou: Rensou) {
        let alert: UIAlertController = UIAlertController(title: "確認",
                                                         message: "この投稿を通報します。宜しいでしょうか？",
                                                         preferredStyle:  UIAlertControllerStyle.alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "通報する",
                                                         style: UIAlertActionStyle.default,
                                                         handler: {(action: UIAlertAction!) -> Void in
                                                            self.showConfirmBlockUser(cell: cell, rensou: rensou)
        })
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル",
                                                        style: UIAlertActionStyle.cancel,
                                                        handler: nil)
        
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showConfirmBlockUser(cell: ResultRensouCell, rensou: Rensou) {
        let alert: UIAlertController = UIAlertController(title: "確認",
                                                         message: "この投稿をしたユーザをブロックしますか？ブロックすると、このユーザが投稿したもの全てが非表示になります。",
                                                         preferredStyle:  UIAlertControllerStyle.alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "ブロックする",
                                                         style: UIAlertActionStyle.default,
                                                         handler: {(action: UIAlertAction!) -> Void in
                                                            self.reportRensou(cell: cell, rensou: rensou, needUserBlock: true)
        })
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル",
                                                        style: UIAlertActionStyle.cancel,
                                                        handler: {(action: UIAlertAction!) -> Void in
                                                            self.reportRensou(cell: cell, rensou: rensou, needUserBlock: false)
        })
        
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func reportRensou(cell: ResultRensouCell, rensou: Rensou, needUserBlock: Bool) {
        SVProgressHUD.show()
        Session.send(RensouAPI.ReportRensouRequest(rensouId: rensou.rensouId)) { result in
            switch result {
            case .success( _):
                SVProgressHUD.dismiss()
                
                if needUserBlock {
                    DataSaveHelper.sharedInstance.setBlockedUser(rensou.userId)
                    self.tableView.reloadData()
                } else {
                    DataSaveHelper.sharedInstance.setReportedRensou(rensou)
                    let indexPath = self.tableView.indexPath(for: cell)
                    if let indexPath = indexPath {
                        self.tableView.reloadRows(at: [indexPath], with: .automatic)
                    }
                }
            case .failure(let error):
                SVProgressHUD.dismiss()
                ApiErrorHandler.showErrorAlert(alertType: ApiErrorHandler.AlertType.OK,
                                               viewController: self,
                                               error: error,
                                               reloadAction: nil)
            }
        }
    }
}
