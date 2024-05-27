// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        configureWindowScene(scene)
    }

    private func configureWindowScene(_ scene: UIScene) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        let builder = Builder()
        let appCoordinator = AppCoordinator(builder: builder)
        appCoordinator.start()
    }
}
