//
//  MainTabBarController.swift
//  instagramCloneApp
//
//  Created by Ashraf on 14/02/22.
//

import UIKit

class MainTabBarController: UITabBarController{
    
//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customiseTabbarAppearance()
        configureViewControllers()
    }
    
//    MARK: - Helper
    
    func customiseTabbarAppearance(){
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .clear
        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = appearance
    }
    
    func configureViewControllers(){
        
        view.backgroundColor = .white
        
        let feed = templateNavigationController(selectedImage: UIImage(named: "home_selected")!, unselectedImage: UIImage(named: "profile_unselected")!, rootVc: FeedViewController())
        let search = templateNavigationController(selectedImage: UIImage(named: "search_selected")!, unselectedImage: UIImage(named: "search_selected")!, rootVc: SearchViewController())
        let image = templateNavigationController(selectedImage: UIImage(named: "plus_unselected")!, unselectedImage: UIImage(named: "plus_unselected")!, rootVc: ImageViewController())
        let notification = templateNavigationController(selectedImage: UIImage(named: "like_selected")!, unselectedImage: UIImage(named: "like_selected")!, rootVc: NotificationViewController())
        let profile = templateNavigationController(selectedImage: UIImage(named: "profile_selected")!, unselectedImage: UIImage(named: "profile_selected")!, rootVc: ProfileViewController())
        
        self.setViewControllers([feed, search, image, notification, profile], animated: false)
        tabBar.tintColor = .black
        
    }
    
    func templateNavigationController(selectedImage: UIImage, unselectedImage: UIImage, rootVc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootVc)
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .clear
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.compactAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = appearance
        
        nav.navigationBar.tintColor = .white
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .black
        return nav
    }
    
    
}
