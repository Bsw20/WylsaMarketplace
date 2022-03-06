//
//  ProductDescriptionViewController.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 05.03.2022.
//

import Foundation
import UIKit

class ProductDescriptionViewController: UIViewController {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupHierarchy()
        setupConstrains()
    }
    
    private func setup() {
        navigationView.customDelegate = self
    }
    
    private func setupHierarchy() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(productView)
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
        
        productView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
            //            make.width.equalTo(view.safeAreaLayoutGuide.snp.width)
            make.width.equalTo(view.snp.width)
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

extension ProductDescriptionViewController: SharedNavigationViewDelegate {
    func backButtonTapped(view: SharedNavigationView) {
//        self.dismiss(animated: true, completion: nil)
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func sharedButtonTapped(view: SharedNavigationView) {
        print(#function)
    }
    
    
}
