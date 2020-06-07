//
//  MessageThreadDetailViewController.swift
//  Message Board
//
//  Created by Spencer Curtis on 8/7/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit
import MessageKit

class MessageThreadDetailViewController: MessagesViewController {

    // MARK: - Properties
    
    var messageThread: MessageThread?
    var messageThreadController: MessageThreadController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = messageThread?.title
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddMessage" {
            guard let destinationVC = segue.destination as? MessageDetailViewController else { return }
            
            destinationVC.messageThreadController = messageThreadController
            destinationVC.messageThread = messageThread
        }
    }    
}

extension MessageThreadDetailViewController : MessagesDataSource {
    
    func currentSender() -> SenderType {
        return Sender(senderId: "1", displayName: "Pravin")
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messageThread!.messages[indexPath.section]// return the message at index path
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return (messageThread!.messages.count)// return total number of messages
    }
}

extension MessageThreadDetailViewController : MessagesLayoutDelegate {
    
}

extension MessageThreadDetailViewController : MessagesDisplayDelegate {
    
}
