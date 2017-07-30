//
//  RensouUtil.swift
//  rensou
//
//  Created by Yuichi Kobayashi on 2017/07/23.
//  Copyright © 2017年 Yuichi Kobayashi. All rights reserved.
//

import UIKit

class RensouUtil {
    
    class func makeRensouAtributtedString(_ rensou: Rensou) -> NSAttributedString {
        let output = NSMutableAttributedString.init()
        
        let oldRensou = RensouUtil.makeRedBoldString(rensou.oldKeyword, fontSize: 15)
        let newRensou = RensouUtil.makeRedBoldString(rensou.keyword, fontSize: 15)
        let tsunagi = RensouUtil.makeAttributedString(" といえば ", fontSize: 10)
        
        output.append(oldRensou)
        output.append(tsunagi)
        output.append(newRensou)
        return output
    }
    
    class func makeAttributedString(_ string: String!, fontSize: CGFloat) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: string)
        let range = (string as NSString).range(of: string)
        attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: fontSize), range: range)
        return attributedString
    }
    
    class func makeRedBoldString(_ string: String!, fontSize: CGFloat) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: string)
        let range = (string as NSString).range(of: string)
        attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.boldSystemFont(ofSize: fontSize), range: range)
        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: range)
        return attributedString
    }
}
