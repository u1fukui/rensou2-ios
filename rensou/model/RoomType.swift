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
    
    func id() -> Int {
        switch self {
        case .STUDENT:
            return 1
        case .ADULT:
            return 2
        case .GIRL:
            return 3
        case .OTAKU:
            return 4
        case .SECRET:
            return 5
        }
    }
    
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
    
    func primaryColor() -> String {
        switch self {
        case .STUDENT:
            return "00adef"
        case .ADULT:
            return "23ac0e"
        case .GIRL:
            return "f40783"
        case .OTAKU:
            return "ffaa00"
        case .SECRET:
            return "894891"
        }
    }
    
    func backgroundColor() -> String {
        switch self {
        case .STUDENT:
            return "9ed7e2"
        case .ADULT:
            return "a6e39d"
        case .GIRL:
            return "ffcce5"
        case .OTAKU:
            return "fff2b2"
        case .SECRET:
            return "e5b2ff"
        }
    }
    
    func likeButtonImageName() -> String {
        switch self {
        case .STUDENT:
            return "button_like_on_student"
        case .ADULT:
            return "button_like_on_adult"
        case .GIRL:
            return "button_like_on_girl"
        case .OTAKU:
            return "button_like_on_otaku"
        case .SECRET:
            return "button_like_on_secret"
        }
    }
}
