//
//  SharedNavigationView.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 04.03.2022.
//

import Foundation
import UIKit

protocol SharedNavigationViewDelegate: NSObjectProtocol {
    func backButtonTapped(view: SharedNavigationView)
    func sharedButtonTapped(view: SharedNavigationView)
}

final class SharedNavigationView: UIView {
    
    //MARK: - Variables
    weak var customDelegate: SharedNavigationViewDelegate?
    
    //MARK: - Controls
    private var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Group 1"), for: .normal)
        return button
    }()
    
    private var sharedButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Group 2"), for: .normal)
        return button
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
    
    
    private func setup() {
        backgroundColor = .clear
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        sharedButton.addTarget(self, action: #selector(sharedButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func backButtonTapped() {
        customDelegate?.backButtonTapped(view: self)
    }
    
    @objc
    private func sharedButtonTapped() {
        customDelegate?.sharedButtonTapped(view: self)
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for subview in subviews {
            if !subview.isHidden && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
                return true
            }
        }
        return false
    }
    
    //MARK: - Layout
    private func setupHierarchy() {
        addSubview(sharedButton)
        addSubview(backButton)
        
    }
    
    private func setupConstraints() {
        snp.makeConstraints { make in
            make.height.equalTo(45)
        }
        
        backButton.snp.makeConstraints { make in
            make.height.width.equalTo(43)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        sharedButton.snp.makeConstraints { make in
            make.height.width.equalTo(43)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
}
