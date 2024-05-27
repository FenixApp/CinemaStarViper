// ShimmerPersonCollectionCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Шиммер для ячейки с актером
final class ShimmerPersonCollectionCell: UICollectionViewCell {
    // MARK: - Visual Components

    private let personView = ShimmerView()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        configure()
    }

    // MARK: - Private Methods

    private func configure() {
        contentView.addSubview(personView)
        personView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        personView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        personView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        personView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
