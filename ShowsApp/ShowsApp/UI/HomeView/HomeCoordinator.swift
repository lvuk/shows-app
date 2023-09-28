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
    
    func start() -> UIViewController {
        //do smth
        return createHomeController()
    }
    
    private func createHomeController() -> UIViewController {
        
        let vm = HomeViewModel()
        let homeView = HomeView(viewModel: vm)
        let vc = UIHostingController(rootView: homeView)
        navigationController.pushViewController(vc, animated: true)
        
        return vc
    }
    
}
