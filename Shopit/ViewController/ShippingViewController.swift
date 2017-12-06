//
//  ShippingViewController.swift
//  Shopit
//
//  Created by mobile on 23/10/17.
//  Copyright © 2017 Shopit. All rights reserved.
//

import UIKit

class ShippingViewController: UIViewController {
    @IBOutlet weak var viewNav: UIView!
    @IBOutlet weak var tfFName: UITextField!
    @IBOutlet weak var tfLName: UITextField!
    @IBOutlet weak var tfAddress1: UITextField!
    @IBOutlet weak var tfAddress2: UITextField!
    @IBOutlet weak var tfMobileNum: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var viewCity: UIView!
    @IBOutlet weak var viewCountry: UIView!
    @IBOutlet weak var tfCity: UITextField!
    @IBOutlet weak var tfCountry: UITextField!
    @IBOutlet weak var scrShippingVC: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavBar()
        setUI()
        
        //keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setNavBar() {
        self.navigationController?.navigationBar.isHidden = true
        self.viewNav.backgroundColor = UIColor(hex: "#4A148C")
        
        //status bar color
        UIApplication.shared.statusBarStyle = .lightContent
        UINavigationBar.appearance().clipsToBounds = true
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = UIColor(hex: "#42127E")
    }
    
    func setUI() {
        tfFName.layer.cornerRadius = tfFName.frame.size.height / 2
        tfFName.clipsToBounds = true
        tfFName.layer.borderWidth = 1
        tfFName.layer.borderColor = UIColor(hex: "#B4B8C8")?.cgColor
        tfLName.layer.cornerRadius = tfLName.frame.size.height / 2
        tfLName.clipsToBounds = true
        tfLName.layer.borderWidth = 1
        tfLName.layer.borderColor = UIColor(hex: "#B4B8C8")?.cgColor
        tfAddress1.layer.cornerRadius = tfAddress1.frame.size.height / 2
        tfAddress1.clipsToBounds = true
        tfAddress1.layer.borderWidth = 1
        tfAddress1.layer.borderColor = UIColor(hex: "#B4B8C8")?.cgColor
        tfAddress2.layer.cornerRadius = tfAddress2.frame.size.height / 2
        tfAddress2.clipsToBounds = true
        tfAddress2.layer.borderWidth = 1
        tfAddress2.layer.borderColor = UIColor(hex: "#B4B8C8")?.cgColor
        tfMobileNum.layer.cornerRadius = tfMobileNum.frame.size.height / 2
        tfMobileNum.clipsToBounds = true
        tfMobileNum.layer.borderWidth = 1
        tfMobileNum.layer.borderColor = UIColor(hex: "#B4B8C8")?.cgColor
        viewCity.layer.cornerRadius = viewCity.frame.size.height / 2
        viewCity.clipsToBounds = true
        viewCity.layer.borderWidth = 1
        viewCity.layer.borderColor = UIColor(hex: "#B4B8C8")?.cgColor
        tfCity.borderStyle = .none
        viewCountry.layer.cornerRadius = viewCountry.frame.size.height / 2
        viewCountry.clipsToBounds = true
        viewCountry.layer.borderWidth = 1
        viewCountry.layer.borderColor = UIColor(hex: "#B4B8C8")?.cgColor
        tfCountry.borderStyle = .none
        btnSave.layer.cornerRadius = btnSave.frame.size.height / 2
        btnSave.clipsToBounds = true
    }
    @IBAction func isTappedBtnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return false to ignore.
    {
        dismissKeyboard()
        return true
    }
    
    //MARK: - CustomFunc
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top:0.0, left:0.0, bottom:keyboardSize.height, right:0.0)
            scrShippingVC.contentInset = contentInsets
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrShippingVC.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
