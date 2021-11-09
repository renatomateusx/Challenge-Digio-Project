//
//  ProductCollectionView.swift
//  digio-challenge
//
//  Created by Renato Mateus on 09/11/21.
//

import UIKit

protocol ProductCollectionViewDelegate: AnyObject {
    func didProductSelected(product: Product)
}

class ProductCollectionView: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var productsTitleLabel: UILabel!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    // MARK: - Public Properties
    weak var delegate: ProductCollectionViewDelegate?
    
    // MARK: - Private Properties
    static let identifier: String = "ProductCollectionView"
    var products: [Product] = []
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

// MARK: - Setup UI
extension ProductCollectionView {
    func setupUI() {
        productsCollectionView.isScrollEnabled = true
        productsCollectionView.showsHorizontalScrollIndicator = false
        productsCollectionView.showsVerticalScrollIndicator = false
        productsCollectionView.register(UINib(nibName: ProductCollectionViewCell.identifier,
                                      bundle: nil),
                                forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        
        let spacing: CGFloat = 12
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        productsCollectionView.collectionViewLayout = layout
        
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
    }
    
    func setupData(with product: Products) {
        self.products = product
        self.productsCollectionView.reloadData()
    }
}


// MARK: - CollectionViewDataSource

extension ProductCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = self.products[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier,
                                                            for: indexPath) as? ProductCollectionViewCell  else { return  UICollectionViewCell() }
        cell.configure(with: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = self.products[indexPath.row]
        self.delegate?.didProductSelected(product: product)
    }
}

// MARK: - UICollectionViewLayout

extension ProductCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 154, height: 120)
    }
}
