//
//  WYTextField.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 26.02.2022.
//

import Foundation
import UIKit

struct WYTextFieldViewModel {
    let placeholder: String?
}

final class WYTextField: UITextField {
    
    //MARK: - Variables
    private let padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    
    //MARK: - Controls
    
    init(model: WYTextFieldViewModel) {
        super.init(frame: .zero)
        setup(model: model)
        setupHierarchy()
        setupConstraints()
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup(model: WYTextFieldViewModel) {
        self.backgroundColor = .grey1
        self.textColor = .gray2
        self.font = UIFont.ceraPro(style: .normal, size: 15)
        self.placeholder = model.placeholder
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        tintColor = .accentGreen
        
    }
    
    //MARK: - Layout
    private func setupHierarchy() {
        
    }
    
    private func setupConstraints() {
        snp.makeConstraints { make in
            make.height.equalTo(46)
        }
    }

    override public func textRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: padding)
     }

    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: padding)
     }

    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: padding)
     }
    
}
