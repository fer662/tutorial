//
//  Product.swift
//  Tutorial
//
//  Created by Fernando Mazzon on 9/9/16.
//  Copyright © 2016 Fer662. All rights reserved.
//

import Foundation
import SwiftyJSON

class Product {
    
    var name: String
    var price: Float
    
    init(name: String, price: Float) {
        self.name = name
        self.price = price
    }
    
    static func fromJSON(json: JSON) -> Product {
        return Product(name: json["name"]["3"].string!, price: json["price"].numberValue.floatValue)
    }
}