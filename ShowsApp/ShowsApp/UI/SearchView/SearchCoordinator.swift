//
//  SearchCoordinator.swift
//  ShowsApp
//
//  Created by Luka Vuk on 27.09.2023..
//

import Foundation
import UIKit
import SwiftUI


final class SearchCoordinator: Coordinator, ObservableObject {
    private var navigationController: BaseNavigationController = BaseNavigationController()
    let serviceFactory: ServiceFactory
    
    init(serviceFactory: ServiceFactory) {
        self.serviceFactory = serviceFactory
    }
    
    func start() -> UIViewController {
        return createSearchController()
    }
    
    private func createSearchController() -> UIViewController {
        let viewModel = SearchViewModel()
        let searchView = SearchView(viewModel: viewModel)
        let vc = UIHostingController(rootView: searchView)
        
        viewModel.onShowTapped = { show in
            _ = self.createDetailsView(of: show)
            
        }
        
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
