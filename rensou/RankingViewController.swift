//
//  RankingViewController.swift
//  rensou
//
//  Created by Yuichi Kobayashi on 2017/07/16.
//  Copyright © 2017年 Yuichi Kobayashi. All rights reserved.
//

import UIKit

class RankingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
    }

    func initNavigationBar() {
        self.navigationItem.titleView = UIImageView(image:UIImage(named:"ranking_title"))
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

}
