//
//  ProductDetailViewController.swift
//  Shopit
//
//  Created by mobile on 25/10/17.
//  Copyright © 2017 Shopit. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {

    //MARK: - IBOutlet
    
    @IBOutlet weak var btnProductColor1: UIButton!
    @IBOutlet weak var btnProductColor2: UIButton!
    @IBOutlet weak var btnProductColor3: UIButton!
    
    @IBOutlet weak var btnProductSizeS: UIButton!
    @IBOutlet weak var btnProductSizeM: UIButton!
    @IBOutlet weak var btnProductSizeL: UIButton!
    @IBOutlet weak var btnProductSizeXL: UIButton!
    
    @IBOutlet weak var viewNav: UIView!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var tfSearch: UITextField!
    
    @IBOutlet weak var btnBuyNow: UIButton!
    @IBOutlet weak var btnAddToWishList: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set Navigationbar
        setCustomNavBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        initView()
    }
    
    //MARK: - CustomFunc
    func setCustomNavBar() {
        self.navigationController?.navigationBar.isHidden = true
        self.viewNav.backgroundColor = UIColor(hex: "#4A148C")
        
        //Custom search bar
        viewSearch.layer.cornerRadius = viewSearch.frame.size.height / 2
        viewSearch.clipsToBounds = true
        tfSearch.layer.borderWidth = 0
        tfSearch.borderStyle = .none
        
        //status bar color
        UIApplication.shared.statusBarStyle = .lightContent
        UINavigationBar.appearance().clipsToBounds = true
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = UIColor(hex: "#42127E")
    }
    
    func initView(){
        btnProductColor1.layer.cornerRadius = btnProductColor1.bounds.size.width / 2
        btnProductColor2.layer.cornerRadius = btnProductColor2.bounds.size.width / 2
        btnProductColor3.layer.cornerRadius = btnProductColor3.bounds.size.width / 2
        btnProductSizeL.layer.cornerRadius = btnProductSizeL.bounds.size.width / 2
        btnProductSizeM.layer.cornerRadius = btnProductSizeM.bounds.size.width / 2
        btnProductSizeS.layer.cornerRadius = btnProductSizeS.bounds.size.width / 2
        btnProductSizeXL.layer.cornerRadius = btnProductSizeXL.bounds.size.width / 2
        btnProductSizeL.layer.borderColor = UIColor.lightGray.cgColor
        btnProductSizeM.layer.borderColor = UIColor.lightGray.cgColor
        btnProductSizeS.layer.borderColor = UIColor.lightGray.cgColor
        btnProductSizeXL.layer.borderColor = UIColor.lightGray.cgColor
        btnProductSizeS.layer.borderWidth = 1
        btnProductSizeM.layer.borderWidth = 1
        btnProductSizeL.layer.borderWidth = 1
        btnProductSizeXL.layer.borderWidth = 1
        
        btnAddToWishList.layer.cornerRadius = btnAddToWishList.frame.size.height / 2
        btnBuyNow.layer.cornerRadius = btnBuyNow.frame.size.height / 2
    }
    
    //MARK: - IBAction
    
    @IBAction func onBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func onBtnProductColor1(_ sender: Any) {
        var colorBtn = UIButton()
        colorBtn = sender as! UIButton
        
        let img = UIImage(named:"check.png")
        colorBtn.setImage(img, for: .normal)
        let imgEmpty = UIImage(named:"")

        
        switch colorBtn.tag {
        case 1:
            btnProductColor2.setImage(imgEmpty, for: .normal)
            btnProductColor3.setImage(imgEmpty, for: .normal)
            return
        case 2:
            btnProductColor3.setImage(imgEmpty, for: .normal)
            btnProductColor1.setImage(imgEmpty, for: .normal)
            return
        case 3:
            btnProductColor1.setImage(imgEmpty, for: .normal)
            btnProductColor2.setImage(imgEmpty, for: .normal)
            return
        default:
            return
        }
    }
    
    @IBAction func onBtnProductSize(_ sender: Any) {
        var sizeBtn = UIButton()
        sizeBtn = sender as! UIButton
        
//        sizeBtn.layer.borderColor = UIColor.black.cgColor
//        sizeBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        switch sizeBtn.tag {
        case 1:
            sizeBtn.layer.borderColor = UIColor.black.cgColor
            sizeBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            
            btnProductSizeM.layer.borderColor = UIColor.lightGray.cgColor
            btnProductSizeL.layer.borderColor = UIColor.lightGray.cgColor
            btnProductSizeXL.layer.borderColor = UIColor.lightGray.cgColor
            btnProductSizeM.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btnProductSizeL.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btnProductSizeXL.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            return
        case 2:
            sizeBtn.layer.borderColor = UIColor.black.cgColor
            sizeBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            
            btnProductSizeS.layer.borderColor = UIColor.lightGray.cgColor
            btnProductSizeL.layer.borderColor = UIColor.lightGray.cgColor
            btnProductSizeXL.layer.borderColor = UIColor.lightGray.cgColor
            btnProductSizeS.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btnProductSizeL.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btnProductSizeXL.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            return
        case 3:
            sizeBtn.layer.borderColor = UIColor.black.cgColor
            sizeBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            
            btnProductSizeS.layer.borderColor = UIColor.lightGray.cgColor
            btnProductSizeM.layer.borderColor = UIColor.lightGray.cgColor
            btnProductSizeXL.layer.borderColor = UIColor.lightGray.cgColor
            btnProductSizeS.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btnProductSizeM.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btnProductSizeXL.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            return
        case 4:
            sizeBtn.layer.borderColor = UIColor.black.cgColor
            sizeBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            
            btnProductSizeS.layer.borderColor = UIColor.lightGray.cgColor
            btnProductSizeL.layer.borderColor = UIColor.lightGray.cgColor
            btnProductSizeM.layer.borderColor = UIColor.lightGray.cgColor
            btnProductSizeM.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btnProductSizeL.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btnProductSizeM.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            return
            
        default:
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
