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
    
    private static let KEY_REPORTED_RENSOU_IDS = "key.reported_rensou_ids"
    
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
    
    func isReportedRensou(_ rensou: Rensou) -> Bool {
        if UserDefaults.standard.object(forKey: DataSaveHelper.KEY_REPORTED_RENSOU_IDS) == nil {
            return false
        }
        let ids = UserDefaults.standard.array(forKey: DataSaveHelper.KEY_REPORTED_RENSOU_IDS) as! [Int];
        for id in ids {
            if id == rensou.rensouId {
                return true
            }
        }
        return false
    }
    
    func setReportedRensou(_ rensou: Rensou) {
        let key = DataSaveHelper.KEY_REPORTED_RENSOU_IDS
        if UserDefaults.standard.object(forKey: key) == nil {
             UserDefaults.standard.set([rensou.rensouId], forKey: key)
        } else {
            var ids = UserDefaults.standard.array(forKey: key) as! [Int];
            ids.append(rensou.rensouId)
            UserDefaults.standard.set(ids, forKey: key)
        }
        UserDefaults.standard.synchronize()
    }
}
