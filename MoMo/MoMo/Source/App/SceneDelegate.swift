//
//  SceneDelegate.swift
//  MoMo
//
//  Created by Woody Lee on 4/13/24.
//

import Then
import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = RootController(
            localStorage: LocalStorageImpl(
                database: UserDefaults.standard
            )
        )

        self.window = window
        window.makeKeyAndVisible()
    }
}

