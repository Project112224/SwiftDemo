//
//  View.swift
//  SwiftDemo
//
//  Created by june on 2024/7/10.
//

import UIKit

extension UIView {
    
    @discardableResult
    func loadNib<T: UIView>() -> T? {
        guard let loadNib = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil),
              let loadView = loadNib.first as? T else {
            return nil
        }
        self.addSubview(loadView)
        loadView.translatesAutoresizingMaskIntoConstraints = false
        return loadView
    }
    
    /// 顯示 Skeleton 動畫
    /// - Parameters:
    ///   - color: (light: 亮色, dark: 暗色)
    ///   - size: 指定 Skeleton 大小，nil 為元件大小
    func showSkeletonAnimation(color: (light: UIColor, dark: UIColor), size: CGSize? = nil) {
        self.hideSkeletonAnimation()

        // 元件為 label 時值先不顯示
        if let label = self as? UILabel {
            label.text = nil
        }
        
        // Skeleton 相關設定
        let skeletonSize = size == nil ? self.bounds.size : size!
        let skeletonView = UIView()
        skeletonView.backgroundColor = color.dark.withAlphaComponent(0.1)
        skeletonView.frame = CGRect(x: 0, y: 0, width: skeletonSize.width, height: skeletonSize.height)
        
        // 漸層相關設定
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: skeletonSize.width, height: skeletonSize.height)
        gradientLayer.colors = [color.light.cgColor, color.dark.cgColor, color.dark.cgColor, color.light.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.name = String(describing: CAGradientLayer.self)
        
        // 動畫相關設定
        let width = skeletonSize.width
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 2
        animation.fromValue = -width
        animation.toValue = width
        animation.repeatCount = .infinity
        animation.autoreverses = false
        animation.fillMode = .forwards
        gradientLayer.add(animation, forKey: nil)

        skeletonView.clipsToBounds = true
        skeletonView.layer.cornerRadius = 4
        skeletonView.layer.addSublayer(gradientLayer)
        self.addSubview(skeletonView)
    }

    /// 刪除 Skeleton 動畫
    func hideSkeletonAnimation() {
        for view in self.subviews {
            // 找 subviews 是否存在做動畫的 Layer
            guard let isExist = view.layer.sublayers?.contains (where: { $0.name == String(describing: CAGradientLayer.self) }), isExist else {
                continue
            }
            // 存在的話把 view 移除，並結束迴圈
            view.removeFromSuperview()
            break
        }
    }
}
