//
//  PhotosCollectionHeader.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 03.03.2022.
//

import Foundation
import UIKit

struct PhotosCollectionHeaderViewModel {
    let productKind: ProductKind
}

protocol PhotosCollectionHeaderDelegate: NSObjectProtocol {
    func backButtonTapped(view: PhotosCollectionHeader)
    func productKindViewTapped(view: PhotosCollectionHeader)
}

final class PhotosCollectionHeader: UICollectionReusableView {
    
    //MARK: - Variables
    weak var customDelegate: PhotosCollectionHeaderDelegate?
    static let reuseId = "PhotosCollectionHeader"
    //MARK: - Controls
    
    private var containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .bg1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var navigationView: AnouncementNavigationView = {
        let view = AnouncementNavigationView(buttonType: .close, title: "Создание объявления")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    
    private var productKindLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.setStyle(style: .init(font: .ceraPro(style: .normal, size: 13),
                                    textColor: .gray2,
                                    textAlignment: .left,
                                    numberOfLines: 1,
                                    text: "Категория товара"
                                    ))
        return label
    }()
    
    private let productKindView: ProductKindView = {
       let view = ProductKindView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var announcementTitleLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.setStyle(style: .init(font: .ceraPro(style: .normal, size: 13),
                                    textColor: .gray2,
                                    textAlignment: .left,
                                    numberOfLines: 1,
                                    text: "Название объявления"
                                    ))
        return label
    }()
    
    private let announcementTextField: WYTextField = {
        let view = WYTextField(model: .init(placeholder: "Добавьте название"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var photosLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.setStyle(style: .init(font: .ceraPro(style: .normal, size: 13),
                                    textColor: .gray2,
                                    textAlignment: .left,
                                    numberOfLines: 1,
                                    text: "Фотографии товара"
                                    ))
        return label
    }()
    
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            navigationView,
            UIStackView(views: [productKindLabel,
                                productKindView],
                        spacing: 8,
                        axis: .vertical,
                        backgroundColor: .bg1),
            UIStackView(views: [announcementTitleLabel,
                                announcementTextField],
                        spacing: 8,
                        axis: .vertical,
                        backgroundColor: .bg1),
            photosLabel
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.backgroundColor = .bg1
        return stackView
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
    
    public func configure(viewModel: PhotosCollectionHeaderViewModel) {
        self.productKindView.configure(viewModel: .init(productKind: viewModel.productKind.rawValue))
    }
    
    private func setup() {
        backgroundColor = .bg1
        navigationView.customDelegate = self
        productKindView.customDelegate = self
    }
    
    //MARK: - Layout
    private func setupHierarchy() {
        
        addSubview(mainStackView)
    }
    
    private func setupConstraints() {
        mainStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
            make.top.equalToSuperview().offset(20)

        }
    }
    
}

extension PhotosCollectionHeader: AnouncementNavigationViewDelegate {
    func backButtonTapped(view: AnouncementNavigationView) {
        customDelegate?.backButtonTapped(view: self)
    }
    
    
}

extension PhotosCollectionHeader: ProductKindViewDelegate {
    func viewTapped(view: ProductKindView) {
        customDelegate?.productKindViewTapped(view: self)
    }
}
