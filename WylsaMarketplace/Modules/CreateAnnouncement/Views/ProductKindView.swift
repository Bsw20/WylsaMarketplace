//
//  ProductKindView.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 22.02.2022.
//

import Foundation
import UIKit

struct ProductKindViewModel {
    let productKind: String
}

protocol ProductKindViewDelegate: NSObjectProtocol {
    func viewTapped(view: ProductKindView)
}

final class ProductKindView: UIView {
    
    
    //MARK: - Variables
    weak var customDelegate: ProductKindViewDelegate?
    //MARK: - Controls
    private let containerView: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .grey1
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    private let productKindLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.setStyle(style: .init(font: .ceraPro(style: .normal, size: 15),
                                    textColor: .gray2,
                                    textAlignment: .left,
                                    numberOfLines: 1,
                                    text: "iphone"
                                    ))
        return label
    }()
    
    private let arrowImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "chevron-down")
        return imageView
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
    
    public func configure(viewModel: ProductKindViewModel) {
        productKindLabel.text = viewModel.productKind
    }
    
    private func setup() {
        backgroundColor = .bg1
        containerView.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc
    private func buttonTapped() {
        customDelegate?.viewTapped(view: self)
    }
    
    //MARK: - Layout
    private func setupHierarchy() {
        addSubview(containerView)
        containerView.addSubview(arrowImageView)
        containerView.addSubview(productKindLabel)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.height.equalTo(46)
            make.edges.equalToSuperview()
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(19)
        }
        
        productKindLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(8)
//            make.right.equalTo(arrowImageView.snp.left).inset(10)
        }
    }
    
}
