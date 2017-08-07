//
//  QuestionViewController.swift
//  rensou
//
//  Created by Yuichi Kobayashi on 2017/06/04.
//  Copyright © 2017年 Yuichi Kobayashi. All rights reserved.
//

import UIKit
import GoogleMobileAds
import APIKit

class QuestionViewController: UIViewController {
 
    @IBOutlet weak var themeLabel: UILabel!

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var gadBannerView: GADBannerView!
    
    var roomType: RoomType?
    
    var themeRensou: Rensou?
    
    var resultRensous: [Rensou]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView(image:UIImage(named:"question_title"))
        initBannerView()
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
    
    func initBannerView() {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        gadBannerView.adUnitID = appDelegate.getConfigValue(key: "AD_UNIT_ID_FOR_BANNER") as? String
        gadBannerView.rootViewController = self
        
        let request = GADRequest()
        if TARGET_OS_SIMULATOR == 1 {
            request.testDevices = [kGADSimulatorID]
        }
        gadBannerView.load(request)
    }
    
    func initRoomTypeTheme(_ roomType: RoomType) {
        let primaryColor = UIColor(hex: roomType.primaryColor())
        self.navigationController?.navigationBar.barTintColor = primaryColor
        self.navigationController?.navigationBar.tintColor = primaryColor
        
        self.view.backgroundColor = UIColor(hex: roomType.backgroundColor())
        
        submitButton.backgroundColor = UIColor(hex: roomType.primaryColor())
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
        Session.send(RensouAPI.GetThemeRensou(roomType: roomType!)) { result in
            switch result {
            case .success(let response):
                self.themeRensou = response
                self.themeLabel.text = response.keyword
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func postRensou(keyword: String) {
        let userId = DataSaveHelper.sharedInstance.loadUserId();
        
        Session.send(RensouAPI.PostRensouRequest(userId: userId!,
                                                 roomType: roomType!,
                                                 themeId: themeRensou!.rensouId,
                                                 keyword: keyword)) { result in
            switch result {
            case .success(let response):
                self.resultRensous = response
                self.performSegue(withIdentifier: "submitRensou",sender: nil)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! ResultViewController
        viewController.rensous = resultRensous!
    }
}
