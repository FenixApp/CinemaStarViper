// FilmsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран со списком фильмов
final class FilmsViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let titleText = "Смотри исторические \nфильмы на "
        static let titleLogoText = "CINEMA STAR"
    }

    // MARK: - Visual Components

    private let titleLabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributeString = NSMutableAttributedString(
            string: Constants.titleText,
            attributes: [NSAttributedString.Key.font: UIFont.inter(ofSize: 20)]
        )
        let logoAttributeString = NSAttributedString(
            string: Constants.titleLogoText,
            attributes: [NSAttributedString.Key.font: UIFont.interBold(ofSize: 20)]
        )
        attributeString.append(logoAttributeString)
        label.attributedText = attributeString
        return label
    }()

    private lazy var filmsCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0.5
        layout.itemSize = .init(
            width: Int((UIScreen.main.bounds.width / 2) - 25),
            height: 248
        )
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(
            ShimmerViewCell.self,
            forCellWithReuseIdentifier: String(describing: ShimmerViewCell.self)
        )
        collectionView.register(
            FilmsViewCell.self,
            forCellWithReuseIdentifier: String(describing: FilmsViewCell.self)
        )
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isUserInteractionEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    // MARK: - Public Properties

    var filmsViewModel: FilmsViewModelProtocol?

    // MARK: - Private Properties

    private var viewState: ViewState<[Film]> = .loading {
        didSet {
            filmsCollectionView.reloadData()
            if case .data = viewState {
                filmsCollectionView.isUserInteractionEnabled = true
            }
        }
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        configureUI()
        configureNavigationBar()
        filmsViewModel?.startFetch()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    // MARK: - Private Methods

    private func configureUI() {
        view.setupAppGradientBackground()
        setupTitleLabel()
        setupCollectionView()
    }

    private func configureNavigationBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
        navigationItem.backBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    private func updateView() {
        filmsViewModel?.updateViewState = { [weak self] viewData in
            self?.viewState = viewData
        }
    }

    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -74).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func setupCollectionView() {
        view.addSubview(filmsCollectionView)
        filmsCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 14).isActive = true
        filmsCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        filmsCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        filmsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            .isActive = true
    }
}

// MARK: - FilmsViewController + UICollectionViewDelegate

extension FilmsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? FilmsViewCell else { return }
        filmsViewModel?.showDetailFilm(id: cell.filmId)
    }
}

// MARK: - FilmsViewController + UICollectionViewDataSource

extension FilmsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch viewState {
        case .loading:
            return 10
        case let .data(films):
            return films.count
        default:
            return 0
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch viewState {
        case .loading:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: ShimmerViewCell.self),
                for: indexPath
            ) as? ShimmerViewCell else { return UICollectionViewCell() }
            return cell
        case let .data(films):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: FilmsViewCell.self),
                for: indexPath
            ) as? FilmsViewCell else { return UICollectionViewCell() }
            cell.configureCell(info: films[indexPath.row])
            return cell
        default:
            break
        }
        return UICollectionViewCell()
    }
}
