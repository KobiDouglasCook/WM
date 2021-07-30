//
//  SceneDelegate.swift
//  I-WarnerMedia
//
//  Created by Kobi Cook on 7/28/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let navVC = UINavigationController(rootViewController: MainVC())
        window.rootViewController = navVC
        window.makeKeyAndVisible()
        self.window = window
    }


}

