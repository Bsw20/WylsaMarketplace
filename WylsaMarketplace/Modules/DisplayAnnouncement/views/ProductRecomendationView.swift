//
//  ProductRecomendationView.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 05.03.2022.
//

import Foundation
import UIKit


protocol ProductRecomendationViewDelegate: NSObjectProtocol {
    func chatToSellerButtonTapped(view: ProductRecomendationView)
}

final class ProductRecomendationView: UIView {
    
    //MARK: - Variables
    weak var customDelegate: ProductRecomendationViewDelegate?
    
    //MARK: - Controls
    private var mainContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .bg1
        return view
    }()
    
    private let recomendationsLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.setStyle(style: .init(font: .ceraPro(style: .normal, size: 28),
                                    textColor: .white,
                                    textAlignment: .left,
                                    numberOfLines: 2,
                                    text: "Возможно вам походит"
                                    ))
        return label
    }()
    
    private let productCardView: ProductCardView = {
       let view = ProductCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    init() {
        super.init(frame: .zero)
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
    
    private func setup() {
        productCardView.customDelegate = self
    }
    
    //MARK: - Layout
    private func setupHierarchy() {
        addSubview(mainContainer)
        mainContainer.addSubview(recomendationsLabel)
        mainContainer.addSubview(productCardView)
    }
    
    private func setupConstraints() {
        mainContainer.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        recomendationsLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        productCardView.snp.makeConstraints { make in
            make.top.equalTo(recomendationsLabel.snp.bottom).offset(24)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(318)
        }
        
    }
    
}

extension ProductRecomendationView: ProductCardViewDelegate {
    func chatToSellerButtonTapped(view: ProductCardView) {
        customDelegate?.chatToSellerButtonTapped(view: self)
    }
    
    
}
