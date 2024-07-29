//
//  HomeAdBannerImageCollectionViewCell.swift
//  SwiftDemo
//
//  Created by june on 2024/7/10.
//

import UIKit

class HomeAdBannerImageCollectionViewCell: UICollectionViewCell {
    
    static var nibName: String { String(describing: Self.self) }
    
    @IBOutlet weak var bannerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}


extension HomeAdBannerImageCollectionViewCell {
    func configureCell(model: HomeAdBannerInfoModel) {
        self.bannerImageView.loadImage(urlString: model.linkUrl)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.openBrowser))
        self.bannerImageView.isUserInteractionEnabled = true
        self.bannerImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func openBrowser() {
        let urlString: String = "https://www.google.com"
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
