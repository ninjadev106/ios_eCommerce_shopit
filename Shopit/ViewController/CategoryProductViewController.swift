//
//  CategoryProductViewController.swift
//  Shopit
//
//  Created by mobile on 20/10/17.
//  Copyright © 2017 Shopit. All rights reserved.
//

import UIKit
import SideMenu
import Alamofire
import SVProgressHUD
import AlamofireImage

var products = [Product]()

class CategoryProductViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var cvCatPro: UICollectionView!
    @IBOutlet weak var cvSubCat: UICollectionView!
    @IBOutlet weak var viSearch: UIView!
    @IBOutlet weak var txtFieldsearch: UITextField!
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var lblCategoryName: UILabel!
    
    var currentCat = Category(categoryId: 0, name: "", imgUrl: "")
    let subCategoryImage = ["dress", "icon1", "icon", "bag", "shoe"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define the menus
//        let menuRightNavigationController = storyboard!.instantiateViewController(withIdentifier: "RightMenuNavigationController") as! UISideMenuNavigationController
//        SideMenuManager.default.menuRightNavigationController = menuRightNavigationController
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.view)
        
        //set Navigation Bar
        setNavBar()
        
        //set CollectionViewLayout
        if self.cvCatPro.tag == 102 {
            setCollectionViewLayout()
        }
        if self.cvSubCat.tag == 101 {
            setCollectionViewLayoutForSubCat()
        }
        
        lblCategoryName.text = currentCat.name
        
        SVProgressHUD.show()
        
        let header = ["Authorization": "Bearer \(ACCESS_TOKEN)"]
        Alamofire.request("http://servsne.com/shopit/index.php?route=feed/rest_api/products&category=\(currentCat.category_id!)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).validate().responseJSON { (response) -> Void in
            if response.result.isSuccess {
                if let jsonDict = response.result.value as? NSDictionary {
                    print("Products by Category_id: \(jsonDict)")
                    let result = jsonDict["success"] as? Int
                    let productList: NSArray = (jsonDict["data"] as? NSArray)!
                    if result == 1 {
                        for i in 0 ..< productList.count {
                            let dicProduct = productList.object(at: i) as! NSDictionary
                            let productid = dicProduct["id"] as! String
                            let product_id = Int(productid)
                            let name = dicProduct.value(forKey: "name") as! String
                            let imgUrl = dicProduct.value(forKey: "image") as! String
                            let desc = dicProduct.value(forKeyPath: "description") as! String
                            let price = dicProduct["price"] as! Double
                            let strPrice = String(price)
                            let product = Product(productID: product_id!, name: name, imgUrl: imgUrl, description: desc, price: strPrice)
                            products.append(product)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.cvCatPro.reloadData()
        self.cvSubCat.reloadData()
    }
    
    func setNavBar() {
        self.navigationController?.navigationBar.isHidden = true
        self.navBar.backgroundColor = UIColor(hex: "#4A148C")
        
        //Custom search bar
        viSearch.layer.cornerRadius = viSearch.frame.size.height / 2
        viSearch.clipsToBounds = true
        txtFieldsearch.layer.borderWidth = 0
        txtFieldsearch.borderStyle = .none
        
        //status bar color
        UIApplication.shared.statusBarStyle = .lightContent
        UINavigationBar.appearance().clipsToBounds = true
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = UIColor(hex: "#42127E")
    }
    
    @IBAction func isClickedBack(_ sender: Any) {
        
        for one in (self.navigationController?.viewControllers)! {
            if one is MainViewController {
                self.navigationController?.popToViewController(one, animated: true)
            }
            else {
                print("It is not CategoryProductViewController")
            }
        }
    }
    
    func setCollectionViewLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        let cellWidth: CGFloat = (UIScreen.main.bounds.size.width - 24) / 2
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.25)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        cvCatPro!.collectionViewLayout = layout
    }
    
    func setCollectionViewLayoutForSubCat() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .horizontal
        let cellHeight: CGFloat = self.cvSubCat.frame.size.height - 16
        layout.itemSize = CGSize(width: cellHeight, height: cellHeight)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        cvSubCat!.collectionViewLayout = layout
        cvSubCat.showsHorizontalScrollIndicator = false
    }
    
    //MARK: UICollectionView Datasource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == self.cvCatPro.tag{
            return products.count
        } else {
            return subCategoryImage.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == self.cvCatPro.tag {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryProductcell", for: indexPath) as! ProductCell
            cell.lblProductName.text = products[indexPath.row].name
            cell.lblProductPrice.text = String(products[indexPath.row].price!)
//            let downloader = ImageDownloader()
//            let urlRequest = URLRequest(url: URL(string: products[indexPath.row].imgUrl!)!)
//            downloader.download(urlRequest) { response in
//                print(response.request!)
//                print(response.response!)
//                print(response.result)
//                if let image = response.result.value {
//                    print(image)
//                    cell.ivProduct.image = image
//                }
//            }
            if let url = URL.init(string: products[indexPath.row].imgUrl!) {
                cell.ivProduct.downloadedFrom(url: url)
            }
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SubCategoryCell
            cell.imgSubCat.image = UIImage(named: subCategoryImage[indexPath.row])
            cell.imgSubCat.contentMode = .scaleToFill
            return cell
        }
        
    }
    
    //MARK: UICollectionView Delegate
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
