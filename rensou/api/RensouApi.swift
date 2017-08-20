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
    
    struct RegisterUser: RensouRequest {
        typealias Response = UserRegistrationResponse
        
        let method: HTTPMethod = .post
        let path: String = "user"
        var parameters: Any? {
            return ["device_type": 0]
        }
    }
    
    struct GetThemeRensou: RensouRequest {
        typealias Response = Rensou
        
        let method: HTTPMethod = .get
        let path: String = "rensou.json"
        var parameters: Any? {
            return ["room": roomType.id()]
        }
        let roomType: RoomType
    }
    
    struct PostRensouRequest: RensouRequest {
        typealias Response = [Rensou]
        
        let method: HTTPMethod = .post
        let path: String = "rensou.json"
        var bodyParameters: BodyParameters? {
            return JSONBodyParameters(JSONObject: ["user_id": userId,
                                                   "room": roomType.id(),
                                                   "theme_id": themeId,
                                                   "keyword": keyword])
        }
        
        let userId: Int
        let roomType: RoomType
        let themeId: Int
        let keyword: String
    }
    
    struct ReportRensouRequest: RensouRequest {
        typealias Response = Any // empty
        
        let method: HTTPMethod = .post
        var path: String {
            return String.init(format: "rensous/%d/spam", rensouId)
        }
        let rensouId: Int
        
        func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Any {
            return object
        }
    }
    
    struct LikeRensouRequest: RensouRequest {
        typealias Response = Any // empty
        
        let method: HTTPMethod = .post
        var path: String {
            return String.init(format: "rensous/%d/like", rensouId)
        }
        let rensouId: Int
        
        func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Any {
            return object
        }
    }
    
    struct UnlikeRensouRequest: RensouRequest {
        typealias Response = Any // empty
        
        let method: HTTPMethod = .delete
        var path: String {
            return String.init(format: "rensous/%d/like", rensouId)
        }
        let rensouId: Int
        
        func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Any {
            return object
        }
    }
    
    struct GetRankingList: RensouRequest {
        typealias Response = [Rensou]
        
        let method: HTTPMethod = .get
        let path: String = "rensous/ranking"
        var parameters: Any? {
            return ["room": roomType.id()]
        }
        let roomType: RoomType
    }
}
