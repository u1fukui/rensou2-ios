//
//  EmptyResponse.swift
//  rensou
//
//  Created by Yuichi Kobayashi on 2017/07/30.
//  Copyright © 2017年 Yuichi Kobayashi. All rights reserved.
//

import Foundation

struct UserRegistrationResponse : Decodable {

    let userId: Int
    
    private enum CodingKeys: String, CodingKey {
        case userId = "user_id"
    }
}
