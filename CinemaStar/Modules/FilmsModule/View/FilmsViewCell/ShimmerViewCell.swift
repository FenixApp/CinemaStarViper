// ShimmerViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Шиммер для ячейки фильма
final class ShimmerViewCell: UICollectionViewCell {
    // MARK: - Visual Components

    private let photoFilmView = ShimmerView()
    private let filmTitleView = ShimmerView()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }

    // MARK: - Private Methods

    private func configureUI() {
        contentView.addSubview(photoFilmView)
        contentView.addSubview(filmTitleView)

        photoFilmView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        photoFilmView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        photoFilmView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        photoFilmView.heightAnchor.constraint(equalToConstant: 200).isActive = true

        filmTitleView.topAnchor.constraint(equalTo: photoFilmView.bottomAnchor, constant: 8).isActive = true
        filmTitleView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        filmTitleView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        filmTitleView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
