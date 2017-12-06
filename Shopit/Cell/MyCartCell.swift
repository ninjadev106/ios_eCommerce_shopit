//
//  MyCartCell.swift
//  Shopit
//
//  Created by mobile on 23/10/17.
//  Copyright © 2017 Shopit. All rights reserved.
//

import UIKit

protocol onDeleteProduct {
    func deleteProduct(index:Int)
}

class MyCartCell: UICollectionViewCell {
    
    //MARK: - Properties
    var productCount = 1
    var cellIndex = 0
    
    var delegate:onDeleteProduct?
    
    //MARK: - IBOutlets
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var viewNum: UIView!
    @IBOutlet weak var btnIncrease: UIButton!
    @IBOutlet weak var btnDecrease: UIButton!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    
    @IBAction func onBtnIncrease(_ sender: Any) {
        productCount += 1
        lblNumber.text = String(productCount)
    }
    @IBAction func onBtnDecrease(_ sender: Any) {
        guard productCount > 1 else {
            return
        }
        productCount -= 1
        lblNumber.text = String(productCount)
    }
    
    
    @IBAction func onBtnDeleteProduct(_ sender: Any) {
        delegate?.deleteProduct(index: cellIndex)
    }
    
    
    
}
