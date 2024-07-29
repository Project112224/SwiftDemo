//
//  HomeTitleTableViewCell.swift
//  SwiftDemo
//
//  Created by june on 2024/7/10.
//

import UIKit

class HomeHeaderView: UIView {

    var isEmptyNotification: Bool = false
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var baseView: UIView!
    
    @IBOutlet weak var notificationButton: UIButton!
    
    init() {
        super.init(frame: CGRect.zero)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        configureUI()
    }
}

extension HomeHeaderView {
    private func configureUI() {
        self.contentView = self.loadNib()
        self.layoutUI()
        self.notificationButton.setTitle("", for: .normal)
    }
    
    private func layoutUI() {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
        self.baseView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.baseView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            self.baseView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            self.baseView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            self.baseView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0)
        ])
    }

    func bindBellUI(isEmptyNotification: Bool = true) {
        self.notificationButton.setImage(UIImage(named: isEmptyNotification ? "home_title_icon_bell_normal" : "home_title_icon_bell_active"), for: .normal)
    }
}
