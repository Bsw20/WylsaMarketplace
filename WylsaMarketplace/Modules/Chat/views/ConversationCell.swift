//
//  ConversationCell.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 05.03.2022.
//

import Foundation
import UIKit

class ConversationCell: UITableViewCell {
    //MARK: - Variables
    private let imageHeight = 64
    public static let reuseId = "ConversationCell"
    //MARK: - Controls
    private var mainContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.backgroundColor = .grey1
        return view
    }()
    
    private var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.image = #imageLiteral(resourceName: "PhotoCollectionStubImage")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 32
        return imageView
    }()
    
    private var usernameLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.setStyle(style: .init(font: .ceraPro(style: .normal, size: 15),
                                    textColor: .white,
                                    textAlignment: .left,
                                    lineBreakMode: .byTruncatingTail))
        return label

    }()
    
    private var lastMessageLabel: UILabel = {
        
        let label = UILabel.newAutoLayout()
        label.setStyle(style: .init(font: .ceraPro(style: .normal, size: 12),
                                    textColor: .gray2,
                                    textAlignment: .left))
        return label
    }()
    
    
    
    private var messageDateLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.setStyle(style: .init(font: .ceraPro(style: .normal, size: 11),
                                    textColor: .gray2,
                                    textAlignment: .right))
        return label
    }()
    
    private var missedMessagesLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.setStyle(style: .init(font: .ceraPro(style: .normal, size: 15),
                                    textColor: .white,
                                    textAlignment: .center))
        label.backgroundColor = .accentGreen
        label.clipsToBounds = true
        label.layer.cornerRadius = 10.5

        return label
    }()
    
    private lazy var centerLabelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            usernameLabel,
            lastMessageLabel
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.backgroundColor = .grey1
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .bg1
        stubInit()
        setupConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        profileImageView.resetUrl()
    }
    
    private func stubInit() {
        usernameLabel.text = "Анна Щедрина"
        messageDateLabel.text = "01.01"
        lastMessageLabel.text = "В целом, конечно, постоянный кол..."
        missedMessagesLabel.isHidden = false
        missedMessagesLabel.text = "1"
        
    }
    
//    public func configure(model: ConversationCellViewModel) {
////        usernameLabel.text = "\(model.name) \(model.lastName)"
////        profileImageView.set(imageURL: model.friendAvatarStringURL)
////        lastMessageLabel.text = model.lastMessageContent
////        #warning("Make convert to days/minutes/sec..")
////        if let date = model.date {
////            messageDateLabel.text = "\(date.timeAgo() )"
////        } else {
////            messageDateLabel.text = ""
////        }
////
////        if model.missedMessagesCount == 0 {
////            missedMessagesLabel.isHidden = true
////        } else {
////            missedMessagesLabel.text = "\(model.missedMessagesCount)"
////        }
//
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Constraints
extension ConversationCell {
    private func setupConstraints() {
        addSubview(mainContainer)
        mainContainer.addSubview(profileImageView)
        mainContainer.addSubview(messageDateLabel)
        mainContainer.addSubview(missedMessagesLabel)
        mainContainer.addSubview(centerLabelsStackView)
        
        mainContainer.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
            make.height.equalTo(84)
//            make.width.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(9)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(imageHeight)
        }
        
        messageDateLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(9)
            make.top.equalToSuperview().offset(20)
        }
        
//        usernameLabel.snp.makeConstraints { (make) in
//            make.top.equalToSuperview().offset(8)
//            make.left.equalTo(profileImageView.snp.right).offset(8)
//            make.right.lessThanOrEqualTo(messageDateLabel.snp.left).inset(21)
//        }
        
        centerLabelsStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(profileImageView.snp.right).offset(8)
            make.right.equalTo(messageDateLabel.snp.left).inset(21)
        }
        
    
        missedMessagesLabel.snp.makeConstraints { (make) in
            make.height.width.equalTo(21)
            make.bottom.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(12)
        }

//        lastMessageLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(usernameLabel.snp.bottom)
//            make.left.equalTo(profileImageView.snp.right).offset(8)
//        }
        
        NSLayoutConstraint.activate([
            lastMessageLabel.trailingAnchor.constraint(equalTo: missedMessagesLabel.leadingAnchor, constant: -20)
        ])
        
    }
}
