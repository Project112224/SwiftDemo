//
//  NotificationInfoTableViewCell.swift
//  iOSInterviewV1
//
//  Created by june on 2024/7/10.
//

import UIKit

class NotificationInfoTableViewCell: UITableViewCell {
    
    // MARK: - Variables and Properties
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.circleView.layer.cornerRadius = self.circleView.frame.width / 2
        self.titleLabel.textColor = .gray10
        self.dateLabel.textColor = .gray10
        self.messageLabel.textColor = .color115
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - Public Method
extension NotificationInfoTableViewCell {
    func configureCell(model: NotificationMessageModel) {
        self.circleView.isHidden = !model.status
        self.titleLabel.text = model.title
        self.dateLabel.text = model.updateDateTime
        self.messageLabel.text = model.message
    }
}
