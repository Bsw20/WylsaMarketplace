//
//  MessageModel.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 06.03.2022.
//

import Foundation
import UIKit
import MessageKit

struct MockUser: SenderType, Equatable {
    var senderId: String
    var displayName: String
}

class MessageModel: Hashable, Comparable, MessageType {
    static func < (lhs: MessageModel, rhs: MessageModel) -> Bool {
        return lhs.sentDate < rhs.sentDate
    }
    
    static func == (lhs: MessageModel, rhs: MessageModel) -> Bool {
        return lhs.messageId == rhs.messageId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(messageId)
    }
    
    init(user: MockUser) {
        self.sender = user
    }
    
    init(user: MockUser, text: String) {
        self.sender = user
        kind = .text(text)
    }
    
    var sender: SenderType
    
    var messageId: String = UUID().uuidString
    
    var sentDate: Date = Date.randomBetween(start: Date.init(timeIntervalSince1970: 0), end: Date())
    
    var kind: MessageKind = .text("Hello, bro!")
    
    
    
}


