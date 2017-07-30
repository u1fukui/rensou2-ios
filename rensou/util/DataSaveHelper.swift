//
//  UserDefaultsUtil.swift
//  rensou
//
//  Created by Yuichi Kobayashi on 2017/07/30.
//  Copyright © 2017年 Yuichi Kobayashi. All rights reserved.
//

import Foundation

class DataSaveHelper {

    static let sharedInstance = DataSaveHelper()

    private static let KEY_USER_ID: String = "key.user_id"
    
    func saveUserId(_ userId: Int) {
        UserDefaults.standard.set(userId, forKey: DataSaveHelper.KEY_USER_ID)
        UserDefaults.standard.synchronize()
    }
    
    func loadUserId() -> Int? {
        if UserDefaults.standard.object(forKey: DataSaveHelper.KEY_USER_ID) == nil {
            return nil
        }
        return UserDefaults.standard.integer(forKey: DataSaveHelper.KEY_USER_ID)
    }
    
    func removeUserId() {
        UserDefaults.standard.removeObject(forKey: DataSaveHelper.KEY_USER_ID)
        UserDefaults.standard.synchronize()
    }
}
