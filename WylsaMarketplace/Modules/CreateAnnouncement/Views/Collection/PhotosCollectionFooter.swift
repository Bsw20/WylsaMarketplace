//
//  PhotosCollectionFooter.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 03.03.2022.
//

import Foundation
import UIKit

struct PhotosCollectionFooterViewModel {
    
}

protocol PhotosCollectionFooterDelegate: NSObjectProtocol {
    func nextButtonTapped(view: PhotosCollectionFooter)
}

final class PhotosCollectionFooter: UICollectionReusableView {
    weak var customDelegate: PhotosCollectionFooterDelegate?
    //MARK: - Variables
    static let reuseId = "PhotosCollectionFooter"
    //MARK: - Controls
    
    private var descriptionLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.setStyle(style: .init(font: .ceraPro(style: .normal, size: 13),
                                    textColor: .gray2,
                                    textAlignment: .left,
                                    numberOfLines: 1,
                                    text: "Добавьте описание"
                                    ))
        return label
    }()
    
    private let descriptionTextField: WYTextField = {
        let view = WYTextField(model: .init(placeholder: "Опишите товар"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var nextButton: HSpinnerButton = {
        let button = HSpinnerButton(type: .system)
        button.layer.cornerRadius = 8
        button.setTitle("Далее", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .accentGreen
        button.titleLabel?.font = UIFont.ceraPro(style: .normal, size: 15)
        return button
    }()
    
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            UIStackView(views: [descriptionLabel,
                                descriptionTextField],
                        spacing: 8,
                        axis: .vertical,
                        backgroundColor: .bg1),
            nextButton
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 62
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
        
    }
    
    private func setup() {
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func nextButtonTapped() {
        customDelegate?.nextButtonTapped(view: self)
    }
    
    //MARK: - Layout
    private func setupHierarchy() {
        addSubview(mainStackView)
    }
    
    private func setupConstraints() {
        mainStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(15)
            make.top.equalToSuperview().offset(23)

        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(42)
        }
    }
    
}
