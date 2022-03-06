//
//  PersonalChatViewController.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 06.03.2022.
//

import Foundation
import UIKit
import MessageKit
import InputBarAccessoryView

class PersonalChatViewController: MessagesViewController {
    //MARK: - Variables
    private var messages: [MessageModel] = [
    ] {
        didSet {
            messagesCollectionView.reloadData()
        }
    }
    private lazy var opponentUser: MockUser = .init(senderId: UUID().uuidString, displayName: "Андрей Иванов")
    
    private var user: MockUser = MockUser(senderId: UUID().uuidString, displayName: "Карпунькин Ярослав")
    
    //MARK: - Controls
    private var navigationBar: PersonalChatTitleView = {
        let view = PersonalChatTitleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        view.backgroundColor = .grey1
        navigationBar.customDelegate = self
        
        messages.append(.init(user: opponentUser))
        configureMessageInputBar()
        
        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
            layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
            layout.textMessageSizeCalculator.incomingAvatarSize = .zero
            layout.photoMessageSizeCalculator.outgoingAvatarSize = .zero
            layout.photoMessageSizeCalculator.incomingAvatarSize = .zero
        }
        
        messagesCollectionView.backgroundColor = .bg1
        messageInputBar.delegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messageCellDelegate = self
    }
    
    
    private func configureMessageInputBar() {
        messageInputBar.isTranslucent = false
        messageInputBar.separatorLine.isHidden = true
        messageInputBar.backgroundView.backgroundColor = .bg1
        messageInputBar.inputTextView.backgroundColor = .grey1
        messageInputBar.inputTextView.textColor = .white
        messageInputBar.inputTextView.placeholderTextColor = .white
        messageInputBar.inputTextView.textContainerInset = UIEdgeInsets(top: 14, left: 30, bottom: 14, right: 36)
        messageInputBar.inputTextView.placeholderLabelInsets = UIEdgeInsets(top: 14, left: 36, bottom: 14, right: 36)
        messageInputBar.inputTextView.layer.borderColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        messageInputBar.inputTextView.layer.borderWidth = 0.2
        messageInputBar.inputTextView.layer.cornerRadius = 18.0
        messageInputBar.inputTextView.layer.masksToBounds = true
        messageInputBar.inputTextView.scrollIndicatorInsets = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 0)
        
        
        configureSendButton()
        configureAttachmentsButton()
    }
    
    private func configureSendButton() {
        messageInputBar.sendButton.setImage(UIImage(named: "SendButton"), for: .normal)
        messageInputBar.sendButton.setTitle("", for: .normal)
        messageInputBar.setRightStackViewWidthConstant(to: 50, animated: false)
        messageInputBar.sendButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 6, right: 0)
        messageInputBar.sendButton.setSize(CGSize(width: 50, height: 50), animated: false)
    }
    
    private func configureAttachmentsButton() {
        let cameraItem = InputBarButtonItem(type: .system)
        let cameraImage = UIImage(named: "ChatAttachmentsIcon")
        cameraItem.setImage(cameraImage, for: .normal)
        
//        cameraItem.addTarget(self,
//                             action: #selector(attachmentsButtonPressed),
//                             for: .touchUpInside)
        
        cameraItem.setSize(CGSize(width: 60, height: 30), animated: false)
        
        messageInputBar.leftStackView.alignment = .center
        messageInputBar.setLeftStackViewWidthConstant(to: 50, animated: false)
        
        messageInputBar.setStackViewItems([cameraItem], forStack: .left, animated: false)
        
    }
    
    private func setupHierarchy() {
        messagesCollectionView.removeFromSuperview()
        view.addSubview(navigationBar)
        view.addSubview(messagesCollectionView)
    }
    
    private func setupConstrains() {
        navigationBar.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        messagesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
}


//MARK: - MessagesDataSource
extension PersonalChatViewController: MessagesDataSource  {
    func currentSender() -> SenderType {
        return user
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.item]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return 1
    }
    
    func numberOfItems(inSection section: Int, in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        
        if indexPath.item % 4 == 0 {
            
            return NSAttributedString(string: MessageKitDateFormatter.shared.string(from: message.sentDate),
                                      attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10),
                                                   NSAttributedString.Key.foregroundColor: UIColor.darkGray
                                      ])
        }
        return nil
    }
}

//MARK: - MessagesLayoutDelegate
extension PersonalChatViewController: MessagesLayoutDelegate {
    func footerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize(width: 0, height: 8)
    }
    
    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        if (indexPath.item) % 4 == 0 {
            return 30
        } else {
            return 0
        }
    }
}

//MARK: - MessagesDisplayDelegate
extension PersonalChatViewController: MessagesDisplayDelegate {
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .accentGreen : .grey1
    }
    
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return .white
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        avatarView.isHidden = true
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        return .bubble
    }
    
    //TODO: implement func avatarSize(for message:...) -> CGSize
}
//MARK: - InputBarAccessoryViewDelegate
extension PersonalChatViewController: InputBarAccessoryViewDelegate {
    // Send file
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        print("Sending message")
        guard !text.isEmpty else { return}
        let message = MessageModel(user: user, text: text)
        messages.append(message)
        inputBar.inputTextView.text = ""
    }
    
    
}

extension PersonalChatViewController: MessageCellDelegate {
    
}


extension PersonalChatViewController: PersonalChatTitleViewDelegate {
    func backButtonTapped(view: PersonalChatTitleView) {
        navigationController?.popViewController(animated: true)
    }
}
