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
    
    func start() -> UIViewController {
        //do smth
        return createFavoritesController()
    }
    
    private func createFavoritesController() -> UIViewController {
        
        let vm = FavoritesViewModel()
        let favoritesView = FavoritesView(viewModel: vm)
        let vc = UIHostingController(rootView: favoritesView)
        navigationController.pushViewController(vc, animated: true)
        
        return vc
    }
    
}
