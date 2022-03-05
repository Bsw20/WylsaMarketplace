//
//  MainFeedCollectionCell.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 12.02.2022.
//

import Foundation
import UIKit

protocol MainFeedCollectionCellDelegate: NSObjectProtocol {
    func chatToSellerButtonTapped(cell: MainFeedCollectionCell)
}

class MainFeedCollectionCell: UICollectionViewCell {
    //MARK: - Variables
    weak var customDelegate: MainFeedCollectionCellDelegate?
    static var reuseId = "MainFeedCollectionCell"
    static var preferredHeight: CGFloat = 318
    

    private let productCardView: ProductCardView = {
       let view = ProductCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Object lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        stubInit()
        setup()
        setupHierarchy()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func stubInit() {
    }
    
    private func setup() {
        productCardView.customDelegate = self
    }
    
    private func setupHierarchy() {
        addSubview(productCardView)

    }
    
    private func setupConstrains() {
        productCardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
    }
}

extension MainFeedCollectionCell: ProductCardViewDelegate {
    func chatToSellerButtonTapped(view: ProductCardView) {
        customDelegate?.chatToSellerButtonTapped(cell: self)
    }
}
