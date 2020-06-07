//
//  MessageThread.swift
//  Message Board
//
//  Created by Spencer Curtis on 8/7/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation
import MessageKit

class MessageThread: Codable, Equatable {
    
    let title: String
    var messages: [MessageThread.Message]
    let identifier: String
    
    init(title: String, messages: [MessageThread.Message] = [], identifier: String = UUID().uuidString) {
        self.title = title
        self.messages = messages
        self.identifier = identifier
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let title = try container.decode(String.self, forKey: .title)
        let identifier = try container.decode(String.self, forKey: .identifier)
        if let messages = try container.decodeIfPresent([String: Message].self, forKey: .messages) {
            self.messages = Array(messages.values)
        } else {
            self.messages = []
        }
        
        self.title = title
        self.identifier = identifier
    }
    
    
    struct Message: Codable, Equatable {
        
        let text: String
        let timestamp: Date
        let displayName: String
        
        init(text: String, displayName: String, timestamp: Date = Date()) {
            self.text = text
            self.displayName = displayName
            self.timestamp = timestamp
            
        }
        
        struct Sender: SenderType {
            
            let messagesSenderName: String
            init(messagesSenderName: String) {
                self.messagesSenderName = messagesSenderName
            }
            
            var senderId: String {
                return displayName
            }
            
            var displayName: String {
                return messagesSenderName
            }
        }

    }
    
    static func ==(lhs: MessageThread, rhs: MessageThread) -> Bool {
        return lhs.title == rhs.title &&
            lhs.identifier == rhs.identifier &&
            lhs.messages == rhs.messages
    }
}

// Message Thread -> Mesage -> Sender
extension MessageThread.Message: MessageType {

    var sender: SenderType {
        return Sender(messagesSenderName: displayName)
    }
    var messageId: String {
        return UUID().uuidString
    }
    
    var sentDate: Date {
        return timestamp
    }
    
    var kind: MessageKind {
        return .text(text)
    }
    
}

