//
//  Product.swift
//  Shopit
//
//  Created by mobile on 29/10/17.
//  Copyright © 2017 Shopit. All rights reserved.
//

import UIKit

class Product: NSObject {
    
    var product_id: Int?
    var name: String?
    var desc: String
    var imgUrl: String?
    var price: String?
    
    init(productID: Int, name: String, imgUrl: String, description: String, price: String){
        self.product_id = productID
        self.name = name
        self.imgUrl = imgUrl
        self.desc =  description
        self.price =  price
    }

}
