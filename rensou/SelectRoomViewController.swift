//
//  ViewController.swift
//  rensou
//
//  Created by Yuichi Kobayashi on 2017/05/25.
//  Copyright © 2017年 Yuichi Kobayashi. All rights reserved.
//

import UIKit

class SelectRoomViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = UIImageView(image:UIImage(named:"select_room_title"))
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
        
        let room = RoomType.cases[indexPath.row]
        cell.roomImageView?.image = UIImage(named: room.imageName())
        
        return cell
    }
}

