//
//  TabBarController.swift
//  MovieApp
//
//  Created by Kaan Yıldırım on 1.09.2023.
//

import UIKit.UITabBar

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
            
        let vc1 = UINavigationController(rootViewController: HomeView())
        let vc2 = UINavigationController(rootViewController: WatchListView())
        vc1.tabBarItem.image = UIImage(named: "home")
        vc2.tabBarItem.image = UIImage(named: "watchlist")
        vc1.title = "Home"
        vc2.title = "Watch List"
        setViewControllers([vc1, vc2], animated: true)

        tabBar.barTintColor = UIColor(named: "system_background_color")
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.tintColor = .systemBlue

        // Renkleri sabitlemeye yarıyor. Bunu kullanmadığımız zaman
        // collectionView scroll anında renkler bozuluyor
        let tabBarAppearance = UITabBarAppearance()
        // tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(named: "system_background_color")
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().standardAppearance = tabBarAppearance
        
        // Renkleri sabitlemeye yarıyor. Bunu kullanmadığımız zaman
        // collectionView scroll anında renkler bozuluyor
        let navigationBarAppearance = UINavigationBarAppearance()
        // navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = UIColor(named: "system_background_color")
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        
        
        tabBarLine()
    }
}
extension TabBarController {

    private func tabBarLine() {
        let separatorLine = UIView()
        separatorLine.backgroundColor = .systemBlue
        separatorLine.frame = CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 1.5)

        tabBar.addSubview(separatorLine)
    }
}
