//
//  RootCoordinator.swift
//  ShowsApp
//
//  Created by Luka Vuk on 27.09.2023..
//

import Foundation
import UIKit
import SwiftUI

final class BaseNavigationController: UINavigationController { }


final class RootCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    func start() -> UIViewController {
        return showRootView()
    }
    
    let serviceFactory: ServiceFactory
    init(serviceFactory: ServiceFactory) {
        self.serviceFactory = serviceFactory
    }
    
    private func showRootView() -> UIViewController {
        let tabBarController = UITabBarController()
        
        let searchCoordinator = SearchCoordinator(serviceFactory: serviceFactory)
        childCoordinators.append(searchCoordinator)
        let favoritesCoordinator = FavoritesCoordinator(serviceFactory: serviceFactory)
        childCoordinators.append(favoritesCoordinator)
        let homeCoordinator = HomeCoordinator(serviceFactory: serviceFactory)
        childCoordinators.append(homeCoordinator)
        
        let searchController = searchCoordinator.start()
        let favoritesController = favoritesCoordinator.start()
        let homeController = homeCoordinator.start()
        
        
        searchController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        favoritesController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        homeController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        
        tabBarController.viewControllers = [homeController, favoritesController, searchController]
        
        //MARK: - Customization
        //icons & background
        let tabBarAppearance = UITabBarAppearance()

        tabBarAppearance.backgroundColor = UIColor(named: "PrimaryDarkGrey")
        
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor(named: "PrimaryLightGrey")
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor(named: "PrimaryYellow")
        
        tabBarController.tabBar.standardAppearance = tabBarAppearance
        tabBarController.tabBar.scrollEdgeAppearance = tabBarAppearance
    
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
