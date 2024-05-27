// FilmDetailViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран c детальным описанием фильма
final class FilmDetailViewController: UIViewController {
    // MARK: - Types

    private enum CellType {
        /// Изображение фильма
        case header
        /// Кнопка "смотреть"
        case watchButton
        /// Информация о фильме
        case info
        /// Рекомендации к фильму
        case recommendation
    }

    // MARK: - Constants

    private enum Constants {
        static let failText = "Упс!"
        static let failMessageText = "Функционал в разработке :("
        static let okText = "Ок"
    }

    // MARK: - Visual Components

    private lazy var detailInfoFilmTableView = {
        let tableView = UITableView()
        tableView.accessibilityAssistiveTechnologyFocusedIdentifiers()
        tableView.allowsSelection = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.isUserInteractionEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(
            ShimmerDetailViewCell.self,
            forCellReuseIdentifier: String(describing: ShimmerDetailViewCell.self)
        )
        tableView.register(HeaderViewCell.self, forCellReuseIdentifier: String(describing: HeaderViewCell.self))
        tableView.register(ButtonViewCell.self, forCellReuseIdentifier: String(describing: ButtonViewCell.self))
        tableView.register(
            DescriptionViewCell.self,
            forCellReuseIdentifier: String(describing: DescriptionViewCell.self)
        )
        tableView.register(RecommendViewCell.self, forCellReuseIdentifier: String(describing: RecommendViewCell.self))
        tableView.dataSource = self
        return tableView
    }()

    // MARK: - Public Properties

    var filmDetailViewModel: FilmDetailViewModelProtocol?

    // MARK: - Private Properties

    private let cellTypes: [CellType] = [.header, .watchButton, .info, .recommendation]

    private var viewState: ViewState<FilmDetail> = .loading {
        didSet {
            if case .data = viewState {
                detailInfoFilmTableView.isUserInteractionEnabled = true
            }
            detailInfoFilmTableView.reloadData()
        }
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureInfoFilmTableView()
        view.setupAppGradientBackground()
        filmDetailViewModel?.startFetch()
        updateView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    // MARK: - Private Methods

    private func configureInfoFilmTableView() {
        view.addSubview(detailInfoFilmTableView)
        detailInfoFilmTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            .isActive = true
        detailInfoFilmTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        detailInfoFilmTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        detailInfoFilmTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func updateView() {
        filmDetailViewModel?.updateViewState = { [weak self] state in
            self?.viewState = state
        }
    }

    private func showAlert() {
        let alert = UIAlertController(
            title: Constants.failText,
            message: Constants.failMessageText,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: Constants.okText, style: .default))
        present(alert, animated: true)
    }
}

// MARK: - FilmDetailViewController + UITableViewDataSource

extension FilmDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewState {
        case .loading:
            return 1
        case .data:
            return cellTypes.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewState {
        case .loading:
            guard let cell = detailInfoFilmTableView
                .dequeueReusableCell(withIdentifier: String(
                    describing: ShimmerDetailViewCell
                        .self
                )) as? ShimmerDetailViewCell else { return UITableViewCell() }
            return cell
        case let .data(detailFilm):
            let cellType = cellTypes[indexPath.row]
            switch cellType {
            case .header:
                guard let cell = detailInfoFilmTableView
                    .dequeueReusableCell(withIdentifier: String(
                        describing: HeaderViewCell
                            .self
                    )) as? HeaderViewCell
                else { return UITableViewCell() }
                cell.configure(imageUrl: detailFilm.poster, filmName: detailFilm.name, filmRate: detailFilm.rating)
                return cell
            case .watchButton:
                guard let cell = detailInfoFilmTableView
                    .dequeueReusableCell(withIdentifier: String(describing: ButtonViewCell.self)) as? ButtonViewCell
                else { return UITableViewCell() }
                cell.watchButtonPressed = { [weak self] in
                    self?.showAlert()
                }
                return cell
            case .info:
                guard let cell = detailInfoFilmTableView
                    .dequeueReusableCell(withIdentifier: String(
                        describing: DescriptionViewCell.self
                    )) as? DescriptionViewCell
                else { return UITableViewCell() }
                cell.configure(film: detailFilm)
                cell.updateTable = { [weak self] in
                    self?.detailInfoFilmTableView.reloadData()
                }
                return cell
            case .recommendation:
                guard let cell = detailInfoFilmTableView
                    .dequeueReusableCell(withIdentifier: String(
                        describing: RecommendViewCell.self
                    )) as? RecommendViewCell
                else { return UITableViewCell() }
                if let recommends = detailFilm.similarMovies {
                    cell.configureCell(recommends: recommends)
                }
                return cell
            }
        default:
            return UITableViewCell()
        }
    }
}
