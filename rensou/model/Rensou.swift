//
//  Rensou.swift
//  rensou
//
//  Created by Yuichi Kobayashi on 2017/07/09.
//  Copyright © 2017年 Yuichi Kobayashi. All rights reserved.
//

import Foundation

struct Rensou: Decodable {
    let rensouId: Int
    
    let likeCount: Int
    
    let keyword: String
    
    let oldKeyword: String
    
    let createdAt: String
    
    private enum CodingKeys: String, CodingKey {
        case rensouId = "id"
        case likeCount = "favorite"
        case keyword
        case oldKeyword = "old_keyword"
        case createdAt = "created_at"
    }
}
