//
//  QuestionViewController.swift
//  rensou
//
//  Created by Yuichi Kobayashi on 2017/06/04.
//  Copyright © 2017年 Yuichi Kobayashi. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
 
    @IBOutlet weak var themeLabel: UILabel!

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    var roomType: RoomType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        themeLabel.text = "バナナ"
        self.navigationItem.titleView = UIImageView(image:UIImage(named:"question_title"))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let roomType = roomType {
            initRoomTypeTheme(roomType)
        }
        addKeyboardObserver()
    }
    
    func initRoomTypeTheme(_ roomType: RoomType) {
        let primaryColor = UIColor(hex: roomType.primaryColor())
        self.navigationController?.navigationBar.barTintColor = primaryColor
        self.navigationController?.navigationBar.tintColor = primaryColor
        
        self.view.backgroundColor = UIColor(hex: roomType.backgroundColor())
        
        submitButton.backgroundColor = UIColor(hex: roomType.primaryColor())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardObserver()
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Keyboard detection
    
    func addKeyboardObserver() {
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func removeKeyboardObserver() {
        let notification = NotificationCenter.default
        notification.removeObserver(self)
    }
    
    func keyboardWillShow(notification: Notification?) {
        let rect = (notification?.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        
        let superView = textField.superview
        if let superView = superView {
            let margin: CGFloat = 10.0
            let convertedFrame = superView.convert(textField.frame, to: self.view)
            let diff = (self.view.frame.height - (rect?.height)!) - (convertedFrame.maxY + margin)
            
            if diff < 0 {
                let duration: TimeInterval? = notification?.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double
                UIView.animate(withDuration: duration!, animations: { () in
                    let transform = CGAffineTransform(translationX: 0, y: diff)
                    self.view.transform = transform
                })
            }
        }
    }
    
    func keyboardWillHide(notification: Notification?) {
        let duration: TimeInterval? = notification?.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? Double
        UIView.animate(withDuration: duration!, animations: { () in
            self.view.transform = CGAffineTransform.identity
        })
    }
}
