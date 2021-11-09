//
//  ProductCollectionView.swift
//  digio-challenge
//
//  Created by Renato Mateus on 08/11/21.
//

import UIKit

class SpotlightCollectionView: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Private Properties
    static let identifier: String = "SpotlightCollectionView"
    var spotlight: SpotLights = []
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
}

// MARK: - Setup UI

extension SpotlightCollectionView {
    func setupUI() {
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(UINib(nibName: SpotlightCollectionViewCell.identifier,
                                      bundle: nil),
                                forCellWithReuseIdentifier: SpotlightCollectionViewCell.identifier)
        
        let spacing: CGFloat = 12
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        collectionView.collectionViewLayout = layout
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - Setup Data
extension SpotlightCollectionView {
    func setupData(products: SpotLights) {
        self.spotlight = products
        collectionView.reloadData()
    }
}

// MARK: - CollectionViewDataSource

extension SpotlightCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.spotlight.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pic = self.spotlight[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpotlightCollectionViewCell.identifier,
                                                            for: indexPath) as? SpotlightCollectionViewCell  else { return  UICollectionViewCell() }
        cell.configure(with: pic)
        return cell
    }
}

// MARK: - UICollectionViewLayout

extension SpotlightCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.contentView.frame.size.width, height: 200)
    }
}
