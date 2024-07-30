//
//  MainTabBarController.swift
//  SwiftDemo
//
//  Created by june on 2024/7/10.
//

import UIKit

struct TabBarInfo {
    let edge: UIEdgeInsets
    let height: CGFloat
    let width: CGFloat
    let itemWidth: CGFloat
    let defaultColor: UIColor
    let focusColor: UIColor
    
    init() {
        let horizontalSpace: CGFloat = UIScreen.main.bounds.size.width * 0.064
        self.edge = UIEdgeInsets(top: 0, left: horizontalSpace, bottom: 22, right: horizontalSpace)
        self.height = 50
        self.width = UIScreen.main.bounds.size.width - self.edge.left - self.edge.right
        // bar width - tabbar radius / item count
        self.itemWidth = (self.width - self.height) / 4
        self.defaultColor = .gray7
        self.focusColor = .orange1
    }
}

class MainTabBarController: UITabBarController {

    private var tabBarInfo: TabBarInfo = TabBarInfo()
    
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
            let pageController: UIViewController = type.controller
            let navigationController = UINavigationController(rootViewController: pageController)
            let image = UIImage(named: type.imageName)?.withRenderingMode(.alwaysOriginal)
            let tabBarItem = UITabBarItem(title: type.rawValue, image: image, selectedImage: image)
            navigationController.tabBarItem = tabBarItem
            return navigationController
        }
    }
    
    /// tabbar layout
    private func setupTabBarBackgroundView() {
        let backgroundView = UIView(frame: CGRect(x: self.tabBarInfo.edge.left, y: 0, width: self.tabBarInfo.width, height: self.tabBarInfo.height))
        backgroundView.backgroundColor = .white
        backgroundView.layer.cornerRadius = self.tabBarInfo.height / 2
        backgroundView.layer.shadowColor = UIColor.black.cgColor
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: 4)
        backgroundView.layer.shadowRadius = 8
        backgroundView.layer.shadowOpacity = 0.12
        self.tabBar.addSubview(backgroundView)
        self.tabBar.sendSubviewToBack(backgroundView)
    }
    
    private func setupTabBarConfig() {
        let tabBarItemCount = CGFloat(self.tabBar.items?.count ?? 0)
        let availableSpace = self.tabBarInfo.width - (tabBarItemCount * self.tabBarInfo.itemWidth)
        let itemSpacing = tabBarItemCount == 0 ? 0 : availableSpace / tabBarItemCount
        
        let itemPositioning: UITabBar.ItemPositioning = .centered
        
        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .clear
            appearance.shadowColor = .clear
            appearance.stackedItemPositioning = itemPositioning
            appearance.stackedItemSpacing = itemSpacing
            appearance.stackedItemWidth = self.tabBarInfo.itemWidth
            
            let itemAppearance = UITabBarItemAppearance()
            itemAppearance.normal.titleTextAttributes = [.foregroundColor: self.tabBarInfo.defaultColor]
            itemAppearance.selected.titleTextAttributes = [.foregroundColor: self.tabBarInfo.focusColor]
            itemAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
            itemAppearance.selected.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
            appearance.stackedLayoutAppearance = itemAppearance
            
            self.tabBar.standardAppearance = appearance
            if #available(iOS 15.0, *) {
                self.tabBar.scrollEdgeAppearance = appearance
            }
        } else {
            self.tabBar.itemWidth = self.tabBarInfo.itemWidth
            self.tabBar.itemPositioning = itemPositioning
            self.tabBar.itemSpacing = itemSpacing

            self.tabBar.unselectedItemTintColor = self.tabBarInfo.defaultColor
            self.tabBar.tintColor = self.tabBarInfo.focusColor
            
            self.tabBar.backgroundColor = .clear
            self.tabBar.isTranslucent = true
            self.tabBar.shadowImage = UIImage()
            self.tabBar.backgroundImage = UIImage()
            
            for item in self.tabBar.items! {
                item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
            }
        }
    }
    
    /// setup tabbar frame size and position
    private func setupTabBarFrame() {
        let safeAreaBottomHeight: CGFloat = UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.safeAreaInsets.bottom ?? 0
        let spacing: CGFloat = safeAreaBottomHeight == 0 ? self.tabBarInfo.edge.bottom : 0
        let tabBarY = UIScreen.main.bounds.height - safeAreaBottomHeight - spacing - self.tabBarInfo.height
        self.tabBar.frame = CGRect(x: 0.0, y: tabBarY, width: UIScreen.main.bounds.width, height: self.tabBarInfo.height + safeAreaBottomHeight)
    }
}
