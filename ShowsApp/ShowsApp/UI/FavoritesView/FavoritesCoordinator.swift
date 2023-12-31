//
//  FavoritesCoordinator.swift
//  ShowsApp
//
//  Created by Luka Vuk on 28.09.2023..
//

import Foundation
import UIKit
import SwiftUI

final class FavoritesCoordinator: Coordinator {
    
    private var navigationController: BaseNavigationController = BaseNavigationController()
    let serviceFactory: ServiceFactory
    
    init(serviceFactory: ServiceFactory) {
        self.serviceFactory = serviceFactory
    }
    
    func start() -> UIViewController {
        //do smth
        return createFavoritesController()
    }
    
    private func createFavoritesController() -> UIViewController {
        
        let viewModel = FavoritesViewModel(favoritesService: serviceFactory.favoriteService)
        let favoritesView = FavoritesView(viewModel: viewModel)
        let vc = UIHostingController(rootView: favoritesView)
        
        viewModel.onShowTapped = { [weak self] show in
            _ = self?.createDetailsView(of: show)
        }
        
        navigationController.navigationBar.prefersLargeTitles = true
        
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
