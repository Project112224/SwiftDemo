//
//  HomeViewController.swift
//  iOSInterviewV1
//
//  Created by june on 2024/7/10.
//

import UIKit

class HomeViewController: BaseViewController {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(self, action: #selector(self.handleRefreshControlAction), for: .valueChanged)
        return scrollView
    }()
    
    lazy var headerView: HomeHeaderView = {
        let view = HomeHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var accountInfoView: HomeAccountBalanceView = {
        let view = HomeAccountBalanceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var functionCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let width: CGFloat = UIScreen.main.bounds.width / 3
        let height: CGFloat = 96
        flowLayout.itemSize = CGSize(width: width, height: height)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        view.backgroundColor = .clear
        view.dataSource = self
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(
            UINib(nibName: HomeFunctionItemCollectionViewCell.nibName, bundle: nil),
            forCellWithReuseIdentifier: HomeFunctionItemCollectionViewCell.nibName
        )
        return view
    }()
    
    lazy var favoriteView: HomeFavoriteView = {
        let view = HomeFavoriteView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var adBannerView: HomeAdBannerView = {
        let view = HomeAdBannerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewModel = HomeViewModel()
    
    private let notificationAction = CustomSubject<Void>()
    private let refreshAction = CustomSubject<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingViewModel()
    }
    
    
    override func configureUI() {
        super.configureUI()
        self.layoutSetting()
        self.bindUI()
    }
    
    private func bindUI() {
        self.headerView.notificationButton.addTarget(self, action: #selector(self.handleNotificationAction), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleMoreAction))
        self.favoriteView.moreStackView.addGestureRecognizer(tap)
    }
    
    private func settingViewModel() {
        self.loadAPIData()
    }
    
    private func loadAPIData() {
        let input = HomeViewModel.Input(
            refreshAction: self.refreshAction,
            notificationAction: self.notificationAction
        )
        let output: HomeViewModel.Output = self.viewModel.transfer(input: input)
        output.notificationActionResponse.subscribe { [weak self] data in
            guard let `self` = self else { return }
            self.toNotificationPage(data)
        }
        
        output.notificationResponse.subscribe { [weak self] isEmpty in
            guard let `self` = self else { return }
            self.headerView.bindBellUI(isEmptyNotification: isEmpty)
        }
        
        output.favoriteResponse.subscribe { [weak self] favoriteList in
            guard let `self` = self else { return }
            self.favoriteView.bindFavoriteUI(favoriteList)
        }
        
        output.bannerResponse.subscribe { [weak self] bannerList in
            guard let `self` = self else { return }
            self.adBannerView.bindBanner(model: bannerList)
        }
        
        output.accountResponse.subscribe { [weak self] bindModel in
            guard let `self` = self else { return }
            self.accountInfoView.isLoading = false
            self.accountInfoView.bindBalance(bindModel)
        }
        
        output.refreshResponse.subscribe { [weak self] status in
            guard let `self` = self else { return }
            self.scrollView.refreshControl?.endRefreshing()
        }
        
        output.errorResponse.subscribe { [weak self] message in
            guard let `self` = self else { return }
            self.showAlert(message: message)
        }
    }
    
    private func toNotificationPage(_ data: [NotificationMessageModel]) {
        let vc = NotificationViewController()
        vc.viewModel = NotificationViewModel(data: data)
        vc.delegate = self
        vc.hidesBottomBarWhenPushed = true
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Action
extension HomeViewController {
    @objc func handleNotificationAction() {
        self.notificationAction.send(())
    }
    
    @objc func handleRefreshControlAction() {
        self.refreshAction.send(())
    }
    
    @objc func handleMoreAction() {
        print("touch more event")
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("test: \(indexPath.row)")
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FunctionType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeFunctionItemCollectionViewCell.nibName, for: indexPath) as? HomeFunctionItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard FunctionType.allCases.count > indexPath.item else {
            return cell
        }
        cell.configureCell(type: FunctionType.allCases[indexPath.item])
        return cell
    }
}

// MARK: - NotificationViewControllerDelegate
extension HomeViewController: NotificationViewControllerDelegate {

    func update(notificationList: [NotificationMessageModel]) {
        self.headerView.bindBellUI(isEmptyNotification: notificationList.isEmpty)
    }
    
}
