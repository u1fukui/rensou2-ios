//
//  ResultRensouCell.swift
//  rensou
//
//  Created by Yuichi Kobayashi on 2017/07/09.
//  Copyright © 2017年 Yuichi Kobayashi. All rights reserved.
//

import UIKit

protocol ResultRensouCellDelegate {
    func onTouchDownReportButton(cell: ResultRensouCell, rensou: Rensou)
}

class ResultRensouCell: UITableViewCell {

    @IBOutlet weak var bgView: UIImageView!
    
    @IBOutlet weak var rensouLabel: UILabel!
    
    @IBOutlet weak var createdAtLabel: UILabel!
    
    @IBOutlet weak var reportButton: UIButton!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var likeCountLabel: UILabel!
    
    @IBOutlet weak var containerViewLeadingConstraint: NSLayoutConstraint!
    
    var delegate: ResultRensouCellDelegate?
    
    var rensou: Rensou?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likeButton.setImage(UIImage(named: "button_like_off"), for: UIControlState.normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLeftStyle() {
        bgView?.image = UIImage(named: "result_rensou_cell_bg1")
        containerViewLeadingConstraint.constant = 0;
    }
    
    func setRightStyle() {
        bgView?.image = UIImage(named: "result_rensou_cell_bg2")
        containerViewLeadingConstraint.constant = 14;
    }

    func setRensou(_ rensou: Rensou, roomType: RoomType, dateFormatter: DateFormatter) {
        self.rensou = rensou
        
        if DataSaveHelper.sharedInstance.isReportedRensou(rensou) {
            rensouLabel.text = "この投稿は通報済みです"
            likeCountLabel.isHidden = true
            likeButton.isHidden = true
            reportButton.isHidden = true
        } else {
            likeButton.setImage(UIImage(named: roomType.likeButtonImageName()), for: UIControlState.selected)
            rensouLabel.attributedText = RensouUtil.makeRensouAtributtedString(rensou)
            createdAtLabel.text = dateFormatter.string(from: rensou.createdAt)
            likeCountLabel.text = rensou.likeCount.description
            likeCountLabel.isHidden = false
            likeButton.isSelected = true
            likeButton.isHidden = false
            reportButton.isHidden = false
        }
    }
    
    @IBAction func onTouchDownReportButton(_ sender: Any) {
        if let delegate = delegate, let rensou = rensou {
            delegate.onTouchDownReportButton(cell: self, rensou: rensou)
        }
    }
}
