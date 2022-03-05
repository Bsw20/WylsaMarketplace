//
//  AddPhotoCollectionCell.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 03.03.2022.
//

import Foundation
import UIKit


protocol AddPhotoCollectionCellDelegate: NSObjectProtocol {
    func addButtonTapped(view: AddPhotoCollectionCell)
}


final class AddPhotoCollectionCell: UICollectionViewCell {
    
    //MARK: - Variables
    public static var reuseId = "AddPhotoCollectionCell"
    weak var customDelegate: AddPhotoCollectionCellDelegate?
    //MARK: - Controls

    private var plusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Frame 24"), for: .normal)
        return button
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupHierarchy()
        setupConstraints()
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .grey1
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
    
    @objc private func plusButtonTapped() {
        customDelegate?.addButtonTapped(view: self)
    }
    
    //MARK: - Layout
    private func setupHierarchy() {
        addSubview(plusButton)
    }
    
    private func setupConstraints() {
        plusButton.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
}

