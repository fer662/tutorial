//
//  ProductViewController.swift
//  Tutorial
//
//  Created by Fernando Mazzon on 9/9/16.
//  Copyright © 2016 Fer662. All rights reserved.
//

import UIKit

protocol ProductViewControllerDelegate: NSObjectProtocol {
    func productViewControllerUpdatedProduct(viewController: ProductViewController, product: Product)
}

class ProductViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    weak var delegate: ProductViewControllerDelegate?
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = product!.name
        
        nameLabel.text = product!.name
        priceLabel.text = String(product!.price)
    }
    
    @IBAction func updatePriceButtonAction(sender: AnyObject) {
        self.product?.price = 1000
        
        self.delegate?.productViewControllerUpdatedProduct(self, product: self.product!)
        self.navigationController?.popToViewController(delegate as! UIViewController, animated: true)
    }
}
