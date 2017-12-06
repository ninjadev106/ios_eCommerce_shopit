//
//  User.swift
//  Shopit
//
//  Created by mobile on 28/10/17.
//  Copyright © 2017 Shopit. All rights reserved.
//

import UIKit

class User: NSObject, NSCoding {
    
    var firstname: String?
    var lastname: String?
    var custom_group_id: Int?
    var custom_id: Int?
    var status: Int?
    var email: String?
    var telephone: Int?
    var wishlist: String?
    var cart: String?
    
    override init() {
        super.init()
        
        firstname = ""
        email = ""
        lastname = ""
        custom_group_id = nil
        custom_id = nil
        status = nil
        telephone = nil
        wishlist = ""
        cart = ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        firstname = aDecoder.decodeObject(forKey: "firstname") as? String ?? "null"
        lastname = aDecoder.decodeObject(forKey: "lastname") as? String ?? "null"
        email = aDecoder.decodeObject(forKey: "email") as? String ?? "null"
        custom_group_id = aDecoder.decodeInteger(forKey: "custom_group_id")
        custom_id = aDecoder.decodeInteger(forKey: "custom_id")
        status = aDecoder.decodeInteger(forKey: "status")
        telephone = aDecoder.decodeInteger(forKey: "telephone")
        wishlist = aDecoder.decodeObject(forKey: "wishlist") as? String ?? "null"
        cart = aDecoder.decodeObject(forKey: "cart") as? String ?? "null"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(firstname, forKey: "firstname")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(lastname, forKey: "lastname")
        aCoder.encode(custom_group_id, forKey: "custom_group_id")
        aCoder.encode(custom_id, forKey: "custom_id")
        aCoder.encode(status, forKey: "status")
        aCoder.encode(telephone, forKey: "telephone")
        aCoder.encode(wishlist, forKey: "wishlist")
        aCoder.encode(cart, forKey: "cart")
    }
    

}
