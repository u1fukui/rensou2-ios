//
//  BaseViewController.swift
//  rensou
//
//  Created by Yuichi Kobayashi on 2017/09/10.
//  Copyright © 2017年 Yuichi Kobayashi. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomBackButton()
    }
    
    private func setupCustomBackButton() {
        navigationController!.navigationBar.topItem!.title = ""
    }
}
