//
//  HomeView.swift
//  iOSInterviewV1
//
//  Created by june on 2024/7/13.
//

import UIKit

extension HomeViewController {
    
    func layoutSetting() {
        self.view.addSubview(self.scrollView)
        var scrollViewTopAnchor = self.scrollView.topAnchor.constraint(
            equalTo: self.view.topAnchor, 
            constant: self.view.safeAreaInsets.top
        )
        scrollViewTopAnchor.priority = .defaultLow
        
        var scrollViewBottomAnchor = self.scrollView.bottomAnchor.constraint(
            equalTo: self.view.bottomAnchor,
            constant: self.view.safeAreaInsets.bottom
        )
        scrollViewBottomAnchor.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            scrollViewTopAnchor,
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            scrollViewBottomAnchor
        ])
        
        self.scrollView.addSubview(self.baseView)
        NSLayoutConstraint.activate([
            self.baseView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1),
            self.baseView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 0),
            self.baseView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 0),
            self.baseView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: 0),
            self.baseView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: 0)
        ])
        
        self.baseView.addSubview(self.headerView)
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 0),
            self.headerView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 0),
            self.headerView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: 0),
            self.headerView.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        
        self.baseView.addSubview(self.accountInfoView)
        NSLayoutConstraint.activate([
            self.accountInfoView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: 0),
            self.accountInfoView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 0),
            self.accountInfoView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: 0)
        ])
        
        self.baseView.addSubview(self.functionCollectionView)
        NSLayoutConstraint.activate([
            self.functionCollectionView.topAnchor.constraint(equalTo: self.accountInfoView.bottomAnchor, constant: 8),
            self.functionCollectionView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 0),
            self.functionCollectionView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: 0),
            self.functionCollectionView.heightAnchor.constraint(equalToConstant: 192)
        ])
        
        self.baseView.addSubview(self.favoriteView)
        NSLayoutConstraint.activate([
            self.favoriteView.topAnchor.constraint(equalTo: self.functionCollectionView.bottomAnchor, constant: 8),
            self.favoriteView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 0),
            self.favoriteView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: 0),
        ])
        
        self.baseView.addSubview(self.adBannerView)
        NSLayoutConstraint.activate([
            self.adBannerView.topAnchor.constraint(equalTo: self.favoriteView.bottomAnchor, constant: 8),
            self.adBannerView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 0),
            self.adBannerView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: 0),
            self.adBannerView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: 0)
        ])
    }
    
}
