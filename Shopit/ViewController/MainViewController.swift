//
//  MainViewController.swift
//  Shopit
//
//  Created by mobile on 16/10/17.
//  Copyright © 2017 Shopit. All rights reserved.
//

import UIKit
import SideMenu
import Alamofire
import SVProgressHUD

var categories = [Category]()

class MainViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var navBarCustom: UIView!
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var svBanner: UIScrollView!
    @IBOutlet weak var pcBanner: UIPageControl!
    @IBOutlet weak var cvNewProducts: UICollectionView!
    
    var categoryOne = Category(categoryId: 0, name: "", imgUrl: "")
    let arrBannerImages = ["banner.png", "banner.png", "banner.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Define the menus
        let menuRightNavigationController = storyboard!.instantiateViewController(withIdentifier: "RightMenuNavigationController") as! UISideMenuNavigationController
        SideMenuManager.default.menuRightNavigationController = menuRightNavigationController
        
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the view controller it displays!
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.view)
        
        //set Navigation Bar
        setCustomNavBar()
        
        //banner pagecontrol
        loadScrollView()
        
        //set CollectionViewLayout
        setCollectionViewLayout()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onGetNotification(_:)), name: NSNotification.Name(rawValue: "Notification"), object: nil)
        
        SVProgressHUD.show()
        
        let header = ["Authorization": "Bearer \(ACCESS_TOKEN)"]
        Alamofire.request("http://servsne.com/shopit/index.php?route=feed/rest_api/categories", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).validate().responseJSON { (response) -> Void in
            if response.result.isSuccess {
                if let jsonDict = response.result.value as? NSDictionary {
                    print("Categories: \(jsonDict)")
                    let result = jsonDict["success"] as? Int
                    let categoryList: NSArray = (jsonDict["data"] as? NSArray)!
                    if result == 1 {
                        for i in 0 ..< categoryList.count {
                            let dicCategory = categoryList.object(at: i) as! NSDictionary
                            let categoryid = dicCategory["category_id"] as! String
                            let category_id = Int(categoryid)
                            let name = dicCategory.value(forKey: "name") as! String
                            let imgUrl = dicCategory.value(forKey: "image") as! String
                            let category = Category(categoryId: category_id!, name: name, imgUrl: imgUrl)
                            categories.append(category)
                            SVProgressHUD.dismiss()
                        }
                    }
                }
            } else {
                m_sharedManager.showOKAlert(vc: self, title: "", message: String(describing: response.error?.localizedDescription))
                SVProgressHUD.dismiss()
            }
        }
        
    }
    
    func setCustomNavBar() {
        self.navigationController?.navigationBar.isHidden = true
        self.navBarCustom.backgroundColor = UIColor(hex: "#4A148C")
        
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
    @objc func onGetNotification(_ sender: Notification) {
        let object = sender.object
        if object is IndexPath {
            print("IndexPath row is \((object as! IndexPath).row)")
            
            let rowNum = (object as! IndexPath).row
            
            let latestVC = self.navigationController?.viewControllers.last
            
            let header = ["Authorization": "Bearer \(ACCESS_TOKEN)"]
            
            categoryOne = categories[rowNum]
            
            if latestVC is MainViewController {
                if rowNum  == categories.count {
                    self.performSegue(withIdentifier: "toMyProfile", sender: nil)
                } else if rowNum  == categories.count + 1 {
                    Alamofire.request("http://servsne.com/shopit/index.php?route=rest/logout/logout", method: .post, parameters: nil, encoding: JSONEncoding.default, headers: header).validate().responseJSON { (response) -> Void in
                        if response.result.isSuccess {
                            if let jsonDict = response.result.value as? NSDictionary {
                                print("Logout: \(jsonDict)")
                                let result = jsonDict["success"] as? Int
                                if result == 1 {
                                    DispatchQueue.main.async(execute: {
                                        self.navigationController?.popToRootViewController(animated: true)
                                        m_sharedManager.removeAllData()
                                    })
                                }
                            }
                        } else {
                            m_sharedManager.showOKAlert(vc: self, title: "", message: String(describing: response.error?.localizedDescription))
                        }
                    }
                } else {                    
                    self.performSegue(withIdentifier: "toCatPro", sender: categoryOne)
                }
            } else {
                if rowNum == categories.count {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyProfileViewController") as! MyProfileViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                } else if rowNum  == categories.count + 1 {
                    Alamofire.request("http://servsne.com/shopit/index.php?route=rest/logout/logout", method: .post, parameters: nil, encoding: JSONEncoding.default, headers: header).validate().responseJSON { (response) -> Void in
                        if response.result.isSuccess {
                            if let jsonDict = response.result.value as? NSDictionary {
                                print("Logout: \(jsonDict)")
                                let result = jsonDict["success"] as? Int
                                if result == 1 {
                                    DispatchQueue.main.async(execute: {
                                        self.navigationController?.popToRootViewController(animated: true)
                                        m_sharedManager.removeAllData()
                                    })
                                }
                            }
                        } else {
                            m_sharedManager.showOKAlert(vc: self, title: "", message: String(describing: response.error?.localizedDescription))
                        }
                    }
                } else {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "CategoryProductViewController") as! CategoryProductViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadScrollView() {
        let pageCount : CGFloat = CGFloat(arrBannerImages.count)
        
        svBanner.backgroundColor = UIColor.clear
        svBanner.isPagingEnabled = true
        svBanner.contentSize = CGSize(width: svBanner.frame.size.width * pageCount, height: svBanner.frame.size.height)
        svBanner.showsHorizontalScrollIndicator = false
        
        pcBanner.numberOfPages = Int(pageCount)
        pcBanner.addTarget(self, action: #selector(self.pageChanged), for: .valueChanged)
        
        var image: UIImageView!
        
        for i in 0..<Int(pageCount) {
            print(self.svBanner.frame.size.width)
            image = UIImageView(frame: CGRect(x: self.view.frame.size.width * CGFloat(i), y: 0, width: self.view.frame.size.width, height: self.svBanner.frame.size.height))
            image.image = UIImage(named: arrBannerImages[i])!
            image.contentMode = UIViewContentMode.scaleToFill
            self.svBanner.addSubview(image)
        }
    }

    //MARK: Page tap action
    @objc func pageChanged() {
        let pageNumber = pcBanner.currentPage
        var frame = svBanner.frame
        frame.origin.x = frame.size.width * CGFloat(pageNumber)
        frame.origin.y = 0
        svBanner.scrollRectToVisible(frame, animated: true)
    }
    
    //MARK: UIScrollView Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let viewWidth: CGFloat = scrollView.frame.size.width
        // content offset - tells by how much the scroll view has scrolled.
        let pageNumber = floor((scrollView.contentOffset.x - viewWidth / 50) / viewWidth) + 1
        pcBanner.currentPage = Int(pageNumber)
    }
    
    func setCollectionViewLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        let cellWidth: CGFloat = (UIScreen.main.bounds.size.width - 24) / 2
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.25)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        cvNewProducts!.collectionViewLayout = layout
    }
    
    //MARK: UICollectionView Datasource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductCell
        return cell
    }
    
    //MARK: UICollectionView Delegate
    
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCatPro" {
            let catProVC = segue.destination as! CategoryProductViewController
            catProVC.currentCat = categoryOne
        }
    }
    

}
