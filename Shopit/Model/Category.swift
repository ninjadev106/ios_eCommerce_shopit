//
//  Category.swift
//  Shopit
//
//  Created by mobile on 28/10/17.
//  Copyright © 2017 Shopit. All rights reserved.
//

import UIKit

class Category: NSObject {
    
    var category_id: Int?
    var name: String?
    var imgUrl: String?
    
    init(categoryId: Int, name: String, imgUrl: String){
        self.category_id = categoryId
        self.name = name
        self.imgUrl = imgUrl
    }

}
