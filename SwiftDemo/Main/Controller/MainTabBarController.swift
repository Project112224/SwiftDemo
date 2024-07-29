//
//  MainTabBarController.swift
//  SwiftDemo
//
//  Created by june on 2024/7/10.
//

import UIKit

class MainTabBarController: UITabBarController {

    private let tabBarEdge: UIEdgeInsets = UIEdgeInsets(
        top: 0,
        left: UIScreen.main.bounds.size.width * 0.064,
        bottom: 22,
        right: UIScreen.main.bounds.size.width * 0.064
    )
    private let tabBarHeight: CGFloat = 50
    private var tabBarWidth: CGFloat {
        UIScreen.main.bounds.size.width - self.tabBarEdge.left - self.tabBarEdge.right
    }

    private var itemWidth: CGFloat = 70
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupTabBarFrame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupTabBarFrame()
    }
}

extension MainTabBarController {
    
    private func configureUI() {
        self.setupViewController()
        self.setupTabBarBackgroundView()
        self.setupTabBarConfig()
    }
    
    private func setupViewController() {
        self.viewControllers = MainTabBarItemType.allCases.map { type in
            let rootViewController: UIViewController = type.controller
            let navigationController = UINavigationController(rootViewController: rootViewController)
            let image = UIImage(named: type.imageName)?.withRenderingMode(.alwaysOriginal)
            let tabBarItem = UITabBarItem(title: type.rawValue, image: image, selectedImage: image)
            navigationController.tabBarItem = tabBarItem
            return navigationController
        }
    }
    
    /// 設定 TabBar 外圍圓形邊框
    private func setupTabBarBackgroundView() {
        let backgroundView = UIView(frame: CGRect(x: self.tabBarEdge.left, y: 0, width: self.tabBarWidth, height: self.tabBarHeight))
        backgroundView.backgroundColor = .white
        backgroundView.layer.cornerRadius = self.tabBarHeight / 2
        backgroundView.layer.shadowColor = UIColor.black.cgColor
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: 4)
        backgroundView.layer.shadowRadius = 8
        backgroundView.layer.shadowOpacity = 0.12
        self.tabBar.addSubview(backgroundView)
        self.tabBar.sendSubviewToBack(backgroundView)
    }
    
    private func setupTabBarConfig() {
        self.itemWidth = (self.tabBarWidth - self.tabBarHeight) / 4
        let tabBarItemCount = CGFloat(self.tabBar.items?.count ?? 0)
        let availableSpace = self.tabBarWidth - (tabBarItemCount * self.itemWidth)
        let itemSpacing = tabBarItemCount == 0 ? 0 : availableSpace / tabBarItemCount
        
        let itemPositioning: UITabBar.ItemPositioning = .centered
        let titleTextColor: UIColor = .gray7
        let selectedTitleTextColor: UIColor = .orange1
        
        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .clear
            appearance.shadowColor = .clear
            appearance.stackedItemPositioning = itemPositioning
            appearance.stackedItemSpacing = itemSpacing
            appearance.stackedItemWidth = self.itemWidth
            
            let itemAppearance = UITabBarItemAppearance()
            itemAppearance.normal.titleTextAttributes = [.foregroundColor: titleTextColor]
            itemAppearance.selected.titleTextAttributes = [.foregroundColor: selectedTitleTextColor]
            itemAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
            itemAppearance.selected.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
            appearance.stackedLayoutAppearance = itemAppearance
            
            self.tabBar.standardAppearance = appearance
            if #available(iOS 15.0, *) {
                self.tabBar.scrollEdgeAppearance = appearance
            }
        } else {
            self.tabBar.itemWidth = self.itemWidth
            self.tabBar.itemPositioning = itemPositioning
            self.tabBar.itemSpacing = itemSpacing

            self.tabBar.tintColor = selectedTitleTextColor
            self.tabBar.unselectedItemTintColor = titleTextColor
            
            self.tabBar.backgroundColor = .clear
            self.tabBar.isTranslucent = true
            self.tabBar.shadowImage = UIImage()
            self.tabBar.backgroundImage = UIImage()
            
            for item in self.tabBar.items! {
                item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
            }
        }
    }
    
    /// 設定 TabBar Frame 的大小與位置
    private func setupTabBarFrame() {
        let safeAreaBottomHeight: CGFloat = UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.safeAreaInsets.bottom ?? 0
        let spacing: CGFloat = safeAreaBottomHeight == 0 ? self.tabBarEdge.bottom : 0
        let tabBarY = UIScreen.main.bounds.height - safeAreaBottomHeight - spacing - self.tabBarHeight
        self.tabBar.frame = CGRect(x: 0.0, y: tabBarY, width: UIScreen.main.bounds.width, height: self.tabBarHeight + safeAreaBottomHeight)
    }
}
