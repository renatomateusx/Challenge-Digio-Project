//
//  DetailViewController.swift
//  digio-challenge
//
//  Created by Renato Mateus on 09/11/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var productDetailTitleLabel: UILabel!
    @IBOutlet weak var productDetailImageView: UIImageView!
    @IBOutlet weak var productDetailDescriptionLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    private let product: Product
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
    
    // MARK: - Inits
    init(with product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailViewController {
    func setupUI() {
        self.closeButton.addTarget(self,
                                   action: #selector(didCloseButtonTapped),
                                   for: .touchUpInside)
    }
    
    func setupData() {
        productDetailTitleLabel.text = product.name
        productDetailDescriptionLabel.text = product.description
        
        let imagePlaceholder = UIImage(named: "placeholder")
        let url = URL(string: product.imageURL)
        self.productDetailImageView.kf.setImage(with: url,
                                                placeholder: imagePlaceholder,
                                                options: nil,
                                                progressBlock: nil,
                                                completionHandler: nil)
    }
}

// MARK: - Actions
extension DetailViewController {
    @objc
    func didCloseButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
