//
//  ButtonCollectionViewCell.swift
//  WylsaMarketplace
//
//  Created by Владимир Моторкин on 06.03.2022.
//

import UIKit

class ButtonCollectionViewCell: UICollectionViewCell {
    private let button: UIButton = {
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.bordered()
            configuration.cornerStyle = .capsule
            configuration.baseForegroundColor = .white
            configuration.baseBackgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
            let button = UIButton(configuration: configuration)
            button.contentHorizontalAlignment = .left
            return button
        } else {
            return UIButton()
        }
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            button.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            button.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(text: String, isActive: Bool) {
        button.setTitle(text, for: .normal)
        if isActive {
            button.backgroundColor = .green
        }
    }
    
    
}
