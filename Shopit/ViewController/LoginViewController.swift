//
//  LoginViewController.swift
//  Shopit
//
//  Created by mobile on 15/10/17.
//  Copyright © 2017 Shopit. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPass: UITextField!
    @IBOutlet weak var svLogin: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up UI
        self.navigationController?.navigationBar.isHidden = true
        
        tfEmail.layer.cornerRadius = tfEmail.frame.size.height / 2
        tfEmail.layer.borderWidth = 1
        tfEmail.clipsToBounds = true
        tfEmail.layer.borderColor = UIColor(hex: "#B4B8C8")?.cgColor
        tfPass.layer.cornerRadius = tfPass.frame.size.height / 2
        tfPass.layer.borderWidth = 1
        tfPass.layer.borderColor = UIColor(hex: "#B4B8C8")?.cgColor
        tfPass.clipsToBounds = true
        
        //status bar
        setStatusBar()
                
        //keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        //test
        tfEmail.text = "aaa@aaa.com"
        tfPass.text = "aaaaaa"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setStatusBar()
    }
    
    func setStatusBar() {
        UIApplication.shared.statusBarStyle = .default
        UINavigationBar.appearance().clipsToBounds = true
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = UIColor.white
    }

    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return false to ignore.
    {
        dismissKeyboard()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == tfEmail {
            tfEmail.text = textField.text
        } else if textField == tfPass {
            tfPass.text = textField.text
        }
    }
    
    //MARK: - CustomFunc
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top:0.0, left:0.0, bottom:keyboardSize.height, right:0.0)
            svLogin.contentInset = contentInsets
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        svLogin.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func isTappedSignup(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toSignup", sender: nil)
        
    }
    @IBAction func isTappedLogin(_ sender: Any) {
        
        guard (tfEmail.text?.characters.count)! >= 1 || m_sharedManager.isValidEmailAddress(emailAddressString: tfEmail.text!) else {
            m_sharedManager.showOKAlert(vc: self, title: "Input Error", message: "Please check your input")
            return
        }
        guard (tfPass.text?.characters.count)! >= 1 else {
            m_sharedManager.showOKAlert(vc: self, title: "Input Error", message: "Please check your input")
            return
        }
        
        let params1 = ["client_id": CLIENT_ID, "client_secret": CLIENT_SECRET]
        let credentialData = "\(CLIENT_ID):\(CLIENT_SECRET)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString()
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        
        let params2 = ["email": tfEmail.text!, "password": tfPass.text!]
        
        
        SVProgressHUD.show()
        Alamofire.request("http://servsne.com/shopit/index.php?route=feed/rest_api/gettoken&grant_type=client_credentials", method: .post, parameters: params1, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { (response) -> Void in
            print("Response: \(response)")
            if response.result.isSuccess {
                if let jsonDict = response.result.value as? NSDictionary {
                    print("Result: \(jsonDict)")
                    let result = jsonDict["success"] as? Int
                    let data = jsonDict["data"] as? NSDictionary
                    if result == 1 {
                        let access_token: String = data?["access_token"] as! String
                        ACCESS_TOKEN = access_token
                        let header = ["Authorization": "Bearer \(access_token)"]
                        DispatchQueue.global().async(execute: {
                            Alamofire.request("http://servsne.com/shopit/index.php?route=rest/login/login", method: .post, parameters: params2, encoding: JSONEncoding.default, headers: header).validate().responseJSON { (response) -> Void in
                                if response.result.isSuccess {
                                    if let resultDic = response.result.value as? NSDictionary {
                                        print("Login: \(resultDic)")
                                        let success = resultDic["success"] as? Int
                                        let dataLogin = resultDic["data"] as? NSDictionary
                                        if success ==  1 {
                                            m_sharedManager.user?.firstname = dataLogin!["firstname"] as? String
                                            m_sharedManager.user?.lastname = dataLogin!["lastname"] as? String
                                            m_sharedManager.user?.custom_group_id = dataLogin!["custom_group_id"] as? Int
                                            m_sharedManager.user?.custom_id = dataLogin!["custom_id"] as? Int
                                            m_sharedManager.user?.email = dataLogin!["email"] as? String
                                            m_sharedManager.user?.status = dataLogin!["status"] as? Int
                                            m_sharedManager.user?.telephone = dataLogin!["telephone"] as? Int
                                            m_sharedManager.user?.wishlist = dataLogin!["wishlist"] as? String
                                            m_sharedManager.user?.cart = dataLogin!["cart"] as? String
                                            
                                            DispatchQueue.main.async(execute: {
                                                self.performSegue(withIdentifier: "toMain", sender: nil)
                                                SVProgressHUD.dismiss()
                                                return
                                            })
                                            
                                        }
                                    }
                                } else {
                                    m_sharedManager.showOKAlert(vc: self, title: "", message: String(describing: response.error?.localizedDescription))
                                    SVProgressHUD.dismiss()
                                    return
                                }
                            }
                        })
                        
                        
                    } else {
                        //                        let data = jsonDict["data"] as? [String]
                        //                        m_sharedManager.showOKAlert(vc: self, title: "Error", message: (data?.first!)!)
                    }
                    
                }
                //                self.performSegue(withIdentifier: "ToMainVC", sender: nil)
                //                SVProgressHUD.dismiss()
                
                return
            } else {
                m_sharedManager.showOKAlert(vc: self, title: "", message: String(describing: response.error?.localizedDescription))
                SVProgressHUD.dismiss()
                return
            }
        }
        
    }
    
}

extension UIColor {

    // MARK: - Initialization

    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt32 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let length = hexSanitized.characters.count

        guard Scanner(string: hexSanitized).scanHexInt32(&rgb) else { return nil }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0

        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0

        } else {
            return nil
        }

        self.init(red: r, green: g, blue: b, alpha: a)
    }
}


