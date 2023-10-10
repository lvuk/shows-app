//
//  HomeCoordinator.swift
//  ShowsApp
//
//  Created by Luka Vuk on 28.09.2023..
//

import Foundation
import UIKit
import SwiftUI

final class HomeCoordinator: Coordinator {
    private var navigationController: BaseNavigationController = BaseNavigationController()
    let serviceFactory: ServiceFactory
    
    init(serviceFactory: ServiceFactory) {
        self.serviceFactory = serviceFactory
    }
    
    func start() -> UIViewController {
        //do smth
        return createHomeController()
    }
    
    private func createHomeController() -> UIViewController {
        let viewModel = HomeViewModel(favoritesService: serviceFactory.favoriteService)
        let homeView = HomeView(viewModel: viewModel)
        let vc = UIHostingController(rootView: homeView)
        
        viewModel.onShowTapped = { show in
            print("Tu sam")
            _ = self.createDetailsView(of: show)
            print("da")
        }
        
        navigationController.navigationBar.prefersLargeTitles = true
//        navigationController.isToolbarHidden = false
        
//        let showAllButton = UIBarButtonItem(title: "Show all", style: .plain, target: self, action: nil)
        
        navigationController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: nil)
        
        navigationController.pushViewController(vc, animated: true)
        return navigationController
    }
    
    private func createDetailsView(of show: Show) -> UIViewController {
        
        let vm = DetailsViewModel(show: show, favoriteService: serviceFactory.favoriteService)
        let detailsView = DetailView(viewModel: vm)
        let vc = UIHostingController(rootView: detailsView)
        navigationController.pushViewController(vc, animated: true)
        
        return navigationController
    }
    
}
