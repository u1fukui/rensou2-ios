//
//  ApiErrorHandler.swift
//  rensou
//
//  Created by Yuichi Kobayashi on 2017/08/26.
//  Copyright © 2017年 Yuichi Kobayashi. All rights reserved.
//

import UIKit
import APIKit

struct ApiErrorHandler {

    enum AlertType: EnumEnumerable {
        case OK
        case RELOAD
        case FORCE_RELOAD
    }
    
    static func showErrorAlert(alertType: AlertType,
                               viewController: UIViewController,
                               error: SessionTaskError,
                               reloadAction: ((UIAlertAction) -> Swift.Void)?) {
        
        let alert = UIAlertController(title: "エラー",
                                      message: getErrorMessage(error),
                                      preferredStyle:  UIAlertControllerStyle.alert)
        
        let actionTitle = alertType == AlertType.OK ? "OK" : "再試行"
        alert.addAction(UIAlertAction(title: actionTitle,
                                      style: UIAlertActionStyle.default,
                                      handler: reloadAction))
        
        if alertType == AlertType.RELOAD {
            alert.addAction(UIAlertAction(title: "キャンセル",
                                          style: UIAlertActionStyle.cancel,
                                          handler: nil))
        }
        
        viewController.present(alert, animated: true, completion: nil)
    }
        
    private static func getErrorMessage(_ error: SessionTaskError) -> String {
        switch error {
        case .connectionError(_):
            return "通信が正常に行えませんでした。通信環境の良いところで再度お試しください"
        case .requestError(_):
            return "リクエスト内容に問題があります。すみませんが、リクエスト内容を添えてメールで連絡お願いします..."
        case .responseError(_):
            return "サーバでエラーが発生しました。しばらく時間をおいても直らない場合は、すみませんがメールで連絡お願いします..."
        }
    }
}
