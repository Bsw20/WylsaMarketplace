//
//  ButtonCollectionViewCell.swift
//  WylsaMarketplace
//
//  Created by Владимир Моторкин on 06.03.2022.
//

import UIKit

class ButtonCollectionViewCell: UICollectionViewCell {
    private let label: UILabel = {
        let label = UILabel()
        label.layer.backgroundColor = UIColor.grey1.cgColor
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1 км"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            label.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(text: String, isActive: Bool) {
        label.text = text
        if isActive {
            label.layer.backgroundColor = UIColor.green.cgColor
        } else {
            label.layer.backgroundColor = UIColor.grey1.cgColor
        }
    }
    
    
}

