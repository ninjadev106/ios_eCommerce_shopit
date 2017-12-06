//
//  WishListViewController.swift
//  Shopit
//
//  Created by mobile on 24/10/17.
//  Copyright © 2017 Shopit. All rights reserved.
//

import UIKit

class WishListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var cvWishList: UICollectionView!
    @IBOutlet weak var viewNav: UIView!
    
    let wishList = ["1", "2", "3", "4"]
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavBar()
        setCollectionViewLayoutForWishListCell()
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
    
    func setCollectionViewLayoutForWishListCell() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        let cellWidth: CGFloat = UIScreen.main.bounds.size.width - 16
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth / 2)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        cvWishList!.collectionViewLayout = layout
    }

    @IBAction func isTappedBtnBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    //MARK: Collection View Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wishList.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item < wishList.count {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wishListCell", for: indexPath) as! WishListCell
            cell.btnAddToCart.layer.cornerRadius = cell.btnAddToCart.frame.size.height / 2
            cell.btnAddToCart.clipsToBounds = true
//            cell.delegate = self
            
            return cell
            
        }else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myWishListLastCell", for: indexPath) as! WishListLastCell
            cell.btnAddAll.layer.cornerRadius = cell.btnAddAll.frame.size.height / 2
            cell.btnAddAll.clipsToBounds = true
            
            return cell
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
