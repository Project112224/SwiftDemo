//
//  NotificationViewController.swift
//  SwiftDemo
//
//  Created by june on 2024/7/10.
//

import UIKit

protocol NotificationViewControllerDelegate: AnyObject {
    func update(notificationList: [NotificationMessageModel])
}

class NotificationViewController: BaseViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    
    var viewModel: NotificationViewModel?
    
    weak var delegate: NotificationViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Notification"
    }
    
    override func configureUI() {
        super.configureUI()
        self.layoutUI()
        self.bindUI()
        self.loadAPIData()
    }
    
    private func bindUI() {
        self.tableView.reloadData()
    }
    
    private func loadAPIData() {
        let input = NotificationViewModel.Input()
        let output = self.viewModel?.transfer(input: input)
        
        output?.initNotificationResponse.subscribe({ [weak self] status in
            guard let `self` = self else { return }
            self.delegate?.update(notificationList: self.viewModel?.notificationList ?? [])
            self.tableView.reloadData()
        })
    }
}

// MARK: - Action
extension NotificationViewController {
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension NotificationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("index: \(indexPath.row)")
    }
    
}

extension NotificationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.notificationList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.cellLoadWithIdentifier(NotificationInfoTableViewCell.self, indexPath: indexPath) as? NotificationInfoTableViewCell,
              let viewModel = self.viewModel else {
            return UITableViewCell()
        }
        guard viewModel.notificationList.count > indexPath.row else {
            return cell
        }
        cell.configureCell(model: viewModel.notificationList[indexPath.row])
        return cell
    }
}
