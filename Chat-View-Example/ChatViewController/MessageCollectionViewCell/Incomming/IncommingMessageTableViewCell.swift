//
//  IncommingMessageTableViewCell.swift
//  Chat-View-Example
//
//  Created by Sparkout on 24/10/22.
//

import UIKit

class IncommingMessageTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.addCornerRadius()
        selectionStyle = .none
    }

    func configureView(message: ChatMessage) {
        messageLabel.text = message.message
        configureMessage()
        // Format date
        let date = message.date?.toDate(format: "yyyy-MM-dd HH:mm:ss Z")?.toString(format: "h:mm a")
        timeLabel.text = date
    }
    
    private func configureMessage() {
        // Colors
        let backgroundColor: UIColor = .systemBlue
        let textColor: UIColor = .white
        messageLabel.textColor = textColor
        containerView.backgroundColor = backgroundColor
        containerView.addShadow(backgroundColor.withAlphaComponent(0.3), shadowRadius: 8)
    }
}
