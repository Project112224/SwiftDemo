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
    
    func configureCell(model: HomeAdBannerInfoModel) {
        self.bannerImageView.loadImage(urlString: model.linkUrl)
    }
}
