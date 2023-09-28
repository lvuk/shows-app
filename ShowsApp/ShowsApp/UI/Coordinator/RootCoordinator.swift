//
//  RootCoordinator.swift
//  ShowsApp
//
//  Created by Luka Vuk on 27.09.2023..
//

import Foundation
import UIKit
import SwiftUI

final class BaseNavigationController: UINavigationController {}

final class RootCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator]?
    
    func start() -> UIViewController {
        return showRootView()
    }
    
    private func showRootView() -> UIViewController {
        let tabBarController = UITabBarController()
        
        let searchCoordinator = SearchCoordinator()
        let favoritesCoordinator = FavoritesCoordinator()
        let homeCoordinator = HomeCoordinator()
        
//        let searchTab = UIHostingController(rootView: SearchView(coordinator: searchCoordinator))
//        let favoritesTab = UIHostingController(rootView: FavoritesView())
//        let homeTab = UIHostingController(rootView: HomeView())
        let searchController = searchCoordinator.start()
        let favoritesController = favoritesCoordinator.start()
        let homeController = homeCoordinator.start()
        
        
        searchController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        favoritesController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), tag: 1)
        homeController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        
        tabBarController.viewControllers = [homeController, favoritesController, searchController]
        
        //MARK: - Customization
        //icons & background
        let tabBarAppearance = UITabBarAppearance()
        
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor(named: "PrimaryLightGrey")
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor(named: "PrimaryYellow")
    
        //text
        let textAttributesNormal: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(named: "PrimaryLightGrey")!
        ]
        let textAttributesSelected: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(named: "PrimaryYellow")!
        ]
        
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = textAttributesNormal
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = textAttributesSelected
        
        tabBarController.tabBar.standardAppearance = tabBarAppearance
        
        return tabBarController
    }
}
