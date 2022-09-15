//
//  SceneDelegate.swift
//  SpaceX
//
//  Created by Muhammed Celal Tok on 9.09.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let nav = UINavigationController()
        let coordinator = AppCoordinator()
        coordinator.navigationController = nav
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        coordinator.start()
    }
}
