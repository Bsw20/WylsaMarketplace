//
//  LabledTextFieldView.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 26.02.2022.
//

import Foundation
import UIKit

struct LabledTextFieldViewModel {
    let titleText: String
    let textfieldPlaceholder: String?
}

final class LabledTextFieldView: UIView {
    
    //MARK: - Variables
    
    //MARK: - Controls
    
    private var titleLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.setStyle(style: .init(font: .ceraPro(style: .normal, size: 13),
                                    textColor: .gray2,
                                    textAlignment: .left,
                                    numberOfLines: 1,
                                    text: "Название объявления"
                                    ))
        return label
    }()
    
    public let mainTextField: WYTextField = {
        let view = WYTextField(model: .init(placeholder: "Добавьте название"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(model: LabledTextFieldViewModel) {
        super.init(frame: .zero)
        setup(model: model)
        setupHierarchy()
        setupConstraints()
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//
//    public func configure(viewModel: <#ViewModel#>) {
//
//    }
    
    private func setup(model: LabledTextFieldViewModel) {
        titleLabel.text = model.titleText
        mainTextField.placeholder = model.textfieldPlaceholder
    }
    
    //MARK: - Layout
    private func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(mainTextField)
        
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
        }
        
        mainTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
}
