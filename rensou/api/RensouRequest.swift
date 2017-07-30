//
//  RensouRequest.swift
//  rensou
//
//  Created by Yuichi Kobayashi on 2017/07/30.
//  Copyright © 2017年 Yuichi Kobayashi. All rights reserved.
//

import Foundation
import APIKit

protocol RensouRequest: Request {
}

extension RensouRequest {
    var baseURL: URL {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        return URL(string: appDelegate.getConfigValue(key: "API_BASE_URL") as! String)!
    }
}

extension RensouRequest where Response: Decodable {
    var dataParser: DataParser {
        return DecodableDataParser()
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            throw ResponseError.unexpectedObject(object)
        }
        return try JSONDecoder().decode(Response.self, from: data)
    }
}
