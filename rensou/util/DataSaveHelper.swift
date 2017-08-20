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
    
    private static let KEY_LIKED_RENSOU_IDS = "key.liked_rensou_ids"
    
    private static let KEY_REPORTED_RENSOU_IDS = "key.reported_rensou_ids"
    
    // MARK: - User ID
    
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
    
    // MARK: - Like State
    
    func isLikedRensou(_ rensou: Rensou) -> Bool {
        guard
            let array = UserDefaults.standard.array(forKey: DataSaveHelper.KEY_LIKED_RENSOU_IDS),
            array is [Int]
            else {
                return false;
        }
        
        let ids = array as! [Int]
        for id in ids {
            if id == rensou.rensouId {
                return true
            }
        }
        return false
    }
    
    func setLikedRensou(_ rensou: Rensou, isLiked: Bool) {
        var array = UserDefaults.standard.array(forKey: DataSaveHelper.KEY_LIKED_RENSOU_IDS);
        if array == nil {
            array = []
        }
        var ids = array as! [Int]
        if isLiked {
            ids.append(rensou.rensouId)
        } else {
            let index = ids.index(of: rensou.rensouId)
            if let index = index {
                ids.remove(at: index)
            }
        }
        UserDefaults.standard.set(ids, forKey: DataSaveHelper.KEY_LIKED_RENSOU_IDS)
        UserDefaults.standard.synchronize()
    }
    
    // MARK: - Report State
    
    func isReportedRensou(_ rensou: Rensou) -> Bool {
        guard
            let array = UserDefaults.standard.array(forKey: DataSaveHelper.KEY_REPORTED_RENSOU_IDS),
            array is [Int]
            else {
                return false;
        }
        
        let ids = array as! [Int]
        for id in ids {
            if id == rensou.rensouId {
                return true
            }
        }
        return false
    }
    
    func setReportedRensou(_ rensou: Rensou) {
        var ids = UserDefaults.standard.array(forKey: DataSaveHelper.KEY_REPORTED_RENSOU_IDS);
        if ids == nil {
            ids = []
        }
        ids?.append(rensou.rensouId)
        UserDefaults.standard.set(ids, forKey: DataSaveHelper.KEY_REPORTED_RENSOU_IDS)
        UserDefaults.standard.synchronize()
    }
}
