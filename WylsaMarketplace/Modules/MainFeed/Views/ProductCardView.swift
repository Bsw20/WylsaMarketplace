//
//  ProductCardView.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 05.03.2022.
//

import Foundation
import UIKit

protocol ProductCardViewDelegate: NSObjectProtocol {
    func chatToSellerButtonTapped(view: ProductCardView)
}

final class ProductCardView: UIView {
    
    //MARK: - Variables
    weak var customDelegate: ProductCardViewDelegate?
    
    //MARK: - Controls
    
    private var containerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .grey1
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    private var bottomContainerView: UIView = {
        let view = UIView()
         view.translatesAutoresizingMaskIntoConstraints = false
         view.backgroundColor = .grey1
         return view
    }()
    
    
    private var photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .grey1
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        
        return collectionView
    }()
    
    private var costLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.setStyle(style: .init(font: .ceraPro(style: .normal, size: 22),
                                    textColor: .white,
                                    textAlignment: .left))
        return label
    }()
    
    private var productNameLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.setStyle(style: .init(font: .ceraPro(style: .normal, size: 17),
                                    textColor: .gray2,
                                    textAlignment: .left))
        return label
    }()
    
    private var locationLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.setStyle(style: .init(font: .ceraPro(style: .normal, size: 13),
                                    textColor: .gray2,
                                    textAlignment: .left))
        return label
    }()
    
    private var locationImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "LocationVector")
        return imageView
    }()
    
    private var chatToSellerButton: HSpinnerButton = {
        let button = HSpinnerButton(type: .system)
        button.layer.cornerRadius = 8
        button.setTitle("Написать продавцу", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .accentGreen
        button.titleLabel?.font = UIFont.ceraPro(style: .normal, size: 15)
        return button
    }()
    
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
    
    private func stubInit() {
        costLabel.text = "45 000 ₽"
        productNameLabel.text = "iPhone 11 64Gb"
        locationLabel.text = "Москва"
    }
    
//    public func configure(viewModel: <#ViewModel#>) {
//
//    }
    
    private func setup() {
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        photosCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseId)
        chatToSellerButton.addTarget(self, action: #selector(chatToSellerButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func chatToSellerButtonTapped() {
        customDelegate?.chatToSellerButtonTapped(view: self)
    }
    
    //MARK: - Layout
    private func setupHierarchy() {
        addSubview(containerView)
        containerView.addSubview(photosCollectionView)
        containerView.addSubview(bottomContainerView)

        
        
        bottomContainerView.addSubview(costLabel)
        bottomContainerView.addSubview(productNameLabel)
        bottomContainerView.addSubview(locationLabel)
        bottomContainerView.addSubview(chatToSellerButton)
        bottomContainerView.addSubview(locationImageView)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        photosCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(154)
            make.left.right.equalToSuperview()
        }
        
        bottomContainerView.snp.makeConstraints { make in
            make.top.equalTo(photosCollectionView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(18)
        }
        
        chatToSellerButton.snp.makeConstraints { make in
            make.bottom.left.equalToSuperview()
            make.height.equalTo(36)
            make.width.equalTo(187)
        }
        
        costLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.top.equalTo(costLabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview()
        }
        
        locationImageView.snp.makeConstraints { make in
            make.centerY.equalTo(locationLabel.snp.centerY)
            make.left.equalToSuperview()
        }
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(productNameLabel.snp.bottom).offset(4)
            make.right.equalToSuperview()
            make.left.equalTo(locationImageView.snp.right).offset(6)
        }
        
    }
    
}

extension ProductCardView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseId, for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell()}
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width * 0.8, height: PhotoCollectionViewCell.preferredHeight)
    }
}
