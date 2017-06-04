//
//  RoomType.swift
//  rensou
//
//  Created by Yuichi Kobayashi on 2017/06/04.
//  Copyright © 2017年 Yuichi Kobayashi. All rights reserved.
//

import Foundation

enum RoomType: EnumEnumerable {
    case STUDENT
    case ADULT
    case GIRL
    case OTAKU
    case SECRET
    
    func imageName() -> String {
        switch self {
        case .STUDENT:
            return "room_student"
        case .ADULT:
            return "room_adult"
        case .GIRL:
            return "room_girl"
        case .OTAKU:
            return "room_otaku"
        case .SECRET:
            return "room_secret"
        }
    }
}
