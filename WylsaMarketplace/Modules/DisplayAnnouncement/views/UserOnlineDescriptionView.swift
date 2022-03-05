//
//  UserOnlineDescriptionView.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 04.03.2022.
//

import Foundation
import UIKit

struct UserOnlineDescriptionViewModel {
    let avatar: UIImage
    let firstName: String
    let lastName: String
    let isOnline: Bool
}

final class UserOnlineDescriptionView: UIView {
    
    //MARK: - Variables
    
    //MARK: - Controls
    private var containerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .grey1
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var labelsStackView: UIStackView =            UIStackView(views: [nameLabel,
                                                                         onlineLabel],
                                                                 spacing: 8,
                                                                 axis: .vertical,
                                                                 backgroundColor: .grey1)
    
    private let nameLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.setStyle(style: .init(font: .ceraPro(style: .normal, size: 15),
                                    textColor: .white,
                                    textAlignment: .left))
        return label
    }()
    
    
    private let onlineLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.setStyle(style: .init(font: .ceraPro(style: .normal, size: 13),
                                    textColor: .gray2,
                                    textAlignment: .left,
                                    text: "описание"))
        return label
    }()
    
    private var avatarImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .grey1
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 24.5
        return imageView
    }()
    

    
    init() {
        super.init(frame: .zero)
        stubInit()
        setup()
        setupHierarchy()
        setupConstraints()
        
    }
    
    private func stubInit() {
        nameLabel.text = "Артем Ботвинов"
        onlineLabel.text = "Сейчас онлайн"
        avatarImageView.image = #imageLiteral(resourceName: "PhotoCollectionStubImage")
    }
    
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(viewModel: UserOnlineDescriptionViewModel) {
        
    }
    
    private func setup() {
    }
    
    //MARK: - Layout
    private func setupHierarchy() {
        addSubview(containerView)
        containerView.addSubview(avatarImageView)
        containerView.addSubview(labelsStackView)
        
    }
    
    private func setupConstraints() {
        snp.makeConstraints { make in
            make.height.equalTo(73)
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.height.width.equalTo(49)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(12)
        }
        
        labelsStackView.snp.makeConstraints { make in
            make.left.equalTo(avatarImageView.snp.right).offset(8)
            make.centerY.equalToSuperview()
        }
        
        
    }
    
}
