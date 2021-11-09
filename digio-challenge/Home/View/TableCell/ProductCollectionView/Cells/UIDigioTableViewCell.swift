//
//  UIDigioTableViewCell.swift
//  digio-challenge
//
//  Created by Renato Mateus on 09/11/21.
//

import UIKit

class UIDigioTableViewCell: UITableViewCell {
    
    static let identifier: String = "UIDigioTableViewCell"

    // MARK: - Outlets
    @IBOutlet weak var digioTitleLabel: UILabel!
    @IBOutlet weak var digioImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension UIDigioTableViewCell {
    func configure(with cash: Cash?) {
        fillLabelWithAttributedText(title: cash?.title)
        if let image = cash?.bannerURL, let url = URL(string: image) {
            self.digioImageView.kf.setImage(with: url)
        }
        self.digioImageView.layer.cornerRadius = 20
    }
    
    func fillLabelWithAttributedText(title: String?) {
        if let title = title {
            let fontAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
            let attributedStringTitle = NSMutableAttributedString(string: title, attributes: fontAttributes)
            attributedStringTitle.addAttribute(.foregroundColor, value: UIColor.darkGray, range: NSRange(location: 0, length: 5))
            attributedStringTitle.addAttribute(.foregroundColor, value: UIColor.lightGray, range: NSRange(location: 6, length: 4))
            self.digioTitleLabel.attributedText = attributedStringTitle
        }
    }
}
