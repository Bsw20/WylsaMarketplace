//
//  PhotoCollectionViewCell.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 13.02.2022.
//

import Foundation
import UIKit


class PhotoCollectionViewCell: UICollectionViewCell {
    //MARK: - Variables
    static var reuseId = "PhotoCollectionViewCell"
    static var preferredHeight: CGFloat = 154
    
    private var containerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .grey1
        return view
    }()

    private var mainImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    //MARK: - Object lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        stubInit()
        setupHierarchy()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func stubInit() {
        mainImageView.image = UIImage(named: "PhotoCollectionStubImage")
    }
    
    private func setupHierarchy() {
        addSubview(containerView)
        containerView.addSubview(mainImageView)
    }
    
    private func setupConstrains() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

