//
//  SceneDelegate.swift
//  ShowsApp
//
//  Created by Luka Vuk on 21.09.2023..
//

import Foundation
import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

//        let rootView = RootView()
//
//        let window = UIWindow(windowScene: windowScene)
//        window.rootViewController = UIHostingController(rootView: rootView)
//        self.window = window
//        window.makeKeyAndVisible()

        let rootCoordinator = RootCoordinator()
        window = UIWindow(windowScene: windowScene)
        window?.overrideUserInterfaceStyle = .dark
        window?.rootViewController = rootCoordinator.start()
        window?.makeKeyAndVisible()
    }
}
