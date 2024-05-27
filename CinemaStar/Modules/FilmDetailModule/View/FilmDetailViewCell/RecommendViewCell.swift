// RecommendViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с рекомендациями
final class RecommendViewCell: UITableViewCell {
    // MARK: - Visual Components

    private lazy var recommendCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.1
        layout.minimumInteritemSpacing = 10
        layout.itemSize = .init(
            width: 170,
            height: 240
        )
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(
            RecommendFilmViewCell.self,
            forCellWithReuseIdentifier: String(describing: RecommendFilmViewCell.self)
        )
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        return collectionView
    }()

    // MARK: - Private Properties

    private var recommends: [SimilarMoviesDTO] = []

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }

    // MARK: - Public Methods

    func configureCell(recommends: [SimilarMoviesDTO]) {
        self.recommends = recommends
    }

    // MARK: - Private Methods

    private func configureUI() {
        backgroundColor = .clear
        configureRecommendCollectionView()
    }

    private func configureRecommendCollectionView() {
        contentView.addSubview(recommendCollectionView)

        recommendCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
            .isActive = true
        recommendCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        recommendCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        recommendCollectionView.heightAnchor.constraint(equalToConstant: 240).isActive = true
        recommendCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}

// MARK: - RecommendViewCell + UICollectionViewDataSource

extension RecommendViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recommends.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: RecommendFilmViewCell.self),
            for: indexPath
        ) as? RecommendFilmViewCell else { return UICollectionViewCell() }
        cell.configureCell(recommendFilm: recommends[indexPath.item])
        return cell
    }
}
