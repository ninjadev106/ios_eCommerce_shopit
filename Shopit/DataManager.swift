//
//  DataManager.swift
//  Shopit
//
//  Created by mobile on 26/10/17.
//  Copyright © 2017 Shopit. All rights reserved.
//

import UIKit
import AlamofireImage

let m_sharedManager = DataManager()

let CLIENT_ID = "shopping_oauth_client"
let CLIENT_SECRET = "shopping_oauth_secret"
var ACCESS_TOKEN = ""

class DataManager: NSObject {
    
    var user: User?
    
    override init() {
        user = User()
    }
    
    func saveAllData() {
        let data = NSKeyedArchiver.archivedData(withRootObject: user!)
        let defaults = UserDefaults.standard
        defaults.set(data, forKey: "user")
    }
    
    func loadAllData() {
        let defaults = UserDefaults.standard
        let data = defaults.object(forKey: "user")
        if (data != nil) {
            user = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as? User
        }
        
        if user == nil {
            user = User()
        }
        
    }
    
    func removeAllData() {
        let defauls = UserDefaults.standard
        defauls.removeObject(forKey: "user")
        categories.removeAll()
    }
    
//    func loadImageFromUrl(imgUrl: String) -> UIImage {
//        let downloader = ImageDownloader()
//        let urlRequest = URLRequest(url: URL(string: imgUrl)!)
//        downloader.download(urlRequest) { response in
//            print(response.request!)
//            print(response.response!)
//            print(response.result)
//            if let image = response.result.value {
//                print(image)
//                return
//            }
//        }
//    }
    
    func showOKAlert(vc: UIViewController, title: String?, message: String, hanndler: ((UIAlertAction) -> Swift.Void)? = nil) -> Void {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAlert = UIAlertAction(title: "OK", style: .default, handler: hanndler)
        alertVC.addAction(okAlert)
        vc .present(alertVC, animated: true, completion: nil)
    }
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    func cameraGallery(controller: UIViewController, imagePicker : UIImagePickerController)
    {
        let actionSheetController : UIAlertController = UIAlertController(title: "Please select", message: "Option to select", preferredStyle: .actionSheet)
        
        let cameraActionButton: UIAlertAction = UIAlertAction(title: "Camera", style: .default)
        { action -> Void in
            print("Camera")
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
            {
                imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
                imagePicker.allowsEditing = false
                controller.present(imagePicker, animated: true, completion: nil)
            }
        }
        actionSheetController.addAction(cameraActionButton)
        
        let galleryActionButton: UIAlertAction = UIAlertAction(title: "Gallery", style: .default)
        { action -> Void in
            print("Gallery")
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary)
            {
                imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
                imagePicker.allowsEditing = false
                controller.present(imagePicker, animated: true, completion: nil)
            }
        }
        actionSheetController.addAction(galleryActionButton)
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            print("Cancel")
        }
        actionSheetController.addAction(cancelActionButton)
        
        controller.present(actionSheetController, animated: true, completion: nil)
    }
    
}
