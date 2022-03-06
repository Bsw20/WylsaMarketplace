//
//  ProfileNavigationView.swift
//  WylsaMarketplace
//
//  Created by Владимир Моторкин on 06.03.2022.
//

import Foundation

import Foundation
import UIKit

protocol ProfileNavigationViewDelegate: NSObjectProtocol {
    func backButtonTapped(view: ProfileNavigationView)
    func settingsButtonTapped(view: ProfileNavigationView)
}

final class ProfileNavigationView: UIView {
    weak var customDelegate: ProfileNavigationViewDelegate?
    
    enum BackButtonType {
        case back
        case close
        case settings
        
        func getImage() -> UIImage? {
            switch self {
            
            case .back:
                return UIImage(named: "left-sm")
            case .close:
                return UIImage(named: "close-lg")
            case .settings:
                return UIImage(named: "settings")
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
        label.text = "Создание объявления"
        return label
    }()
    
    
    private var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var settingsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "settings"), for: .normal)
        return button
    }()
    
    init(buttonType: BackButtonType, title: String) {
        super.init(frame: .zero)
        setup(buttonType: buttonType, title: title)
        setupHierarchy()
        setupConstraints()
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup(buttonType: BackButtonType, title: String) {
        titleLabel.text = title
        backButton.setImage(buttonType.getImage(), for: .normal)
        backgroundColor = .bg1
        backButton.addTarget(self, action: #selector(backButtonTapped) , for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped) , for: .touchUpInside)
    }
    
    @objc
    private func backButtonTapped() {
        customDelegate?.backButtonTapped(view: self)
    }
    
    @objc
    private func settingsButtonTapped() {
        customDelegate?.backButtonTapped(view: self)
    }
    
    //MARK: - Layout
    private func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(backButton)
        addSubview(settingsButton)
    }
    
    private func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(34)
            make.width.equalTo(34)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(backButton.snp.right).offset(20)
            make.right.equalTo(settingsButton.snp.left).offset(20)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(24)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(34)
            make.width.equalTo(34)
        }
        
        
        titleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: Float(1000)), for: .vertical)
    }
    
}
