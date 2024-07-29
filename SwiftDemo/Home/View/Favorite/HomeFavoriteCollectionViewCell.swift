//
//  HomeFavoriteCollectionViewCell.swift
//  SwiftDemo
//
//  Created by june on 2024/7/10.
//

import UIKit

class HomeFavoriteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    static var nibName: String { String(describing: Self.self) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.nicknameLabel.textColor = .gray6
    }
}

extension HomeFavoriteCollectionViewCell {
    func configureCell(model: HomeFavoriteInfoModel) {
        if let type = TransType(rawValue: model.transType) {
            self.favoriteImageView.image = UIImage(named: type.imageName)
        }
        self.nicknameLabel.text = model.nickname
    }
}
