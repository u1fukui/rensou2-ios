//
//  RensouApi.swift
//  rensou
//
//  Created by Yuichi Kobayashi on 2017/07/30.
//  Copyright © 2017年 Yuichi Kobayashi. All rights reserved.
//

import Foundation
import APIKit

final class RensouAPI {
    private init() {}
    
    struct ThemeRensou: RensouRequest {
        typealias Response = Rensou
        
        let method: HTTPMethod = .get
        let path: String = "rensou.json"
        var parameters: Any? {
            return ["room": roomType.id()]
        }
        let roomType: RoomType
    }
}
