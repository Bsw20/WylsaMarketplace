//
//  ProductDescriptionView.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 04.03.2022.
//

import Foundation
import UIKit

struct ProductDescriptionViewModel {
}


final class ProductDescriptionView: UIView {
    
    //MARK: - Variables
    
    //MARK: - Controls
    private let containerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .bg1

        return view
    }()
    
    private let bottomContainerView: UIView = {
        let view = UIView()
         view.translatesAutoresizingMaskIntoConstraints = false
         view.backgroundColor = .bg1
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
         return view
    }()
    
    private let bottomInnerContainerView: UIView = {
        let view = UIView()
         view.translatesAutoresizingMaskIntoConstraints = false
         view.backgroundColor = .bg1
         return view
    }()
    
    
    private let photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .grey1
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return collectionView
    }()
    
    private let costLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.setStyle(style: .init(font: .ceraPro(style: .normal, size: 28),
                                    textColor: .white,
                                    textAlignment: .left))
        return label
    }()
    
    private let productNameLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.setStyle(style: .init(font: .ceraPro(style: .normal, size: 28),
                                    textColor: .white,
                                    textAlignment: .left))
        return label
    }()
    
    private let descriptionTitleLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.setStyle(style: .init(font: .ceraPro(style: .normal, size: 13),
                                    textColor: .gray2,
                                    textAlignment: .left,
                                    text: "описание"))
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.setStyle(style: .init(font: .ceraPro(style: .normal, size: 15),
                                    textColor: .white,
                                    textAlignment: .left, numberOfLines: 0))
        return label
    }()
    
    private let userView: UserOnlineDescriptionView = {
       let view = UserOnlineDescriptionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        descriptionLabel.text = "И нет сомнений, что элементы политического процесса набирают популярность среди определенных слоев населения, а значит, должны быть заблокированы в рамках своих."
    }
    
    public func configure(viewModel: ProductDescriptionViewModel) {
        
    }
    
    private func setup() {
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        photosCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseId)
    }
    
    //MARK: - Layout
    private func setupHierarchy() {
        addSubview(containerView)
        containerView.addSubview(photosCollectionView)
        containerView.addSubview(bottomContainerView)
        
        bottomContainerView.addSubview(bottomInnerContainerView)
        
        bottomInnerContainerView.addSubview(costLabel)
        bottomInnerContainerView.addSubview(productNameLabel)
        bottomInnerContainerView.addSubview(descriptionTitleLabel)
        bottomInnerContainerView.addSubview(descriptionLabel)
        bottomInnerContainerView.addSubview(userView)
        
        
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        photosCollectionView.snp.makeConstraints { make in
            make.top.width.centerX.equalToSuperview()
            
            make.height.equalTo(containerView.snp.width).multipliedBy(1.26)
        }
        
        bottomContainerView.snp.makeConstraints { make in
            make.top.equalTo(photosCollectionView.snp.bottom).inset(20)
            make.left.right.bottom.equalToSuperview()
        }
        
        bottomInnerContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(44)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
        }
        
        costLabel.snp.makeConstraints { make in
            make.top.equalTo(productNameLabel.snp.bottom).offset(12)
            make.left.right.equalToSuperview()
        }
        
        descriptionTitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(costLabel.snp.bottom).offset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(descriptionTitleLabel.snp.bottom).offset(4)
        }
        
        userView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(descriptionLabel.snp.bottom).offset(15)
        }
    }
    
}

extension ProductDescriptionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        let width = self.frame.width
        let height = width * 1.26
        
        return CGSize(width: width, height: height)
    }
}

