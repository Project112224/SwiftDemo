//
//  ServiceViewController.swift
//  SwiftDemo
//
//  Created by june on 2024/7/10.
//

import UIKit

class ServiceViewController: BaseViewController {

    lazy var messageLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String(describing: Self.self)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        super.configureUI()
        
        self.view.addSubview(self.messageLabel)
        NSLayoutConstraint.activate([
            self.messageLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.messageLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
}
