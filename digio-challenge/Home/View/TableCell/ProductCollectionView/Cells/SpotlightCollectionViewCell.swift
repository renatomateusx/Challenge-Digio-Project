//
//  ProductCollectionViewCell.swift
//  digio-challenge
//
//  Created by Renato Mateus on 08/11/21.
//

import UIKit

class SpotlightCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "SpotlightCollectionViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension SpotlightCollectionViewCell {
    func configure(with product: SpotLight) {
        guard let url = URL(string: product.bannerURL) else { return }
        self.productImageView.kf.setImage(with: url)
        self.productImageView.layer.cornerRadius = 20
        self.productImageView.layer.shadowColor = UIColor.black.cgColor
        self.mainContentView.dropShadow(color: .red, opacity: 1,
                                         offSet: CGSize(width: -1, height: 1),
                                         radius: 3, scale: true)
    }
}
