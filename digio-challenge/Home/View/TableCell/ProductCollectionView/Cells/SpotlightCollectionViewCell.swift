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
        setupUI()
    }
}

// MARK: - Setup UI
extension SpotlightCollectionViewCell {
    func setupUI() {
        mainContentView.layer.cornerRadius = 20.0
        mainContentView.clipsToBounds = true
        mainContentView.layer.masksToBounds = false
        mainContentView.layer.shadowColor = UIColor.gray.cgColor
        mainContentView.layer.shadowOffset = CGSize(width: -1, height: 5)
        mainContentView.layer.shadowOpacity = 0.7
        mainContentView.layer.shadowRadius = 4.0
    }
    func configure(with product: SpotLight) {
        guard let url = URL(string: product.bannerURL) else { return }
        self.productImageView.kf.setImage(with: url)
        self.productImageView.layer.cornerRadius = 20
    }
}
