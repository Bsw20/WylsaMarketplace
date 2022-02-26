//
//  UIFont + Extension.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 12.02.2022.
//

import Foundation
import UIKit

enum CeraProStyle {
    case normal
    case bold
}

extension UIFont {
    static func ceraPro(style: CeraProStyle, size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .regular)
    }
}
