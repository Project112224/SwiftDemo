//
//  HomeAdBannerTableViewCell.swift
//  iOSInterviewV1
//
//  Created by june on 2024/7/10.
//

import UIKit

class HomeAdBannerView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var nextTimer: Timer?
    
    var bannerList: [HomeAdBannerInfoModel] = []
    
    var currentIndex: Int = 0 {
        didSet {
            guard self.currentIndex > 0 && self.currentIndex < self.bannerList.count - 1 else {
                return
            }
            self.pageControl.currentPage = self.currentIndex - 1
        }
    }
    
    deinit {
        self.nextTimer?.invalidate()
        self.nextTimer = nil
    }
    
    init() {
        super.init(frame: CGRect.zero)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        configureUI()
    }
    
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
        
        self.baseView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.baseView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            self.baseView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            self.baseView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            self.baseView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0)
        ])
    }
    
    private func settingUI() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.isPagingEnabled = true
        
        self.collectionView.register(
            UINib(nibName: HomeAdBannerImageCollectionViewCell.nibName, bundle: nil),
            forCellWithReuseIdentifier: HomeAdBannerImageCollectionViewCell.nibName
        )
    }
    
    func bindBanner(model: [HomeAdBannerInfoModel]) {
        self.bannerList = model
        self.pageControl.numberOfPages = self.bannerList.count
        self.pageControl.currentPage = 0
        self.regroupBannerList()
        self.collectionView.reloadData()
        
        guard self.bannerList.count > 1 else {
            return
        }
        self.currentIndex = 0
        self.collectionView.scrollToItem(
            at: IndexPath(item: self.currentIndex, section: 0),
            at: .centeredHorizontally,
            animated: false
        )
        
        self.nextTimer = Timer.scheduledTimer(
            timeInterval: 3,
            target: self,
            selector: #selector(self.changeNextBanner),
            userInfo: nil,
            repeats: true
        )
        RunLoop.main.add(nextTimer!, forMode: .common)
    }
}

extension HomeAdBannerView {
    
    private func regroupBannerList() {
        guard self.bannerList.count > 1 else {
            return
        }
        let firstBanner = self.bannerList.first!
        let lastBanner = self.bannerList.last!
        
        self.bannerList.append(firstBanner)
        self.bannerList.insert(lastBanner, at: 0)
    }
    
    @objc private func changeNextBanner() {
        self.currentIndex += 1
        if self.bannerList.count - 1 == self.currentIndex {
            self.currentIndex = 0
            self.collectionView.scrollToItem(
                at: IndexPath(item: self.currentIndex, section: 0),
                at: .centeredHorizontally,
                animated: false
            )
            self.changeNextBanner()
        }
        else {
            self.collectionView.scrollToItem(
                at: IndexPath(item: self.currentIndex, section: 0),
                at: .centeredHorizontally,
                animated: true
            )
        }
    }
}

// MARK: - UICollectionViewDataSource
extension HomeAdBannerView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.bannerList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeAdBannerImageCollectionViewCell.nibName, for: indexPath) as? HomeAdBannerImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard self.bannerList.count > indexPath.item else {
            return cell
        }
        cell.configureCell(model: bannerList[indexPath.item])
        return cell
    }
}

// MARK: - UIScrollViewDelegate
extension HomeAdBannerView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize: CGSize = CGSize(width: UIScreen.main.bounds.width, height: 80 * (UIScreen.main.bounds.width / 375))
        return cellSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - HomeAdBannerTableViewCell
extension HomeAdBannerView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let collectionViewRect = CGRect(origin: scrollView.contentOffset, size: scrollView.bounds.size)
        let visiblePoint = CGPoint(x: collectionViewRect.midX, y: collectionViewRect.midY)
        if let index = self.collectionView.indexPathForItem(at: visiblePoint)?.item {
            self.currentIndex = index
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.nextTimer?.invalidate()
        self.nextTimer = nil
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard self.bannerList.count > 1 else {
            return
        }
        self.nextTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(changeNextBanner), userInfo: nil, repeats: true)
        RunLoop.main.add(nextTimer!, forMode: .common)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard self.bannerList.count > 1 else {
            return
        }
        if self.currentIndex == 0 {
            self.currentIndex = self.bannerList.count - 2
            self.collectionView.scrollToItem(
                at: IndexPath(item: self.currentIndex, section: 0),
                at: .centeredHorizontally, 
                animated: false
            )
        } else if self.currentIndex == self.bannerList.count - 1 {
            self.currentIndex = 1
            self.collectionView.scrollToItem(
                at: IndexPath(item: self.currentIndex, section: 0),
                at: .centeredHorizontally,
                animated: false
            )
        }
    }
}
