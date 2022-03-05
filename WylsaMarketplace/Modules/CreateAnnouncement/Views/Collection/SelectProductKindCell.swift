//
//  SelectProductKindCell.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 04.03.2022.
//

import Foundation
import UIKit

struct SelectProductKindCellViewModel {
    var productKindName: String
}

final class SelectProductKindCell: UITableViewCell {
    
    //MARK: - Variables
    public static var reuseId = "SelectProductKindCell"
    //MARK: - Controls
    private var titleLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.setStyle(style: .init(font: .ceraPro(style: .normal, size: 20),
                                    textColor: .white,
                                    textAlignment: .left,
                                    numberOfLines: 1,
                                    text: "iPhone"
                                    ))
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setupHierarchy()
        setupConstraints()
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(viewModel: SelectProductKindCellViewModel) {
        titleLabel.text = viewModel.productKindName
    }
        
    private func setup() {
        backgroundColor = .bg1
        let bgColorView = UIView()
        bgColorView.backgroundColor = .grey1
        selectedBackgroundView = bgColorView
        
    }
    
    //MARK: - Layout
    private func setupHierarchy() {
        addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(56)
            make.right.equalToSuperview().inset(33)
            make.centerY.equalToSuperview()
        }
    }
    
}
