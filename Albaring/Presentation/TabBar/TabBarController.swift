//
//  TabBarController.swift
//  Albaring
//
//  Created by 임대진 on 7/11/24.
//

import UIKit
import SnapKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
//        addShadowToTabBar()
        UITabBar.appearance().backgroundColor = .secondarySystemBackground
        UITabBar.appearance().tintColor = .gray
    }
    
    private func configureTabBar() {
        let viewController1 = UINavigationController(rootViewController: HomeView())
        let viewController2 = UINavigationController(rootViewController: HomeView())
        let viewController3 = UINavigationController(rootViewController: HomeView())
        let viewController4 = UINavigationController(rootViewController: HomeView())
        
        viewController1.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), tag: 0)
        viewController2.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "message"), tag: 1)
        viewController3.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "bell"), tag: 2)
        viewController4.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person"), tag: 3)
        
        viewController1.navigationBar.prefersLargeTitles = false
        viewController2.navigationBar.prefersLargeTitles = false
        viewController3.navigationBar.prefersLargeTitles = false
        viewController4.navigationBar.prefersLargeTitles = false
        
        self.viewControllers = [viewController1, viewController2, viewController3, viewController4]
    }
    
    private func addShadowToTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = UIColor.clear
        appearance.backgroundColor = .secondarySystemBackground
        tabBar.standardAppearance = appearance
        tabBar.tintColor = .gray
        tabBar.layer.masksToBounds = false
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.2
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 6
    }
}
