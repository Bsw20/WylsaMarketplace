//
//  ProductPhotoCollectionCell.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 03.03.2022.
//

import Foundation
import UIKit

protocol ProductPhotoCollectionCellDelegate: NSObjectProtocol {
    func deleteButtonTapped(cell: ProductPhotoCollectionCell)
}

struct ProductPhotoCollectionCellViewModel {
    let image: UIImage
}

final class ProductPhotoCollectionCell: UICollectionViewCell {
    
    //MARK: - Variables
    public static var reuseId = "ProductPhotoCollectionCell"
    weak var customDelegate: ProductPhotoCollectionCellDelegate?
    
    //MARK: - Controls
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.image = #imageLiteral(resourceName: "PhotoCollectionStubImage")
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "deleteButtonIcon"), for: .normal)
        button.isHidden = true
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
    
    public func configure(viewModel: ProductPhotoCollectionCellViewModel) {
        imageView.image = viewModel.image
    }
    
    private func setup() {
        backgroundColor = .bg1
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    @objc private func deleteButtonTapped() {
        customDelegate?.deleteButtonTapped(cell: self)
    }
    
    //MARK: - Layout
    private func setupHierarchy() {
        addSubview(imageView)
        addSubview(deleteButton)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(20)
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            
        }
    }
    
}
