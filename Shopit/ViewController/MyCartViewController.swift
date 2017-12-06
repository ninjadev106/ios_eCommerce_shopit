//
//  MyCartViewController.swift
//  Shopit
//
//  Created by mobile on 23/10/17.
//  Copyright © 2017 Shopit. All rights reserved.
//

import UIKit

class MyCartViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, onDeleteProduct{
    
    @IBOutlet weak var cvMyCart: UICollectionView!
    @IBOutlet weak var viewNav: UIView!
    
    var productList = ["1","2","3","4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        setCollectionViewLayoutForCartCell()

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
    
    func setCollectionViewLayoutForCartCell() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        let cellWidth: CGFloat = UIScreen.main.bounds.size.width - 16
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth / 2)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        cvMyCart!.collectionViewLayout = layout
    }

    @IBAction func isTappedBtnBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    //MARK: Collection View Datasource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item < productList.count {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCartCell", for: indexPath) as! MyCartCell
            cell.viewNum.layer.borderWidth = 1
            cell.viewNum.clipsToBounds = true
            cell.viewNum.layer.cornerRadius = cell.viewNum.frame.size.height / 2
            cell.viewNum.layer.borderColor = UIColor(hex: "#B4B8C8")?.cgColor
            cell.cellIndex = indexPath.item
            
            cell.delegate = self    
            
            return cell

        }else {
           
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCartLastCell", for: indexPath) as! MyCartLastCell
            cell.btnComplete.layer.cornerRadius = cell.btnComplete.frame.size.height / 2
            cell.btnComplete.clipsToBounds = true
            
            return cell
        }

    }
    
    //MARK: - MyCartCellDelegate
    func deleteProduct(index:Int) {
        guard productList.count > 0 else {
            return
        }
        productList.remove(at: index)
        
        cvMyCart.reloadData()
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


