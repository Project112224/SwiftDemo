//
//  HomeFunctionListItemCollectionViewCell.swift
//  SwiftDemo
//
//  Created by june on 2024/7/10.
//

import UIKit

class HomeFunctionItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var functionImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static var nibName: String { String(describing: Self.self) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.textColor = .gray7
    }
}

extension HomeFunctionItemCollectionViewCell {
    func configureCell(type: FunctionType) {
        self.functionImageView.image = UIImage(named: type.imageName)
        self.titleLabel.text = type.rawValue
    }
}
