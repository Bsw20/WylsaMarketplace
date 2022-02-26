//
//  AnouncementNavigationView.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 22.02.2022.
//

import Foundation
import UIKit


final class AnouncementNavigationView: UIView {
    enum BackButtonType {
        case back
        case close
        
        func getImage() -> UIImage? {
            switch self {
            
            case .back:
                return UIImage(named: "left-sm")
            case .close:
                return UIImage(named: "close-lg")
            }
        }
    }
    
    //MARK: - Variables
    
    //MARK: - Controls
    private var titleLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.setStyle(style: .init(font: .ceraPro(style: .normal, size: 28),
                                    textColor: .white,
                                    textAlignment: .left,
                                    numberOfLines: 2))
        label.text = "Создать объявления"
        return label
    }()
    
    
    private var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(buttonType: BackButtonType) {
        super.init(frame: .zero)
        setup(buttonType: buttonType)
        setupHierarchy()
        setupConstraints()
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup(buttonType: BackButtonType) {
        backButton.setImage(buttonType.getImage(), for: .normal)
        backgroundColor = .bg1
    }
    
    //MARK: - Layout
    private func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(backButton)
    }
    
    private func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(backButton.snp.right).offset(20)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(24)
        }
        
        titleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: Float(1000)), for: .vertical)
    }
    
}
