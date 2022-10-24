//
//  OutgoingMessageTableViewCell.swift
//  Chat-View-Example
//
//  Created by Sparkout on 24/10/22.
//

import UIKit

class OutgoingMessageTableViewCell: UITableViewCell {
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
        configureCell()
        // Format date
        let date = message.date?.toDate(format: "yyyy-MM-dd HH:mm:ss Z")?.toString(format: "h:mm a")
        timeLabel.text = date
    }
    
    private func configureCell() {
        // Colors
        let backgroundColor: UIColor = .lightGray
        let textColor: UIColor = .black
        messageLabel.textColor = textColor
        containerView.backgroundColor = backgroundColor
        containerView.addShadow(backgroundColor.withAlphaComponent(0.3), shadowRadius: 8)
    }
}
