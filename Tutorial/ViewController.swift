//
//  ViewController.swift
//  Tutorial
//
//  Created by Fernando Mazzon on 9/9/16.
//  Copyright © 2016 Fer662. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ProductViewControllerDelegate, ProductTableViewCellDelegate {

    var products: [Product]?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.title = NSLocalizedString("Productos", comment: "")
        
        Client.sharedInstance.getPosts { (products) in
            self.products = products
            self.tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(ProductTableViewCell.self)) as! ProductTableViewCell
        cell.product = products![indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let product = products![indexPath.row]
        
        self.editPriceForProduct(product)
    }
    
    func productTableViewCellUpdateProduct(product: Product) {
        self.editPriceForProduct(product)
    }
    
    func productViewControllerUpdatedProduct(viewController: ProductViewController, product: Product) {
        self.tableView.reloadData()
    }
    
    func editPriceForProduct(product: Product) {
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier(String(ProductViewController.self)) as! ProductViewController
        viewController.product = product
        viewController.delegate = self
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

