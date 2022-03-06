//
//  DoneNavigationView.swift
//  WylsaMarketplace
//
//  Created by Владимир Моторкин on 06.03.2022.
//

import Foundation
import UIKit

protocol DoneNavigationViewDelegate: NSObjectProtocol {
    func doneButtonTapped(view: DoneNavigationView)
}

final class DoneNavigationView: UIView {
    weak var customDelegate: DoneNavigationViewDelegate?
    
    
    //MARK: - Variables
    
    //MARK: - Controls
    private var titleLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.setStyle(style: .init(font: .ceraPro(style: .normal, size: 28),
                                    textColor: .white,
                                    textAlignment: .left,
                                    numberOfLines: 2))
        label.text = "Создание объявления"
        return label
    }()
    
    
    private var doneButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "check"), for: .normal)
        return button
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        setup(title: title)
        setupHierarchy()
        setupConstraints()
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup(title: String) {
        titleLabel.text = title
        doneButton.addTarget(self, action: #selector(doneButtonTapped) , for: .touchUpInside)
    }
    
    
    @objc
    private func doneButtonTapped() {
        customDelegate?.doneButtonTapped(view: self)
    }
    
    //MARK: - Layout
    private func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(doneButton)
    }
    
    private func setupConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalTo(doneButton.snp.left).offset(20)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(24)
        }
        
        doneButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(34)
            make.width.equalTo(34)
        }
        
        
        titleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: Float(1000)), for: .vertical)
    }
    
}
