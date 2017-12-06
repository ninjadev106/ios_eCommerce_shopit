//
//  MyProfileViewController.swift
//  Shopit
//
//  Created by mobile on 24/10/17.
//  Copyright © 2017 Shopit. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var viewNav: UIView!
    @IBOutlet weak var ivPhoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavBar()
        
        ivPhoto.layer.cornerRadius = ivPhoto.frame.size.height / 2
        ivPhoto.clipsToBounds = true
        ivPhoto.layer.borderWidth = 2.0
        ivPhoto.layer.borderColor = UIColor.white.cgColor
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        ivPhoto.layer.cornerRadius = ivPhoto.frame.size.height / 2
        ivPhoto.clipsToBounds = true
        ivPhoto.layer.borderWidth = 2.0
        ivPhoto.layer.borderColor = UIColor.white.cgColor
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
    
    @IBAction func isTappedBtnBack(_ sender: Any) {
        
        for one in (self.navigationController?.viewControllers)! {
            if one is MainViewController {
                self.navigationController?.popToViewController(one, animated: true)
            }
            else {
                print("It is not MyProfileViewController")
            }
        }
        
    }
    @IBAction func onClickBtnPhotoEdit(_ sender: Any) {
        
//        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
//            let imagePicker = UIImagePickerController()
//            imagePicker.delegate = self
//            imagePicker.sourceType = .camera
//            imagePicker.allowsEditing = false
//            present(imagePicker, animated: true, completion: nil)
//        }
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        m_sharedManager.cameraGallery(controller: self, imagePicker: imagePicker)
        
    }
    
    //MARK: UIImagePickerController Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        ivPhoto.image = image
        dismiss(animated: true, completion: nil)
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
