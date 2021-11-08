//
//  ProductCell.swift
//  digio-challenge
//
//  Created by Renato Mateus on 08/11/21.
//

import UIKit

class ProductCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    
    // MARK: - Private Properties
    static let identifier: String = "ProductCell"
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension ProductCell {
    func config(with product: Product) {
        self.productNameLabel.text = product.name
        self.productNameLabel.kf.setImage(with: url)
    }
}
