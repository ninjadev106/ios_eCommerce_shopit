//
//  PersonalDataViewController.swift
//  Shopit
//
//  Created by mobile on 22/10/17.
//  Copyright © 2017 Shopit. All rights reserved.
//

import UIKit

class PersonalDataViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPass: UITextField!
    @IBOutlet weak var tfNewPass: UITextField!
    @IBOutlet weak var tfRenewPass: UITextField!
    @IBOutlet weak var viewCountry: UIView!
    @IBOutlet weak var tfCountry: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var scrPerData: UIScrollView!
    @IBOutlet weak var viewNav: UIView!
    @IBOutlet weak var ivProfile: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //set UI
        setUI()
        setNavBar()
        
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
    
    override func viewWillLayoutSubviews() {
        ivProfile.layer.cornerRadius = ivProfile.frame.size.height / 2
        ivProfile.clipsToBounds = true
        ivProfile.layer.borderWidth = 2.0
        ivProfile.layer.borderColor = UIColor.white.cgColor
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
        tfUserName.layer.cornerRadius = tfUserName.frame.size.height / 2
        tfUserName.clipsToBounds = true
        tfUserName.layer.borderWidth = 1
        tfUserName.layer.borderColor = UIColor(hex: "#B4B8C8")?.cgColor
        tfEmail.layer.cornerRadius = tfEmail.frame.size.height / 2
        tfEmail.clipsToBounds = true
        tfEmail.layer.borderWidth = 1
        tfEmail.layer.borderColor = UIColor(hex: "#B4B8C8")?.cgColor
        tfPass.layer.cornerRadius = tfPass.frame.size.height / 2
        tfPass.clipsToBounds = true
        tfPass.layer.borderWidth = 1
        tfPass.layer.borderColor = UIColor(hex: "#B4B8C8")?.cgColor
        tfNewPass.layer.cornerRadius = tfNewPass.frame.size.height / 2
        tfNewPass.clipsToBounds = true
        tfNewPass.layer.borderWidth = 1
        tfNewPass.layer.borderColor = UIColor(hex: "#B4B8C8")?.cgColor
        tfRenewPass.layer.cornerRadius = tfRenewPass.frame.size.height / 2
        tfRenewPass.clipsToBounds = true
        tfRenewPass.layer.borderWidth = 1
        tfRenewPass.layer.borderColor = UIColor(hex: "#B4B8C8")?.cgColor
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == tfUserName {
            tfUserName.text = textField.text
        } else if textField == tfEmail {
            tfEmail.text = textField.text
        } else if textField == tfPass {
            tfPass.text = textField.text
        } else if textField == tfNewPass {
            tfNewPass.text = textField.text
        } else if textField == tfRenewPass {
            tfRenewPass.text = textField.text
        }
    }
    
    //MARK: - CustomFunc
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top:0.0, left:0.0, bottom:keyboardSize.height, right:0.0)
            scrPerData.contentInset = contentInsets
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrPerData.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    @IBAction func onBtnSave(_ sender: Any) {
        
        guard (tfUserName.text?.characters.count)! >= 2 else {
            m_sharedManager.showOKAlert(vc: self, title: "Input Error", message: "Username must be at least 2 characters")
            return
        }
        guard (tfEmail.text?.characters.count)! >= 1 || m_sharedManager.isValidEmailAddress(emailAddressString: tfEmail.text!) else {
            m_sharedManager.showOKAlert(vc: self, title: "Input Error", message: "Please check your email")
            return
        }
        guard (tfPass.text?.characters.count)! >= 6 else {
            m_sharedManager.showOKAlert(vc: self, title: "Input Error", message: "Please enter at least 6 passwords")
            return
        }
        guard (tfNewPass.text?.characters.count)! >= 6 else {
            m_sharedManager.showOKAlert(vc: self, title: "Input Error", message: "Please enter at least 6 passwords")
            return
        }
        guard (tfRenewPass.text?.characters.count)! >= 6 || (tfRenewPass.text?.isEqual(tfNewPass.text))! else {
            m_sharedManager.showOKAlert(vc: self, title: "Input Error", message: "Please check your input")
            return
        }
        
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
