//
//  AppDelegate.swift
//  iOSInterviewV1
//
//  Created by june on 2024/7/10.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.setNavigationBar()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    
}

// MARK: - Private Method
extension AppDelegate {
    
    func setNavigationBar() {
        // space 15 - default left 8
        let leftSpace = ((15 * UIScreen.main.bounds.width) / 375) - 8
        let backImage = UIImage(named: "arrow_icon_left")?
            .withRenderingMode(.alwaysOriginal)
            .withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -leftSpace, bottom: 0, right: 0))
        let barTintColor = UIColor.gray1
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.shadowColor = .clear
            appearance.titleTextAttributes = [.foregroundColor: UIColor.gray10, .font: UIFont.systemFont(ofSize: 18, weight: .medium)]
            appearance.backgroundColor = barTintColor
            appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().backIndicatorImage = backImage
            UINavigationBar.appearance().backIndicatorTransitionMaskImage = backImage
            UINavigationBar.appearance().barTintColor = barTintColor
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.gray10 , .font: UIFont.systemFont(ofSize: 18, weight: .medium)]
        }
        
        UINavigationBar.appearance().backItem?.title = ""
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().isTranslucent = false
        
    }
}
