//
//  ProductTableViewCell.swift
//  Tutorial
//
//  Created by Fernando Mazzon on 9/9/16.
//  Copyright © 2016 Fer662. All rights reserved.
//

import UIKit

protocol ProductTableViewCellDelegate: NSObjectProtocol {
    func productTableViewCellUpdateProduct(product: Product)
}

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    weak var delegate: ProductTableViewCellDelegate?
    
    var product: Product? {
        didSet {
            nameLabel.text = product?.name
            priceLabel.text = String(product!.price)
        }
    }

    @IBAction func editPriceButtonAction(sender: AnyObject) {
        delegate?.productTableViewCellUpdateProduct(self.product!)
    }
}