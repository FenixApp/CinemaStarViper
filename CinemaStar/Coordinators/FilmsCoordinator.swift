// FilmsCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор основного экрана с подборкой фильмов
final class FilmsCoordinator: BaseCoordinator {
    private var builder: BuilderProtocol?

    var rootViewController: UINavigationController?
    var finishFlow: VoidHandler?

    func setRootViewController(view: UIViewController, builder: BuilderProtocol) {
        rootViewController = UINavigationController(rootViewController: view)
        self.builder = builder
    }

    func logOut() {
        finishFlow?()
    }

    func pushFilmDetailView(id: Int?) {
        let filmDetailView = builder?.makeDetailFilmModule(coordinator: self, id: id)
        rootViewController?.pushViewController(filmDetailView ?? UIViewController(), animated: true)
    }
}
