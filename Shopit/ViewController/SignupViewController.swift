//
//  SignupViewController.swift
//  Shopit
//
//  Created by mobile on 15/10/17.
//  Copyright © 2017 Shopit. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class SignupViewController: UIViewController, UITextFieldDelegate	 {
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldPass: UITextField!
    @IBOutlet weak var txtFieldRePass: UITextField!
    @IBOutlet weak var svSignup: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //set up UI
        self.navigationController?.navigationBar.isHidden = true
        
        txtFieldEmail.layer.cornerRadius = txtFieldEmail.frame.size.height / 2
        txtFieldEmail.layer.borderWidth = 1
        txtFieldEmail.clipsToBounds = true
        txtFieldEmail.layer.borderColor = UIColor(hex: "#B4B8C8")?.cgColor
        txtFieldPass.layer.cornerRadius = txtFieldPass.frame.size.height / 2
        txtFieldPass.layer.borderWidth = 1
        txtFieldPass.layer.borderColor = UIColor(hex: "#B4B8C8")?.cgColor
        txtFieldPass.clipsToBounds = true
        txtFieldRePass.layer.cornerRadius = txtFieldRePass.frame.size.height / 2
        txtFieldRePass.layer.borderWidth = 1
        txtFieldRePass.clipsToBounds = true
        txtFieldRePass.layer.borderColor = UIColor(hex: "#B4B8C8")?.cgColor
        
        //status bar
        setStatusBar()
        
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
    
    //MARK: - CustomFunc
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top:0.0, left:0.0, bottom:keyboardSize.height, right:0.0)
            svSignup.contentInset = contentInsets
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        svSignup.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func isTappedBtnSignup(_ sender: Any) {
        
        guard (txtFieldEmail.text?.characters.count)! >= 1 || m_sharedManager.isValidEmailAddress(emailAddressString: txtFieldEmail.text!) else {
            m_sharedManager.showOKAlert(vc: self, title: "Input Error", message: "Please check your input")
            return
        }
        guard (txtFieldPass.text?.characters.count)! >= 6 else {
            m_sharedManager.showOKAlert(vc: self, title: "Input Error", message: "Please enter at least 6 characters")
            return
        }
        guard (txtFieldRePass.text?.characters.count)! >= 6 || (txtFieldRePass.text? .isEqual(txtFieldPass.text))! else {
            m_sharedManager.showOKAlert(vc: self, title: "Input Error", message: "Please check your input")
            return
        }
        
        let params1 = ["client_id": CLIENT_ID, "client_secret": CLIENT_SECRET]
        let credentialData = "\(CLIENT_ID):\(CLIENT_SECRET)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString()
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        
        let params2 = ["email": txtFieldEmail.text!, "password": txtFieldPass.text!, "confirm": txtFieldRePass.text!, "agree": "1", "firstname": "fff", "lastname": "www", "telephone": "133434"]
        
        
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
                            Alamofire.request("http://servsne.com/shopit/api/rest/register", method: .post, parameters: params2, encoding: JSONEncoding.default, headers: header).validate().responseJSON { (response) -> Void in
                                if response.result.isSuccess {
                                    if let resultDic = response.result.value as? NSDictionary {
                                        print("Register: \(resultDic)")
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
                                                self.performSegue(withIdentifier: "toMainVC", sender: nil)
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
    
    @IBAction func isTappedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        
    }
    
}
