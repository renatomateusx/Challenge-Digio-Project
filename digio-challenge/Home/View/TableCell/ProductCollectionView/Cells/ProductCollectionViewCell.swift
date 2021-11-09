//
//  ProductCollectionViewCell.swift
//  digio-challenge
//
//  Created by Renato Mateus on 09/11/21.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "ProductCollectionViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var contentProductView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

}

// MARK: - Setup UI
extension ProductCollectionViewCell {
    func setupUI() {
        contentProductView.layer.cornerRadius = 20
        productImageView.layer.cornerRadius = 40
        
        contentProductView.clipsToBounds = true
        contentProductView.layer.masksToBounds = false
        contentProductView.layer.shadowColor = UIColor.gray.cgColor
        contentProductView.layer.shadowOffset = CGSize(width: -1, height: 1)
        contentProductView.layer.shadowOpacity = 0.7
        contentProductView.layer.shadowRadius = 4.0
    }
    func configure(with product: Product) {
        let imagePlaceholder = UIImage(named: "placeholder")
        if let url = URL(string: product.imageURL) {
            self.productImageView.kf.setImage(with: url,
                                              placeholder: imagePlaceholder,
                                              options: nil,
                                              progressBlock: nil,
                                              completionHandler: nil)
        }
    }
}
