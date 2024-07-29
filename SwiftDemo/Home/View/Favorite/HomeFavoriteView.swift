//
//  HomeFavoriteTableViewCell.swift
//  SwiftDemo
//
//  Created by june on 2024/7/10.
//

import UIKit

class HomeFavoriteView: UIView {
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var myFavoriteLabel: UILabel!
    @IBOutlet weak var moreStackView: UIStackView!
    @IBOutlet weak var moreLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var divideLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var favoriteList: [HomeFavoriteInfoModel] = []
    
    init() {
        super.init(frame: CGRect.zero)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        configureUI()
    }
}

extension HomeFavoriteView {
    private func configureUI() {
        self.contentView = self.loadNib()
        self.layoutUI()
        self.settingUI()
    }
    
    private func layoutUI() {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
    
    private func settingUI() {
        self.myFavoriteLabel.textColor = .gray5
        self.moreLabel.textColor = .gray7
        self.divideLabel.textColor = .gray6
        self.contentLabel.textColor = .gray6
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: HomeFavoriteCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: HomeFavoriteCollectionViewCell.nibName)
    }
    
    
    func bindFavoriteUI(_ model: [HomeFavoriteInfoModel]) {
        self.favoriteList = model
        self.emptyView.isHidden = !model.isEmpty
        self.collectionView.isHidden = model.isEmpty
        self.collectionView.reloadData()
    }
}

extension HomeFavoriteView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.favoriteList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeFavoriteCollectionViewCell.nibName, for: indexPath) as? HomeFavoriteCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard self.favoriteList.count > indexPath.item else {
            return cell
        }
        cell.configureCell(model: self.favoriteList[indexPath.item])
        return cell
    }
}

extension HomeFavoriteView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
}
