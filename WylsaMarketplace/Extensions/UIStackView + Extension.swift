//
//  UIStackView + Extension.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 22.02.2022.
//

import Foundation
import UIKit

//private var mainStackView: UIStackView = {
//    let stackView = UIStackView(arrangedSubviews: [
//
//    ])
//    stackView.translatesAutoresizingMaskIntoConstraints = false
//    stackView.axis = .vertical
//    stackView.spacing = 24
//    stackView.backgroundColor = .bg1
//    return stackView
//}(

extension UIStackView {
    convenience init(views: [UIView], spacing: CGFloat, axis: NSLayoutConstraint.Axis, backgroundColor: UIColor) {
        self.init(arrangedSubviews: views)
        translatesAutoresizingMaskIntoConstraints = false
        self.axis = axis
        self.spacing = spacing
        self.backgroundColor = backgroundColor
    }
}
