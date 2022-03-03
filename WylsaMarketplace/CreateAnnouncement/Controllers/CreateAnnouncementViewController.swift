//
//  CreateAnnouncementViewController.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 22.02.2022.
//


import Foundation
import UIKit

class CreateAnnouncementViewController: UIViewController {
    //MARK: - Variables
    
    //MARK: - Controls
    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .bg1
        return view
    }()
    
    private var navigationView: AnouncementNavigationView = {
        let view = AnouncementNavigationView(buttonType: .close)
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
    
    private let productKindView: UIView = {
       let view = ProductKindView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
            UIStackView(views: [descriptionLabel,
                                descriptionTextField],
                        spacing: 8,
                        axis: .vertical,
                        backgroundColor: .bg1),
            nextButton
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.backgroundColor = .bg1
        return stackView
    }()
    
    private var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .bg1
        scrollView.isUserInteractionEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupHierarchy()
        setupConstrains()
    }
    
    private func setup() {
        view.backgroundColor = .bg1
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func nextButtonTapped() {
        present(SetCostViewController(), animated: true, completion: nil)
    }
    
    private func setupHierarchy() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(containerView)
        containerView.addSubview(mainStackView)
    }
    
    private func setupConstrains() {
        mainScrollView.snp.makeConstraints { make in
            make.left.width.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        containerView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(view.safeAreaLayoutGuide.snp.width)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview()
        }
        
//        descriptionTextField.snp.makeConstraints { make in
//            make.bottom.lessThanOrEqualTo(mainScrollView.snp.bottom)
//        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(42)
        }
        
        mainStackView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(60)
            
        }
    }
}

