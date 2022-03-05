//
//  UILabel + Extension.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 12.02.2022.
//

import Foundation
import UIKit


struct LabelStyle {
    var font: UIFont?
    var textColor: UIColor?
    var textAlignment: NSTextAlignment?
    var numberOfLines: Int?
    var text: String?
    var lineBreakMode: NSLineBreakMode?
    
}

extension UILabel {
    static func newAutoLayout() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    func setStyle(style: LabelStyle) {
        if let font = style.font {
            self.font = font
        }
        
        if let textColor = style.textColor {
            self.textColor = textColor
        }
        
        if let textAlignment = style.textAlignment {
            self.textAlignment = textAlignment
        }
        
        if let numberOfLines = style.numberOfLines {
            self.numberOfLines = numberOfLines
        }
        
        if let text = style.text {
            self.text = text
        }
        
        if let lineBreakMode = style.lineBreakMode {
            self.lineBreakMode = lineBreakMode
        }
        

    }
}
