// AppCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Главный координатор
final class AppCoordinator: BaseCoordinator {
    private var builder: BuilderProtocol

    init(builder: BuilderProtocol) {
        self.builder = builder
    }

    override func start() {
        showFilmsModule()
    }

    private func showFilmsModule() {
        let filmsCoordinator = FilmsCoordinator()
        filmsCoordinator.setRootViewController(
            view: builder.makeFilmsModule(coordinator: filmsCoordinator),
            builder: builder
        )
        setAsRoot​(​_​: filmsCoordinator.rootViewController ?? UIViewController())
    }
}
