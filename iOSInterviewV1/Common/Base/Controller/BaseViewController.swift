//
//  BaseViewController.swift
//  iOSInterviewV1
//
//  Created by june on 2024/7/10.
//

import UIKit

class BaseViewController: UIViewController {
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let isHiddenNavigation: Bool = self.navigationController?.viewControllers.count ?? 0 == 1
        self.navigationController?.setNavigationBarHidden(isHiddenNavigation, animated: true)
        self.configureUI()
    }
    
}


// MARK: - UI
extension BaseViewController {

    @objc func configureUI() {
        self.view.backgroundColor = .gray1
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    /// 顯示 alert 畫面
    /// - Parameter message: 錯誤訊息
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Api Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
}
