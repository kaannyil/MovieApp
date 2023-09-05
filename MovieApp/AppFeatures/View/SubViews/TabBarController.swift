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
        
        tabBar.backgroundColor = UIColor(named: "system_background_color")
        tabBar.barTintColor = .systemGray2
        tabBar.tintColor = .systemBlue
        
        tabBarLine()
    }
}
extension TabBarController {

    func tabBarLine() {
        let separatorLine = UIView()
        separatorLine.backgroundColor = .systemBlue
        separatorLine.frame = CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 1.5)

        tabBar.addSubview(separatorLine)
    }
    
    
}
