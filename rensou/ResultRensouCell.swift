//
//  ResultRensouCell.swift
//  rensou
//
//  Created by Yuichi Kobayashi on 2017/07/09.
//  Copyright © 2017年 Yuichi Kobayashi. All rights reserved.
//

import UIKit

class ResultRensouCell: UITableViewCell {

    @IBOutlet weak var bgView: UIImageView!
    
    @IBOutlet weak var rensouLabel: UILabel!
    
    @IBOutlet weak var createdAtLabel: UILabel!
    
    @IBOutlet weak var spamButton: UIButton!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var likeCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        likeButton.setImage(UIImage(named: "button_like_off"), for: UIControlState.normal)
        likeButton.setImage(UIImage(named: "button_like_on"), for: UIControlState.selected)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLeftStyle() {
        bgView?.image = UIImage(named: "result_rensou_cell_bg1")
    }
    
    func setRightStyle() {
        bgView?.image = UIImage(named: "result_rensou_cell_bg2")
    }

    func setRensou(rensou: Rensou) {
        rensouLabel.text = "あいうえおかきくけこ"
    }
}
