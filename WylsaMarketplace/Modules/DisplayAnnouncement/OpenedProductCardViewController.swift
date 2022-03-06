//
//  OpenedProductCardViewController.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 04.03.2022.
//

import Foundation
import UIKit

class OpenedProductCardViewController: UIViewController {
    //MARK: - Variables
    
    //MARK: - Controls
    private var navigationView: SharedNavigationView = {
        let view = SharedNavigationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var scrollContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .bg1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .bg1
        scrollView.isUserInteractionEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let productView: ProductDescriptionView = {
       let view = ProductDescriptionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let productRecomendationView: ProductRecomendationView = {
       let view = ProductRecomendationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var writeToSellerButton: HSpinnerButton = {
        let button = HSpinnerButton(type: .system)
        button.layer.cornerRadius = 8
        button.setTitle("Написать продавцу", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .accentGreen
        button.titleLabel?.font = UIFont.ceraPro(style: .normal, size: 15)
        return button
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            productView,
            productRecomendationView
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.backgroundColor = .bg1
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupHierarchy()
        setupConstrains()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    private func setup() {
        navigationView.customDelegate = self
        productRecomendationView.customDelegate = self
        writeToSellerButton.addTarget(self, action: #selector(writeToSellerButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func writeToSellerButtonTapped() {
        navigationController?.pushViewController(PersonalChatViewController(), animated: true)
    }
    
    private func setupHierarchy() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(scrollContentView)
//        scrollContentView.addSubview(productView)
        scrollContentView.addSubview(mainStackView)
        scrollContentView.addSubview(writeToSellerButton)
        view.addSubview(navigationView)
    }
    
    private func setupConstrains() {
        mainScrollView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        scrollContentView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            //            make.width.equalTo(view.safeAreaLayoutGuide.snp.width)
            make.width.equalTo(view.snp.width)
            
            //            make.height.equalTo(700)
        }
        
        mainStackView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            //            make.width.equalTo(view.safeAreaLayoutGuide.snp.width)
            make.width.equalTo(view.snp.width)
        }
        
        writeToSellerButton.snp.makeConstraints { make in
            make.height.equalTo(42)
            make.width.equalToSuperview().multipliedBy(0.787)
            make.centerX.equalToSuperview()
            make.top.equalTo(mainStackView.snp.bottom).offset(22)
            make.bottom.equalToSuperview()
        }
        
        NSLayoutConstraint.activate([
            scrollContentView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor)
        ])
        
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(43)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
        }
    }
}

extension OpenedProductCardViewController: SharedNavigationViewDelegate {
    func backButtonTapped(view: SharedNavigationView) {
//        self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
    func sharedButtonTapped(view: SharedNavigationView) {
        print(#function)
    }
    
    
}

extension OpenedProductCardViewController: ProductRecomendationViewDelegate {
    func chatToSellerButtonTapped(view: ProductRecomendationView) {
        navigationController?.pushViewController(PersonalChatViewController(), animated: true)
    }
}
