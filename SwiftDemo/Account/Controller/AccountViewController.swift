//
//  AccountViewController.swift
//  SwiftDemo
//
//  Created by june on 2024/7/10.
//

import UIKit
import SwiftUI
import Combine

class ValueWrapper {
  var value = true
}

class AccountViewModel: ObservableObject {
    @Published var isDisabled = ValueWrapper()
}

class AccountViewController: BaseViewController {

    @StateObject private var viewModel = AccountViewModel()
    
    // AccountUIView
    lazy var accountView: UIView = {
        let vc = UIHostingController(
            rootView: AccountViewUI(isDisabled: $viewModel.isDisabled.value) {
                [weak self] in
                guard let `self` = self else { return }
                self.viewModel.isDisabled.value.toggle()
            }
        )
        let view = vc.view!
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        
        self.view.addSubview(self.accountView)
        NSLayoutConstraint.activate([
            self.accountView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.accountView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        ])
    }
}
