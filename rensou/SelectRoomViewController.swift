//
//  ViewController.swift
//  rensou
//
//  Created by Yuichi Kobayashi on 2017/05/25.
//  Copyright © 2017年 Yuichi Kobayashi. All rights reserved.
//

import UIKit

class SelectRoomViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    enum RoomType {
        case STUDENT
        case ADULT
        case GIRL
        case OTAKU
        case SECRET
        case _count
        
        static let count = _count.hashValue
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        cell.roomImageView?.image = UIImage(named: "room_student")
        return cell
    }
}

