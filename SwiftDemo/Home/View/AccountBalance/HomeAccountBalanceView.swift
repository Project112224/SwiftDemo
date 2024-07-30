//
//  HomeAccountBalanceTableViewCell.swift
//  SwiftDemo
//
//  Created by june on 2024/7/10.
//

import UIKit

class HomeAccountBalanceView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var myAccountBalanceLabel: UILabel!
    @IBOutlet weak var eyeButton: UIButton!
    @IBOutlet weak var usdCurrcyLabel: UILabel!
    @IBOutlet weak var usdBalanceLabel: UILabel!
    @IBOutlet weak var khrCurrcyLabel: UILabel!
    @IBOutlet weak var khrBalanceLabel: UILabel!
    
    @IBAction func eyeAction(_ sender: Any) {
        self.eyeButton.isSelected.toggle()
        UserDefaults.isMaskBalance = self.eyeButton.isSelected
        self.bindLabelInfo()
    }
    
    var model: HomeAccountBindModel?
    
    var isLoading: Bool = true
    
    init() {
        super.init(frame: CGRect.zero)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        configureUI()
    }
}

extension HomeAccountBalanceView {
    private func configureUI() {
        self.contentView = self.loadNib()
        self.layoutUI()
        self.settingUI()
        self.bindBalance(nil)
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
    
    private func settingUI() {
        self.myAccountBalanceLabel.textColor = .gray5
        self.usdCurrcyLabel.textColor = .gray7
        self.khrCurrcyLabel.textColor = .gray7
        self.usdBalanceLabel.textColor = .gray8
        self.khrBalanceLabel.textColor = .gray8
        
        self.eyeButton.isSelected = UserDefaults.isMaskBalance
    }
    
    func bindBalance(_ model: HomeAccountBindModel?) {
        if (model == nil) && self.isLoading {
            self.showLabelSkeleton()
            return
        }
        self.model = model
        self.bindLabelInfo()
        self.hideLabelSkeleton()
    }
    
    private func bindLabelInfo() {
        self.usdBalanceLabel.text = model?.usd.balanceString
        self.khrBalanceLabel.text = model?.khr.balanceString
    }
    
    private func showLabelSkeleton() {
        self.usdBalanceLabel.showSkeleton(color: (.color240, .color251), size: CGSize(width: 240, height: self.usdBalanceLabel.bounds.height))
        self.khrBalanceLabel.showSkeleton(color: (.color240, .color251))
    }
    
    private func hideLabelSkeleton() {
        self.usdBalanceLabel.hideSkeleton()
        self.khrBalanceLabel.hideSkeleton()
    }
}
