//
//  UITableView+Extensions.swift
//  digio-challenge
//
//  Created by Renato Mateus on 08/11/21.
//

import UIKit

public extension UITableView {
    
    /// Shows project's default loading on the UITableView.
    func showLoading(color: UIColor = UIColor.darkGray) {
        let loading = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        loading.color = color
        loading.startAnimating()
        self.backgroundView = loading
    }
    
    /// Hides any visible loading from the UITableView.
    func hideLoading() {
        self.backgroundView = nil
    }
}
extension UIView {
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius

        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
      }
}
