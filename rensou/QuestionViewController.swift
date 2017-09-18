//
//  QuestionViewController.swift
//  rensou
//
//  Created by Yuichi Kobayashi on 2017/06/04.
//  Copyright © 2017年 Yuichi Kobayashi. All rights reserved.
//

import UIKit
import APIKit
import GoogleMobileAds
import SVProgressHUD

class QuestionViewController: BaseViewController, UITextFieldDelegate {
 
    @IBOutlet weak var themeLabel: UILabel!

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var inputViewsContainer: UIStackView!
    
    @IBOutlet weak var gadBannerView: GADBannerView!
    
    var roomType: RoomType?
    
    var themeRensou: Rensou?
    
    var resultRensous: [Rensou]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationBar()
        initInputViews()
        setupBannerView(gadBannerView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let roomType = roomType {
            initRoomTypeTheme(roomType)
        }
        addKeyboardObserver()
        fetchThemeRensou()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardObserver()
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Initialization methods
    
    func initNavigationBar() {
        self.navigationItem.titleView = UIImageView(image:UIImage(named:"question_title"))
        
        let image = UIImage(named: "navigation_info")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.plain, target: self, action: #selector(QuestionViewController.onTapInfoButton))
    }
    
    func initInputViews() {
        submitButton.isEnabled = false
        textField.delegate = self
    }
    
    func initRoomTypeTheme(_ roomType: RoomType) {
        let primaryColor = UIColor(hex: roomType.primaryColor())
        self.navigationController?.navigationBar.barTintColor = primaryColor
        self.navigationController?.navigationBar.tintColor = primaryColor
        
        self.view.backgroundColor = UIColor(hex: roomType.backgroundColor())
        
        submitButton.backgroundColor = UIColor(hex: roomType.primaryColor())
    }
    
    // MARK: - UITextFieldDelegate
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text as NSString!).replacingCharacters(in: range, with: string)
        submitButton.isEnabled = !text.isEmpty
        return true;
    }
    
    // MARK: - Navigation
    
    @objc func onTapInfoButton() {
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "info")
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    // MARK: - Click Event
    
    @IBAction func onClickSubmitButton(_ sender: Any) {
        postRensou(keyword: textField.text!)
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
    
    @objc func keyboardWillShow(notification: Notification?) {
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
    
    @objc func keyboardWillHide(notification: Notification?) {
        let duration: TimeInterval? = notification?.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? Double
        UIView.animate(withDuration: duration!, animations: { () in
            self.view.transform = CGAffineTransform.identity
        })
    }
    
    // MARK: - API
    
    func fetchThemeRensou() {
        SVProgressHUD.show()
        inputViewsContainer.isHidden = true
        
        Session.send(RensouAPI.GetThemeRensou(roomType: roomType!)) { result in
            switch result {
            case .success(let response):
                SVProgressHUD.dismiss()
                
                self.themeRensou = response
                self.themeLabel.text = response.keyword
                self.inputViewsContainer.isHidden = false
            case .failure(let error):
                SVProgressHUD.dismiss()
                ApiErrorHandler.showErrorAlert(alertType: ApiErrorHandler.AlertType.RELOAD,
                                               viewController: self,
                                               error: error,
                                               reloadAction: {(action: UIAlertAction) in
                    self.fetchThemeRensou()
                })
            }
        }
    }
    
    func postRensou(keyword: String) {
        let userId = DataSaveHelper.sharedInstance.loadUserId();
        
        SVProgressHUD.show()
        Session.send(RensouAPI.PostRensouRequest(userId: userId!,
                                                 roomType: roomType!,
                                                 themeId: themeRensou!.rensouId,
                                                 keyword: keyword)) { result in
            switch result {
            case .success(let response):
                SVProgressHUD.dismiss()
                
                self.textField.text = ""
                self.resultRensous = response
                self.performSegue(withIdentifier: "submitRensou",sender: nil)
            case .failure(let error):
                SVProgressHUD.dismiss()
                ApiErrorHandler.showErrorAlert(alertType: ApiErrorHandler.AlertType.OK,
                                               viewController: self,
                                               error: error,
                                               reloadAction: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! ResultViewController
        viewController.roomType = roomType
        viewController.rensous = resultRensous!
    }
}
