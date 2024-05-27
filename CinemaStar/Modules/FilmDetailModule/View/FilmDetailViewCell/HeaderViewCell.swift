// HeaderViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с картинкой и названием фильма
final class HeaderViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let star = "⭐️ "
    }

    // MARK: - Visual Components

    private let photoFilmImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        return imageView
    }()

    private let filmTitleLabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .inter(ofSize: 18)
        label.textAlignment = .left
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Private Properties

    private var imageRequest: ImageRequest?

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

    func configure(imageUrl: URL, filmName: String, filmRate: Double) {
        filmTitleLabel.text = "\(filmName)\n\(Constants.star) \(filmRate)"
        imageRequest = ImageRequest(url: imageUrl)
        imageRequest?.execute(withCompletion: { [weak self] image in
            self?.photoFilmImageView.image = image
        })
    }

    // MARK: - Private Methods

    private func configureUI() {
        backgroundColor = .clear
        contentView.addSubview(photoFilmImageView)
        contentView.addSubview(filmTitleLabel)

        photoFilmImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        photoFilmImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        photoFilmImageView.widthAnchor.constraint(equalToConstant: 170).isActive = true
        photoFilmImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        photoFilmImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true

        filmTitleLabel.centerYAnchor.constraint(equalTo: photoFilmImageView.centerYAnchor).isActive = true
        filmTitleLabel.leftAnchor.constraint(equalTo: photoFilmImageView.rightAnchor, constant: 16).isActive = true
        filmTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        filmTitleLabel.heightAnchor.constraint(equalToConstant: 110).isActive = true
    }
}
