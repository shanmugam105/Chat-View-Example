//
//  ChatViewController.swift
//  Chat-View-Example
//
//  Created by Sparkout on 22/10/22.
//

import UIKit

struct ChatMessage {
    let id: String?
    let userId: Int64
    let date: String?
    let message: String?
    let toId:  Int64
    let fromId: Int64
}

class ChatViewController: UIViewController {
    @IBOutlet weak var emptyChatLabel: UILabel!
    @IBOutlet weak var typingIndicator: UIImageView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var chatTableView: UITableView!
    private var uniqueId: String { "\(UUID())".replacingOccurrences(of: "-", with: "") }
    private let userId: Int64 = 1
    private let toId: Int64 = 2
    var allMessages: [ChatMessage] = [] {
        didSet {
            if !allMessages.isEmpty {
                chatTableView.reloadData()
                chatTableView.scrollToBottom(isAnimated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionView()
        configureView()
    }
    
    private func registerCollectionView() {
        chatTableView.separatorStyle = .none
        chatTableView.dataSource = self
        let outMessageNib = UINib(nibName: "OutgoingMessageTableViewCell", bundle: nil)
        chatTableView.register(outMessageNib, forCellReuseIdentifier: "OutgoingMessageTableViewCell")
        let inMessageNib = UINib(nibName: "IncommingMessageTableViewCell", bundle: nil)
        chatTableView.register(inMessageNib, forCellReuseIdentifier: "IncommingMessageTableViewCell")
    }
    
    private func configureView() {
        typingIndicator.loadGif(name: "typing-animation")
        typingIndicator.isHidden = true
        allMessages = PersistenceController.shared.fetchAllMessage().map {
            ChatMessage(id: $0.id, userId: userId, date: $0.date, message: $0.message, toId: $0.toId, fromId: $0.fromId)
        }
        sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
    }
    
    @objc private func sendMessage() {
        guard let message = messageTextField.text else { return }
        sendRandomeMessage(userId: userId, from: userId, to: toId, message: message)
        messageTextField.text = ""
        typingIndicator.isHidden = false
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            DispatchQueue.main.async {
                self.typingIndicator.isHidden = true
                self.sendRandomeMessage(userId: self.toId, from: self.toId, to: self.userId, message: "Random message \(Int.random(in: 1..<5))")
            }
        }
    }
    
    private func sendRandomeMessage(userId: Int64, from: Int64, to: Int64, message: String) {
        let messageDetails = ChatMessage(
            id: uniqueId,
            userId: userId,
            date: "\(Date())",
            message: message,
            toId: to,
            fromId: from
        )
        allMessages.append(messageDetails)
        PersistenceController.shared.saveNewMessage(
            id: messageDetails.id,
            date: messageDetails.date,
            message: message,
            toId: messageDetails.toId,
            fromId: messageDetails.fromId
        )
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptyChatLabel.isHidden = !allMessages.isEmpty
        return allMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = allMessages[indexPath.item]
        if message.fromId == userId {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OutgoingMessageTableViewCell", for: indexPath) as! OutgoingMessageTableViewCell
            cell.configureView(message: message)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IncommingMessageTableViewCell", for: indexPath) as! IncommingMessageTableViewCell
            cell.configureView(message: message)
            return cell
        }
    }
}
