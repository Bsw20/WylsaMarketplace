//
//  PersonalChatTitleView.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 06.03.2022.
//

import Foundation
import UIKit

protocol PersonalChatTitleViewDelegate: NSObjectProtocol {
    func backButtonTapped(view: PersonalChatTitleView)
}

final class PersonalChatTitleView: UIView {
    
    //MARK: - Variables
    weak var customDelegate: PersonalChatTitleViewDelegate?
    //MARK: - Controls
    private var containerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .grey1
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return view
    }()
    
    private var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "left-sm"), for: .normal)
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.setStyle(style: .init(font: .ceraPro(style: .normal, size: 15),
                                    textColor: .white,
                                    textAlignment: .center))
        return label
    }()
    
    
    private let onlineLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.setStyle(style: .init(font: .ceraPro(style: .normal, size: 13),
                                    textColor: .gray2,
                                    textAlignment: .center))
        return label
    }()
    
    private var avatarImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .grey1
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 21
        return imageView
    }()
    
    private lazy var labelsStackView: UIStackView = UIStackView(views: [nameLabel,
                                                                         onlineLabel],
                                                                 spacing: 8,
                                                                 axis: .vertical,
                                                                 backgroundColor: .grey1)
    
    init() {
        super.init(frame: .zero)
        stubInit()
        setup()
        setupHierarchy()
        setupConstraints()
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    public func configure(viewModel: <#ViewModel#>) {
//
//    }
    
    private func stubInit() {
        avatarImageView.image = UIImage(named: "Ellipse 123")
        onlineLabel.text = "Сейчас онлайн"
        nameLabel.text = "Артем Ботвинов"
    }
    
    private func setup() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backgroundColor = .bg1

    }
    
    @objc
    private func backButtonTapped() {
        customDelegate?.backButtonTapped(view: self)
    }
    
    //MARK: - Layout
    private func setupHierarchy() {
        addSubview(containerView)
        containerView.addSubview(backButton)
        containerView.addSubview(labelsStackView)
        containerView.addSubview(avatarImageView)
    }
    
    private func setupConstraints() {
        snp.makeConstraints { make in
            make.height.equalTo(90)
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(34)
            make.width.equalTo(34)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.width.height.equalTo(42)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(23)
        }
        
        labelsStackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.left.equalTo(backButton.snp.right).priority(999)
            make.right.equalTo(avatarImageView.snp.left).priority(999)
        }
    }
    
}
