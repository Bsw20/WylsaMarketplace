//
//  SetCostViewController.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 26.02.2022.
//

import Foundation
import UIKit


class SetCostViewController: UIViewController {
    //MARK: - Variables
    
    //MARK: - Controls
    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .bg1
        return view
    }()
    
    private var navigationView: AnouncementNavigationView = {
        let view = AnouncementNavigationView(buttonType: .back, title: "Создание объявления")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var setCostView: LabledTextFieldView = {
        let view = LabledTextFieldView(model: .init(titleText: "Укажите цену",
                                                    textfieldPlaceholder: "Цена"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var nextButton: HSpinnerButton = {
        let button = HSpinnerButton(type: .system)
        button.layer.cornerRadius = 8
        button.setTitle("Опубликовать", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .accentGreen
        button.titleLabel?.font = UIFont.ceraPro(style: .normal, size: 15)
        return button
    }()
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.isNavigationBarHidden = true
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.isNavigationBarHidden = false
//    }
//    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupHierarchy()
        setupConstrains()
    }
    
    private func setup() {
        view.backgroundColor = .bg1
        setCostView.mainTextField.becomeFirstResponder()
        setCostView.mainTextField.keyboardType = .numberPad
        navigationView.customDelegate = self
        nextButton.addTarget(self, action: #selector(publicButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func publicButtonTapped() {
        print(#function)
        navigationController?.pushViewController(ProductDescriptionViewController(), animated: true)
    }
    
    private func setupHierarchy() {
        view.addSubview(containerView)
        containerView.addSubview(navigationView)
        containerView.addSubview(setCostView)
        view.addSubview(nextButton)
    }
    
    private func setupConstrains() {
        containerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(16)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).inset(16)
        }
        
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(53)
            make.left.right.equalToSuperview()
            
        }
        
        setCostView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(48)
            make.left.right.bottom.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(42)
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-22)
//            make.bottom.equalTo(view.)
            
        }
        
//        let nextButtond = view.keyboardLayoutGuide.topAnchor.constraint(equalToSystemSpacingBelow: nextButton.bottomAnchor, multiplier: 1.0)
//        let buttonTrailing = view.keyboardLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: loginButton.trailingAnchor, multiplier: 1.0)
//        NSLayoutConstraint.activate([buttonBottom, buttonTrailing])
    }
}

extension SetCostViewController: AnouncementNavigationViewDelegate {
    func backButtonTapped(view: AnouncementNavigationView) {
//        self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
}
