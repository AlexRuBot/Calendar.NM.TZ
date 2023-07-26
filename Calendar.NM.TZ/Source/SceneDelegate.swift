//
//  SceneDelegate.swift
//  Calendar.NM.TZ
//
//  Created by Александр Гужавин on 25.07.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        let viewController = CalendarViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.isHidden = false
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}

