//
//  RankingRensouCell.swift
//  rensou
//
//  Created by Yuichi Kobayashi on 2017/07/16.
//  Copyright © 2017年 Yuichi Kobayashi. All rights reserved.
//

import UIKit

class RankingRensouCell: UITableViewCell {

    @IBOutlet weak var rankIcon: UIImageView!
    
    @IBOutlet weak var rensouLabel: UILabel!

    @IBOutlet weak var createdAtLabel: UILabel!

    @IBOutlet weak var likeCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
    }

    func setRensou(rensou: Rensou, rank: Int, dateFormatter: DateFormatter) {
        if DataSaveHelper.sharedInstance.isReportedRensou(rensou) {
            rensouLabel.text = "この投稿は通報済みです"
            likeCountLabel.isHidden = true
        } else if DataSaveHelper.sharedInstance.isBlockedUser(rensou) {
            rensouLabel.text = "ブロックしているユーザの投稿です"
            likeCountLabel.isHidden = true
        } else {
            rankIcon.image = UIImage(named: "rank" + rank.description + "_icon")
            rensouLabel.attributedText = RensouUtil.makeRensouAtributtedString(rensou)
            createdAtLabel.text = dateFormatter.string(from: rensou.createdAt)
            likeCountLabel.text = rensou.likeCount.description + "件"
            likeCountLabel.isHidden = false
        }
    }
}
